import "dart:collection";

import "package:async/async.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/utils/api.dart";
import "package:rxdart/rxdart.dart";


enum ImageModerationStatus {
  loading,
  moderating,
  allModerated,
}

sealed class ContentStatus {}
class ModerationDecicionNeeded implements ContentStatus {
  const ModerationDecicionNeeded();
}
class Accepted implements ContentStatus {}
class Denied implements ContentStatus {}

class ModerationRequestState {
    final List<ContentStatus> list;
    final Moderation m;
    bool sentToServer = false;

    ModerationRequestState(this.m, this.list);

    void sendToServer() async {
      if (list.any((element) => element is ModerationDecicionNeeded)) {
        return;
      }

      if (sentToServer) {
        return;
      }
      sentToServer = true;

      final accpeted = !list.any((element) => element is Denied);
      await MediaRepository.getInstance().handleModerationRequest(m.requestCreatorId, accpeted);
    }
}

sealed class ImageRowState {}
class AllModerated implements ImageRowState {}
class Loading implements ImageRowState {}
class ImageRow implements ImageRowState {
  /// Index to [ModerationRequestState.list]
  final int stateIndex;
  final ContentId? securitySelfie;
  final ContentId target;
  final ContentStatus status;
  final ModerationRequestState state;
  ImageRow(
    this.stateIndex,
    this.state,
    {
      required this.target,
      required this.status,
      this.securitySelfie,
    }
  );

  ImageRow setContentStatus(ContentStatus status) {
    state.list[stateIndex] = status;
    return ImageRow(
      stateIndex,
      state,
      target: target,
      securitySelfie: securitySelfie,
      status: status,
    );
  }
}


class ImageModerationLogic {
  ImageModerationLogic._private();
  static final _instance = ImageModerationLogic._private();
  factory ImageModerationLogic.getInstance() {
    return _instance;
  }

  final media = MediaRepository.getInstance();

  final BehaviorSubject<ImageModerationStatus> _imageModerationStatus =
    BehaviorSubject.seeded(ImageModerationStatus.loading);

  var cacher = ModerationCacher();
  var qType = ModerationQueueType.initialMediaModeration;
  var loadManager = LoadMoreManager();

  Stream<ImageModerationStatus> get imageModerationStatus => _imageModerationStatus.stream;

  void reset(ModerationQueueType queueType) {
    qType = queueType;
    _imageModerationStatus.add(ImageModerationStatus.loading);
    loadManager = LoadMoreManager();
    cacher = ModerationCacher();
    cacher.getMoreModerationRequests(queueType).then((value) {
      final firstState = value.firstOrNull;
      if (firstState == null || firstState is AllModerated) {
        _imageModerationStatus.add(ImageModerationStatus.allModerated);
      } else {
        _imageModerationStatus.add(ImageModerationStatus.moderating);
        loadManager.handleNewStates(value);
      }
    });
  }

  Stream<ImageRowState> getImageRow(int index) async* {
    if (_imageModerationStatus.value == ImageModerationStatus.loading) {
      return;
    }

    yield* loadManager.getImageRow(index, qType, cacher);
  }

  void moderateImageRow(int index, bool accept) {
    final relay = loadManager.moderationData[index];
    if (relay == null) {
      return;
    }

    final currentState = relay.value;
    if (currentState is ImageRow && currentState.status is ModerationDecicionNeeded) {
      final status = accept ? Accepted() : Denied();
      final newState = currentState.setContentStatus(status);
      relay.add(newState);
      newState.state.sendToServer();
    }
  }
}

sealed class LoadMoreState {}
class Idle extends LoadMoreState {}
class AlreadyLoading extends LoadMoreState {
  final BehaviorSubject<bool> completed = BehaviorSubject.seeded(false);
}

class LoadMoreManager {
  LoadMoreState state = Idle();
  final LinkedHashMap<int, BehaviorSubject<ImageRowState>> moderationData = LinkedHashMap();

  Stream<ImageRowState> getImageRow(
    int i,
    ModerationQueueType queueType,
    ModerationCacher cacher,
  ) async* {

    while (true) {
      final relay = moderationData[i];

      if (relay != null) {
        yield* relay;
        return;
      }

      yield Loading();

      switch (state) {
        case Idle():
          final newState = AlreadyLoading();
          state = newState;
          final imgStates = await cacher.getMoreModerationRequests(queueType);
          handleNewStates(imgStates);
          newState.completed.add(true);
          state = Idle();
        case AlreadyLoading(:final completed):
          await completed.where((event) => event).firstOrNull;
      }
    }
  }

  void handleNewStates(List<ImageRowState> newStates) {
    var nextI = moderationData.length;
    for (final s in newStates) {
      moderationData.putIfAbsent(nextI++, () => BehaviorSubject.seeded(s));
    }
  }
}

class ModerationCacher {
  final HashSet<Moderation> alreadyStoredModerations = HashSet();
  final MediaRepository media = MediaRepository.getInstance();

  /// Return only new ImageRowStates
  Future<List<ImageRowState>> getMoreModerationRequests(ModerationQueueType queueType) async {
    ModerationList requests = await media.nextModerationListFromServer(queueType);

    if (requests.list.isEmpty) {
      return List.generate(10, (index) => AllModerated());
    }

    final newStates = <ImageRowState>[];

    for (Moderation m in requests.list) {
      if (alreadyStoredModerations.contains(m)) {
        continue;
      }

      var securitySelfie = await media.getSecuritySelfie(m.requestCreatorId);
      securitySelfie ??= await media.getPendingSecuritySelfie(m.requestCreatorId);

      final cList = m.contentList();
      final List<ContentStatus> cStates = cList.map((e) => const ModerationDecicionNeeded() as ContentStatus).toList();
      final ModerationRequestState requestEntry = ModerationRequestState(
        m,
        cStates,
      );
      for (final (cIndex, c) in cList.indexed) {
        newStates.add(
          ImageRow(
            cIndex,
            requestEntry,
            target: c,
            securitySelfie: securitySelfie,
            status: requestEntry.list[cIndex],
          )
        );
      }

      alreadyStoredModerations.add(m);
    }

    if (newStates.isEmpty) {
      newStates.add(AllModerated());
    }

    return newStates;
  }
}
