import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:openapi/api.dart';
import 'package:app/assets.dart';

const accessTokenHeaderName = "x-access-token";

class ApiProvider {
  ApiKeyAuth? _apiKey;
  AccountApi _account;
  AccountAdminApi _accountAdmin;
  ProfileApi _profile;
  ProfileAdminApi _profileAdmin;
  MediaApi _media;
  MediaAdminApi _mediaAdmin;
  CommonApi _common;
  CommonAdminApi _commonAdmin;
  ChatApi _chat;

  String _serverAddress;

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
    var auth = ApiKeyAuth("header", accessTokenHeaderName);
    auth.apiKey = token.token;
    _apiKey = auth;
    _refreshApiClient(serverAddress, auth);
  }

  void updateServerAddress(String serverAddress) {
    _serverAddress = serverAddress;
    _refreshApiClient(serverAddress, _apiKey);
  }

  void _refreshApiClient(String serverAddress, ApiKeyAuth? key) {
    var client = ApiClient(basePath: serverAddress, authentication: key);
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
    final Client client;
    if (kIsWeb) {
      client = Client();
    } else {
      client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    }
    httpClient = client;
    _refreshApiClient(_serverAddress, _apiKey);
  }
}
