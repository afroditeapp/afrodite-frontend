
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";


import 'package:openapi/api.dart';


const serverAddress = "http://10.0.2.2:3000";

class ApiProvider {
  ApiClient _apiClient;
  AccountApi _account;
  ProfileApi _profile;
  MediaApi _media;

  AccountApi get account => _account;
  ProfileApi get profile => _profile;
  MediaApi get media => _media;

  ApiProvider() :
    this.withClient(ApiClient(basePath: serverAddress));

  ApiProvider.withClient(ApiClient client) :
    _apiClient = client,
    _account = AccountApi(client),
    _profile = ProfileApi(client),
    _media = MediaApi(client);


  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", "x-api-key");
    auth.apiKey = apiKey.apiKey;
    var client = ApiClient(basePath: serverAddress, authentication: auth);
    _apiClient = client;
    _account = AccountApi(client);
    _profile = ProfileApi(client);
    _media = MediaApi(client);
  }
}
