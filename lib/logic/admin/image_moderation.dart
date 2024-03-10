import "dart:collection";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/utils.dart";
import "package:rxdart/rxdart.dart";



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
    bool? content0;
    bool? content1;
    bool? content2;
    bool? content3;
    bool? content4;
    bool? content5;
    bool? content6;
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

        // TODO(prod): Support other images than the first two

        entry = entry.copyWith(status: data.accept);
        if (entry.target == requestEntry.m.content.content0) {
          requestEntry.content0 = data.accept;
        } else if (entry.target == requestEntry.m.content.content1) {
          requestEntry.content1 = data.accept;
        }

        // Update background color
        moderationData[data.index]?.add(ImageRow(entry, requestEntry));

        // Check if all moderated
        // TODO: Reject all if first is rejected?
        if (requestEntry.m.content.content2 != null) {
          final imageStatus1 = requestEntry.content0;
          final imageStatus2 = requestEntry.content1;
          if (imageStatus1 != null && imageStatus2 != null) {
            await media.handleModerationRequest(requestEntry.m.requestCreatorId, imageStatus1 && imageStatus2);
          }
        } else {
          final imageStatus1 = requestEntry.content0;
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

    ModerationList requests = await media.nextModerationListFromServer(ModerationQueueType.initialMediaModeration);

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
      final securitySelfie = await media.getSecuritySelfie(m.requestCreatorId);
      if (securitySelfie != null) {
        // Only one image per normal moderation request is supported currently.
        // TODO(prod): support multiple images
        final e = ModerationEntry(target: m.content.content0, securitySelfie: securitySelfie);
        appendImageRow(e, requestEntry);
      } else {
        final pendingSecuritySelfie = await media.getPendingSecuritySelfie(m.requestCreatorId);
        if (pendingSecuritySelfie != null && pendingSecuritySelfie.contentId == m.content.content0.contentId) {
          // Initial moderation request
          ModerationEntry e1 = ModerationEntry(target: m.content.content0);
          appendImageRow(e1, requestEntry);
          final c1 = m.content.content1;
          if (c1 != null) {
            ModerationEntry e2 = ModerationEntry(target: c1, securitySelfie: m.content.content0);
            appendImageRow(e2, requestEntry);
          }
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

  Future<Uint8List?> getImage(AccountId imageOwner, ContentId id) async {
    return media.getImage(imageOwner, id);
  }
}
