


import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:openapi/manual_additions.dart';
import 'package:pihka_frontend/data/api_provider.dart';
import 'package:pihka_frontend/logic/app/main_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepository {
  final ApiProvider api;

  MediaRepository(this.api);


  ApiProvider getMediaApi() {
    return api;
  }


   Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    try {
      final data = await api.media.getImageFixed(
        imageOwner.accountId,
        id.contentId,
      );
      if (data != null) {
        return data;
      }
    } on ApiException catch (e) {
      print("Image loading error ${e}");
    }

    return null;
  }
}
