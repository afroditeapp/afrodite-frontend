
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

  String _serverAddress;

  late final Client httpClient;

  AccountApi get account => _account;
  ProfileApi get profile => _profile;
  MediaApi get media => _media;
  String get serverAddress => _serverAddress;

  ApiProvider(String address) :
    this._withClient(ApiClient(basePath: address), address);

  ApiProvider._withClient(ApiClient client, String serverAddress) :
    _serverAddress = serverAddress,
    _account = AccountApi(client),
    _profile = ProfileApi(client),
    _media = MediaApi(client);

  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", accessTokenHeaderName);
    auth.apiKey = apiKey.apiKey;
    _apiKey = auth;
    var client = ApiClient(basePath: serverAddress, authentication: auth);
    client.client = httpClient;
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }

  void updateServerAddress(String serverAddress) {
    _serverAddress = serverAddress;
    var client = ApiClient(basePath: serverAddress, authentication: _apiKey);
    client.client = httpClient;
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }

  Future<void> init() async {
    final client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    httpClient = client;
    _account.apiClient.client = client;
    _profile.apiClient.client = client;
    _media.apiClient.client = client;
  }
}
