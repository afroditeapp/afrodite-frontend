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

enum ImageModerationStatus { moderating, allModerated }

@freezed
class ImageModerationData with _$ImageModerationData {
  factory ImageModerationData({
    @Default(ImageModerationStatus.moderating) ImageModerationStatus state,
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

class ModerationRequestEntry {
    bool? imageStatus1;
    bool? imageStatus2;
    Moderation m;

    ModerationRequestEntry(this.m);
}

sealed class ImageRowState {}
class AllModerated implements ImageRowState {}
class Loading implements ImageRowState {}
class ImageRow implements ImageRowState {
  final ModerationEntry entry;
  final ModerationRequestEntry requestEntry;
  ImageRow(this.entry, this.requestEntry);
}

abstract class ImageModerationEvent {}
class ModerateEntry extends ImageModerationEvent {
  final int index;
  final bool accept;
  ModerateEntry(this.index, this.accept);
}
class NoMoreDataAvailable extends ImageModerationEvent {}
class ResetImageModerationData extends ImageModerationEvent {}

class ImageModerationBloc extends Bloc<ImageModerationEvent, ImageModerationData> with ActionRunner {
  final MediaRepository media;

  final LinkedHashMap<int, BehaviorSubject<ImageRowState>> moderationData = LinkedHashMap();
  final HashSet<Moderation> alreadyStoredModerations = HashSet();
  bool loadingFromServer = false;
  bool currentLoadTheFirstLoad = true;

  ImageModerationBloc(this.media) : super(ImageModerationData()) {
    on<ResetImageModerationData>((_, emit) async {
        moderationData.clear();
        alreadyStoredModerations.clear();
        currentLoadTheFirstLoad = true;
        emit(ImageModerationData(
          state: ImageModerationStatus.moderating,
        ));
    });
    on<NoMoreDataAvailable>((data, emit) async {
        emit(ImageModerationData(
          state: ImageModerationStatus.allModerated,
        ));
    });
    on<ModerateEntry>((data, emit) async {
      final imageRowState = moderationData[data.index]?.value;
      if (imageRowState is ImageRow && (imageRowState.entry.status == null)) {
        var entry = imageRowState.entry;
        var requestEntry = imageRowState.requestEntry;

        entry = entry.copyWith(status: data.accept);
        if (entry.target == requestEntry.m.content.image1) {
          requestEntry.imageStatus1 = data.accept;
        } else if (entry.target == requestEntry.m.content.image2) {
          requestEntry.imageStatus2 = data.accept;
        }

        // Update background color
        moderationData[data.index]?.add(ImageRow(entry, requestEntry));

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

  Stream<ImageRowState> getImageRow(int index) async* {
    final relay = moderationData[index];

    if (relay == null) {
      for (int i = index; i < index + 100; i++) {
        moderationData.putIfAbsent(i, () => BehaviorSubject.seeded(Loading(), sync: true));
      }

      if (await getMoreModerationRequests()) {
        yield AllModerated();
        return;
      }
    }

    final afterNewModerationRequests = moderationData[index];

    if (afterNewModerationRequests != null) {
      if (afterNewModerationRequests.value is Loading && await getMoreModerationRequests()) {
        yield AllModerated();
      } else {
        yield* afterNewModerationRequests;
      }
    }
  }

  /// Returns true if no more data available
  Future<bool> getMoreModerationRequests() async {
    if (loadingFromServer) {
      return false;
    }
    loadingFromServer = true;

    ModerationList requests = await media.nextModerationListFromServer();

    var noMoreDataAvailable = false;

    if (requests.list.isEmpty) {
      noMoreDataAvailable = true;
      if (currentLoadTheFirstLoad) {
        add(NoMoreDataAvailable());
      }
    }

    currentLoadTheFirstLoad = false;

    for (Moderation m in requests.list) {
      if (alreadyStoredModerations.contains(m)) {
        continue;
      }

      ModerationRequestEntry requestEntry = ModerationRequestEntry(m);
      // Camera image should be possible only for the initial request.
      if (m.content.cameraImage) {
        ModerationEntry e1 = ModerationEntry(target: m.content.image1);
        appendImageRow(e1, requestEntry);
        final image2 = m.content.image2;
        if (image2 != null) {
          ModerationEntry e2 = ModerationEntry(target: image2, securitySelfie: m.content.image1);
          appendImageRow(e2, requestEntry);
        }
      } else {
        final securitySelfie = await media.getSecuritySelfie(m.requestCreatorId);
        if (securitySelfie != null) {
          // Only one image per normal moderation request is supported currently.
          final e = ModerationEntry(target: m.content.image1, securitySelfie: securitySelfie);
          appendImageRow(e, requestEntry);
        }
      }

      alreadyStoredModerations.add(m);
    }

    loadingFromServer = false;
    return noMoreDataAvailable;
  }

  void appendImageRow(ModerationEntry e, ModerationRequestEntry requestEntry) {
    try {
      final first = moderationData.entries.firstWhere(
        (element) {
          return element.value.valueOrNull is Loading;
        },
      );
      first.value.add(ImageRow(e, requestEntry));
    } on StateError catch (_) {
      final nextIndex = moderationData.length;
      final relay = moderationData[nextIndex];
      if (relay != null) {
        relay.add(ImageRow(e, requestEntry));
      } else {
        moderationData[nextIndex] = BehaviorSubject.seeded(ImageRow(e, requestEntry), sync: true);
      }
    }
  }

  Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    return media.getImage(imageOwner, id);
  }
}
