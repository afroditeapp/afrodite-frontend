


import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/api/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepository {
  final ApiManager api = ApiManager.getInstance();

  MediaRepository();

  Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    final data = await api.media((api) => api.getImageFixed(
      imageOwner.accountId,
      id.contentId,
      false
    ));
    if (data != null) {
      return data;
    } else {
      print("Image loading error");
      return null;
    }
  }

  Future<ContentId?> getProfileImage(AccountIdLight imageOwner, bool isMatch) async {
    final data = await api.media((api) => api.getPrimaryImageInfo(
      imageOwner.accountId,
      isMatch
    ));
    if (data != null) {
      return data.contentId;
    } else {
      print("Image loading error");
      return null;
    }
  }


  Future<ModerationList> nextModerationListFromServer() async {
    return await api.media((api) => api.patchModerationRequestList()) ?? ModerationList();
  }

  Future<void> handleModerationRequest(AccountIdLight accountId, bool accept) async {
    await api.media((api) => api.postHandleModerationRequest(accountId.accountId, HandleModerationRequest(accept: accept)));
  }
}
