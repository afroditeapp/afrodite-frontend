
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/utils/root_page.dart";


import 'package:openapi/api.dart';


const defaultServerAddress = "http://10.0.2.2:3000";

class ApiProvider {
  ApiClient _apiClient;
  ApiKeyAuth? _apiKey;
  AccountApi _account;
  ProfileApi _profile;
  MediaApi _media;

  String _serverAddress;

  AccountApi get account => _account;
  ProfileApi get profile => _profile;
  MediaApi get media => _media;
  String get serverAddress => _serverAddress;

  ApiProvider() :
    this.withClient(ApiClient(basePath: defaultServerAddress), defaultServerAddress);

  ApiProvider.withClient(ApiClient client, String serverAddress) :
    _serverAddress = serverAddress,
    _apiClient = client,
    _account = AccountApi(client),
    _profile = ProfileApi(client),
    _media = MediaApi(client);


  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", "x-api-key");
    auth.apiKey = apiKey.apiKey;
    _apiKey = auth;
    var client = ApiClient(basePath: serverAddress, authentication: auth);
    _apiClient = client;
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }

  void updateServerAddress(String serverAddress) {
    _serverAddress = serverAddress;
    var client = ApiClient(basePath: serverAddress, authentication: _apiKey);
    _apiClient = client;
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }
}
