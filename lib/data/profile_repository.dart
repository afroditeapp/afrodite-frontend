


import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final ApiManager api = ApiManager.getInstance();

  ProfileRepository();

  Future<Profile?> requestProfile(AccountIdLight id) async {
    return await api.profile((api) => api.getProfile(id.accountId));
  }
}
