import "dart:collection";

import "package:app/utils/result.dart";
import "package:async/async.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:rxdart/rxdart.dart";


enum ProfileTextModerationStatus {
  loading,
  moderating,
  allModerated,
}

sealed class ProfileTextStatus {}
class ModerationDecicionNeeded implements ProfileTextStatus {
  const ModerationDecicionNeeded();
}
class Accepted implements ProfileTextStatus {}
class Denied implements ProfileTextStatus {}

sealed class ProfileTextRowState {}
class AllModerated implements ProfileTextRowState {}
class Loading implements ProfileTextRowState {}
class ProfileTextRow implements ProfileTextRowState {
  final AccountId account;
  final String text;
  final ProfileTextStatus status;
  final bool sentToServer;

  ProfileTextRow(
    this.account,
    this.text,
    {
      required this.status,
      this.sentToServer = false,
    }
  );

  ProfileTextRow copyWith(ProfileTextStatus status, bool sentToServer) {
    return ProfileTextRow(
      account,
      text,
      status: status,
      sentToServer: sentToServer,
    );
  }

  Future<ProfileTextRow?> sendToServer() async {
    if (status is ModerationDecicionNeeded) {
      return null;
    }

    if (sentToServer) {
      return null;
    }

    final accepted = status is Accepted;
    final info = PostModerateProfileText(accept: accepted, id: account, text: text);
    await LoginRepository.getInstance().repositories.api.profileAdminAction((api) => api.postModerateProfileText(info));

    return copyWith(status, true);
  }
}


class ProfileTextModerationLogic {
  ProfileTextModerationLogic._private();
  static final _instance = ProfileTextModerationLogic._private();
  factory ProfileTextModerationLogic.getInstance() {
    return _instance;
  }

  final api = LoginRepository.getInstance().repositories.api;

  final BehaviorSubject<ProfileTextModerationStatus> _moderationStatus =
    BehaviorSubject.seeded(ProfileTextModerationStatus.loading);

  var cacher = ModerationCacher();
  var showTextsWhichBotsCanModerate = false;
  var loadManager = LoadMoreManager();

  Stream<ProfileTextModerationStatus> get moderationStatus => _moderationStatus.stream;

  void reset(bool showTextsWhichBotsCanModerate) {
    _moderationStatus.add(ProfileTextModerationStatus.loading);
    loadManager = LoadMoreManager();
    cacher = ModerationCacher();
    cacher.getMoreModerationRequests(showTextsWhichBotsCanModerate).then((value) {
      final firstState = value.firstOrNull;
      if (firstState == null || firstState is AllModerated) {
        _moderationStatus.add(ProfileTextModerationStatus.allModerated);
      } else {
        _moderationStatus.add(ProfileTextModerationStatus.moderating);
        loadManager.handleNewStates(value);
      }
    });
  }

  Stream<ProfileTextRowState> getRow(int index) async* {
    if (_moderationStatus.value == ProfileTextModerationStatus.loading) {
      return;
    }

    yield* loadManager.getRow(index, showTextsWhichBotsCanModerate, cacher);
  }

  void moderateRow(int index, bool accept) async {
    final relay = loadManager.moderationData[index];
    if (relay == null) {
      return;
    }

    final currentState = relay.value;
    if (currentState is ProfileTextRow && currentState.status is ModerationDecicionNeeded) {
      final status = accept ? Accepted() : Denied();
      final newState = currentState.copyWith(status, currentState.sentToServer);
      relay.add(newState);
      final newerState = await newState.sendToServer();
      if (newerState != null) {
        relay.add(newerState);
      }
    }
  }

  bool rejectingIsPossible(int index) {
    final relay = loadManager.moderationData[index];
    if (relay == null) {
      return false;
    }

    final currentState = relay.value;
    return currentState is ProfileTextRow && !currentState.sentToServer;
  }
}

sealed class LoadMoreState {}
class Idle extends LoadMoreState {}
class AlreadyLoading extends LoadMoreState {
  final BehaviorSubject<bool> completed = BehaviorSubject.seeded(false);
}

class LoadMoreManager {
  LoadMoreState state = Idle();
  final LinkedHashMap<int, BehaviorSubject<ProfileTextRowState>> moderationData = LinkedHashMap();

  Stream<ProfileTextRowState> getRow(
    int i,
    bool showTextsWhichBotsCanModerate,
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
          final imgStates = await cacher.getMoreModerationRequests(showTextsWhichBotsCanModerate);
          handleNewStates(imgStates);
          newState.completed.add(true);
          state = Idle();
        case AlreadyLoading(:final completed):
          await completed.where((event) => event).firstOrNull;
      }
    }
  }

  void handleNewStates(List<ProfileTextRowState> newStates) {
    var nextI = moderationData.length;
    for (final s in newStates) {
      moderationData.putIfAbsent(nextI++, () => BehaviorSubject.seeded(s));
    }
  }
}

class ModerationCacher {
  final HashSet<ProfileTextPendingModeration> alreadyStoredModerations = HashSet();
  final api = LoginRepository.getInstance().repositories.api;

  /// Return only new ProfileTextRowState
  Future<List<ProfileTextRowState>> getMoreModerationRequests(bool showTextsWhichBotsCanModerate) async {
    final texts = await api.profileAdmin((api) => api.getProfileTextPendingModerationList(showTextsWhichBotsCanModerate)).ok();

    if (texts == null) {
      return List.generate(10, (index) => AllModerated());
    }

    final newStates = <ProfileTextRowState>[];

    for (final m in texts.values) {
      if (alreadyStoredModerations.contains(m)) {
        continue;
      }

      newStates.add(
        ProfileTextRow(
          m.id,
          m.text,
          status: const ModerationDecicionNeeded(),
        )
      );

      alreadyStoredModerations.add(m);
    }

    if (newStates.isEmpty) {
      newStates.add(AllModerated());
    }

    return newStates;
  }
}
