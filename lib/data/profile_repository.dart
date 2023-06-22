


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository extends AppSingleton {
  ProfileRepository._private();
  static final _instance = ProfileRepository._private();
  factory ProfileRepository.getInstance() {
    return _instance;
  }

  @override
  Future<void> init() async {
    // nothing to do
  }


  final ApiManager api = ApiManager.getInstance();

  ProfileRepository();

  Future<Profile?> requestProfile(AccountIdLight id) async {
    return await api.profile((api) => api.getProfile(id.accountId));
  }
}
