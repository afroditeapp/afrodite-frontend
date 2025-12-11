import 'dart:io';

import 'package:app/data/notification_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:openapi/api.dart';
import 'package:app/assets.dart';
import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_api_availability/google_api_availability.dart';

// Global CronetEngine instance - only one instance should exist
CronetEngine? _cronetEngine;

class ApiProvider {
  HttpBearerAuth? _auth;
  AccountApi _account;
  AccountAdminApi _accountAdmin;
  ProfileApi _profile;
  ProfileAdminApi _profileAdmin;
  MediaApi _media;
  MediaAdminApi _mediaAdmin;
  CommonApi _common;
  CommonAdminApi _commonAdmin;
  ChatApi _chat;

  final String _serverAddress;

  late final Client httpClient;

  AccountApi get account => _account;
  AccountAdminApi get accountAdmin => _accountAdmin;
  ProfileApi get profile => _profile;
  ProfileAdminApi get profileAdmin => _profileAdmin;
  MediaApi get media => _media;
  MediaAdminApi get mediaAdmin => _mediaAdmin;
  CommonApi get common => _common;
  CommonAdminApi get commonAdmin => _commonAdmin;
  ChatApi get chat => _chat;
  String get serverAddress => _serverAddress;

  ApiProvider(String address) : this._withClient(ApiClient(basePath: address), address);

  ApiProvider._withClient(ApiClient client, String serverAddress)
    : _serverAddress = serverAddress,
      _account = AccountApi(client),
      _accountAdmin = AccountAdminApi(client),
      _profile = ProfileApi(client),
      _profileAdmin = ProfileAdminApi(client),
      _media = MediaApi(client),
      _mediaAdmin = MediaAdminApi(client),
      _common = CommonApi(client),
      _commonAdmin = CommonAdminApi(client),
      _chat = ChatApi(client);

  void setAccessToken(AccessToken token) {
    final auth = HttpBearerAuth();
    auth.accessToken = token.token;
    _auth = auth;
    _refreshApiClient(auth);
  }

  void _refreshApiClient(HttpBearerAuth? auth) {
    final client = ApiClient(basePath: _serverAddress, authentication: auth);
    client.client = httpClient;

    _account = AccountApi(client);
    _accountAdmin = AccountAdminApi(client);
    _profile = ProfileApi(client);
    _profileAdmin = ProfileAdminApi(client);
    _media = MediaApi(client);
    _mediaAdmin = MediaAdminApi(client);
    _common = CommonApi(client);
    _commonAdmin = CommonAdminApi(client);
    _chat = ChatApi(client);
  }

  Future<void> init() async {
    // Allow HTTP connections on Android and iOS
    final isHttps = _serverAddress.startsWith("https");
    final Client client;
    if (kIsWeb) {
      client = Client();
    } else if (Platform.isAndroid && isHttps) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final androidVersion = androidInfo.version.sdkInt;
      if (androidVersion >= ANDROID_8_API_LEVEL) {
        final availability = await GoogleApiAvailability.instance
            .checkGooglePlayServicesAvailability();
        if (availability == GooglePlayServicesAvailability.success) {
          _cronetEngine ??= CronetEngine.build(
            cacheMode: CacheMode.memory,
            cacheMaxSize: 2 * 1024 * 1024, // 2MB cache
            enableBrotli: true,
            enableHttp2: true,
            enableQuic: false,
          );
          client = CronetClient.fromCronetEngine(_cronetEngine!);
        } else {
          // Fall back to IOClient if Google Play Services is not available
          client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
        }
      } else {
        // Use IOClient on Android versions older than 8.0 because
        // Let's Encrypt certificate must be added in that case.
        client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
      }
    } else if (Platform.isIOS && isHttps) {
      final config = URLSessionConfiguration.ephemeralSessionConfiguration()
        ..cache = URLCache.withCapacity(memoryCapacity: 2 * 1024 * 1024);
      client = CupertinoClient.fromSessionConfiguration(config);
    } else {
      client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    }
    httpClient = client;
    _refreshApiClient(_auth);
  }
}
