
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/assets.dart';

const accessTokenHeaderName = "x-api-key";

class ApiProvider {
  ApiKeyAuth? _apiKey;
  AccountApi _account;
  ProfileApi _profile;
  MediaApi _media;
  CommonApi _common;
  CommonadminApi _commonAdmin;

  String _serverAddress;

  late final Client httpClient;

  AccountApi get account => _account;
  ProfileApi get profile => _profile;
  MediaApi get media => _media;
  CommonApi get common => _common;
  CommonadminApi get commonAdmin => _commonAdmin;
  String get serverAddress => _serverAddress;

  ApiProvider(String address) :
    this._withClient(ApiClient(basePath: address), address);

  ApiProvider._withClient(ApiClient client, String serverAddress) :
    _serverAddress = serverAddress,
    _account = AccountApi(client),
    _profile = ProfileApi(client),
    _media = MediaApi(client),
    _common = CommonApi(client),
    _commonAdmin = CommonadminApi(client);

  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", accessTokenHeaderName);
    auth.apiKey = apiKey.apiKey;
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
    _profile = ProfileApi(client);
    _media = MediaApi(client);
    _common = CommonApi(client);
    _commonAdmin = CommonadminApi(client);
  }

  Future<void> init() async {
    final client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    httpClient = client;
    _account.apiClient.client = client;
    _profile.apiClient.client = client;
    _media.apiClient.client = client;
    _common.apiClient.client = client;
    _commonAdmin.apiClient.client = client;
  }
}
