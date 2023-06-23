import "dart:collection";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/utils.dart";
import "package:rxdart/rxdart.dart";

import 'package:openapi/manual_additions.dart';


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'image_moderation.freezed.dart';

enum ImageModerationStatus { loading, moderating, moderatingAndNoMoreData }

@freezed
class ImageModerationData with _$ImageModerationData {
  factory ImageModerationData({
    @Default(ImageModerationStatus.loading) ImageModerationStatus state,
    /// Keys are list item keys. Moderation entry is for moderating single
    /// image in the moderation request. One moderation request has reference to
    /// single ModerationRequestEntry, so multiple ModerationRequestEntry
    /// references exists.
  }) = _ImageModerationData;
}

@freezed
class ModerationEntry with _$ModerationEntry {
  factory ModerationEntry({
    ContentId? securitySelfie,
    required ContentId target,
    bool? status,
  }) = _ModerationEntry;
}

@freezed
class ModerationRequestEntry with _$ModerationRequestEntry {
  factory ModerationRequestEntry({
    bool? imageStatus1,
    bool? imageStatus2,
    required Moderation m,
  }) = _ModerationRequestEntry;
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


class ImageModerationBloc extends Bloc<ImageModerationEvent, ImageModerationData> with ActionRunner {
  final MediaRepository media;

  HashMap<int, (ModerationEntry, ModerationRequestEntry, PublishSubject<()>)> moderationData = HashMap();

  ImageModerationBloc(this.media) : super(ImageModerationData()) {
    on<ResetImageModerationData>((_, emit) async {
        moderationData = HashMap();
        emit(ImageModerationData());
    });
    on<GetMoreData>((_, emit) async {
        await runOnce(() async {
          await getMoreModerationRequests();
          await Future<void>.delayed(Duration(seconds: 1));
        });
    });
    on<AddNewData>((data, emit) async {
        final nextIndex = moderationData.length;
        moderationData.putIfAbsent(nextIndex, () {
          return (data.entry, data.requestEntry, PublishSubject());
        },);
        emit(ImageModerationData(
          state: ImageModerationStatus.moderating,
        ));
    });
    on<NoMoreDataAvailable>((data, emit) async {
        emit(ImageModerationData(
          state: ImageModerationStatus.moderatingAndNoMoreData,
        ));
    });
    on<ModerateEntry>((data, emit) async {
      var (entry, requestEntry, updateRelay) = moderationData[data.index] ?? (null, null, null);
      if (entry != null && requestEntry != null && updateRelay != null && (entry.status == null)) {
        entry = entry.copyWith(status: data.accept);
        if (entry.target == requestEntry.m.content.image1) {
          requestEntry = requestEntry.copyWith(imageStatus1: data.accept);
        } else if (entry.target == requestEntry.m.content.image2) {
          requestEntry = requestEntry.copyWith(imageStatus2: data.accept);
        }

        moderationData[data.index] = (entry, requestEntry, updateRelay);

        updateRelay.add(());

        // Check if all moderated
        // TODO: Reject all if first is rejected?
        if (requestEntry.m.content.image2 != null) {
          final imageStatus1 = requestEntry.imageStatus1;
          final imageStatus2 = requestEntry.imageStatus2;
          if (imageStatus1 != null && imageStatus2 != null) {
            await media.handleModerationRequest(requestEntry.m.requestCreatorId, imageStatus1 && imageStatus2);
          }
        } else {
          final imageStatus1 = requestEntry.imageStatus1;
          if (imageStatus1 != null) {
            await media.handleModerationRequest(requestEntry.m.requestCreatorId, imageStatus1);
          }
        }
      }
    });
  }

  Future<void> getMoreModerationRequests() async {
    ModerationList requests = await media.nextModerationListFromServer();

    if (requests.list.isEmpty) {
      add(NoMoreDataAvailable());
    }

    for (Moderation m in requests.list) {
      ModerationRequestEntry requestEntry = ModerationRequestEntry(m: m);
      // Camera image should be possible only for the initial request.
      if (m.content.cameraImage) {
        ModerationEntry e1 = ModerationEntry(target: m.content.image1);
        add(AddNewData(e1, requestEntry));
        final image2 = m.content.image2;
        if (image2 != null) {
          ModerationEntry e2 = ModerationEntry(target: image2, securitySelfie: m.content.image1);
          add(AddNewData(e2, requestEntry));
        }
      } else {
        final securitySelfie = await media.getSecuritySelfie(m.requestCreatorId);
        if (securitySelfie != null) {
          // Only one image per normal moderation request is supported currently.
          final e = ModerationEntry(target: m.content.image1, securitySelfie: securitySelfie);
          add(AddNewData(e, requestEntry));
        }
      }
    }
  }

  Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    return media.getImage(imageOwner, id);
  }
}
