import "dart:collection";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";

import 'package:openapi/manual_additions.dart';


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

//part 'image_moderation.freezed.dart';

enum ImageModerationStatus { loading, moderating, moderatingAndNoMoreData }

// @freezed
// class ImageModerationData with _$ImageModerationData {
//   factory ImageModerationData({
//     @Default(ImageModerationStatus.loading) ImageModerationStatus state,
//     /// Keys are list item keys. Moderation entry is for moderating single
//     /// image in the moderation request. One moderation request has reference to
//     /// single ModerationRequestEntry, so multiple ModerationRequestEntry
//     /// references exists.
//     required HashMap<int, (ModerationEntry, ModerationRequestEntry)> data,
//   }) = _ImageModerationData;
// }


class ImageModerationData {
  final ImageModerationStatus state;
  /// Keys are list item keys. Moderation entry is for moderating single
  /// image in the moderation request. One moderation request has reference to
  /// single ModerationRequestEntry, so multiple ModerationRequestEntry
  /// references exists.
  final HashMap<int, (ModerationEntry, ModerationRequestEntry)> data;
  ImageModerationData({required this.state, required this.data});

  factory ImageModerationData.defaultState() {
    return ImageModerationData(
      state: ImageModerationStatus.loading, data: HashMap()
    );
  }
}


class ModerationEntry {
  ContentId? securitySelfie;
  ContentId target;
  bool? status;

  ModerationEntry(this.target);
}

class ModerationRequestEntry {
  bool? imageStatus1;
  bool? imageStatus2;
  Moderation m;

  ModerationRequestEntry(this.m);
}

abstract class ImageModerationEvent {}
class ModerateEntry extends ImageModerationEvent {
  final int index;
  final bool accept;
  ModerateEntry(this.index, this.accept);
}
class ResetImageModerationData extends ImageModerationEvent {}
class GetMoreData extends ImageModerationEvent {}
class AddNewData extends ImageModerationEvent {
  final ModerationEntry entry;
  final ModerationRequestEntry requestEntry;
  AddNewData(this.entry, this.requestEntry);
}
class NoMoreDataAvailable extends ImageModerationEvent {}


class ImageModerationBloc extends Bloc<ImageModerationEvent, ImageModerationData> {
  final MediaRepository media;
  bool requestOngoing = false;

  ImageModerationBloc(this.media) : super(ImageModerationData.defaultState()) {
    on<ResetImageModerationData>((_, emit) async {
        emit(ImageModerationData.defaultState());
    });
    on<GetMoreData>((_, emit) async {
        if (!requestOngoing) {
          requestOngoing = true;
          await getMoreModerationRequests();
          await Future<void>.delayed(Duration(seconds: 1));
          requestOngoing = false;
        }
    });
    on<AddNewData>((data, emit) async {
        final nextIndex = state.data.length;
        state.data.putIfAbsent(nextIndex, () {
          return (data.entry, data.requestEntry);
        },);
        emit(ImageModerationData(
          data: state.data,
          state: ImageModerationStatus.moderating,
        ));
    });
    on<NoMoreDataAvailable>((data, emit) async {
        emit(ImageModerationData(
          state: ImageModerationStatus.moderatingAndNoMoreData,
          data: state.data,
        ));
    });
    on<ModerateEntry>((data, emit) async {
      final entry = state.data[data.index];
      if (entry != null) {
        entry.$1.status = data.accept;
        if (entry.$1.target == entry.$2.m.content.image1) {
          entry.$2.imageStatus1 = data.accept;
        } else if (entry.$1.target == entry.$2.m.content.image2) {
          entry.$2.imageStatus2 = data.accept;
        }

        emit(ImageModerationData(
          state: state.state,
          data: state.data,
        ));

        // Check if all moderated
        // TODO: Reject all if first is rejected?
        if (entry.$2.m.content.image2 != null) {
          final imageStatus1 = entry.$2.imageStatus1;
          final imageStatus2 = entry.$2.imageStatus2;
          if (imageStatus1 != null && imageStatus2 != null) {
            await handleModerationRequest(entry.$2, imageStatus1 && imageStatus2);
          }
        } else {
          final imageStatus1 = entry.$2.imageStatus1;
          if (imageStatus1 != null) {
            await handleModerationRequest(entry.$2, imageStatus1);
          }
        }
      }
    });
  }

  Future<void> getMoreModerationRequests() async {
    ModerationList requests = await media.api.media.patchModerationRequestList() ?? ModerationList();

    if (requests.list.isEmpty) {
      add(NoMoreDataAvailable());
    }

    for (Moderation m in requests.list) {
      ModerationRequestEntry requestEntry = ModerationRequestEntry(m);
      // Camera image should be possible only for the initial request.
      if (m.content.cameraImage) {
        ModerationEntry e1 = ModerationEntry(m.content.image1);
        add(AddNewData(e1, requestEntry));
        final image2 = m.content.image2;
        if (image2 != null) {
          ModerationEntry e2 = ModerationEntry(image2);
          add(AddNewData(e2, requestEntry));
        }
      } else {
        // Only one image per normal moderation request is supported currently.
        final e = ModerationEntry(m.content.image1);
        e.securitySelfie = m.content.image1; // TODO: get security selfie
        add(AddNewData(e, requestEntry));
      }
    }
  }

  Future<void> handleModerationRequest(ModerationRequestEntry e, bool accept) async {
    await media.api.media.postHandleModerationRequest(
      e.m.requestCreatorId.accountId,
      HandleModerationRequest(accept: accept),
    );
  }

  Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    try {
      final data = await media.api.media.getImageFixed(
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
