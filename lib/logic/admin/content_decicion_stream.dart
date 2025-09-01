import "dart:collection";

import "package:app/api/server_connection_manager.dart";
import 'package:async/async.dart' show StreamExtensions;

import "package:app/utils/result.dart";
import "package:rxdart/rxdart.dart";

enum ContentDecicionStreamStatus { loading, handling, allHandled }

enum RowStatus { decicionNeeded, accepted, rejected }

sealed class RowState<C> {}

class AllModerated<C> implements RowState<C> {}

class Loading<C> implements RowState<C> {}

class ContentRow<C> implements RowState<C> {
  final C content;
  final RowStatus status;
  final bool sentToServer;

  ContentRow(this.content, {required this.status, this.sentToServer = false});

  ContentRow<C> copyWith(RowStatus status, bool sentToServer) {
    return ContentRow(content, status: status, sentToServer: sentToServer);
  }

  Future<ContentRow<C>?> sendToServer(ContentIo<C> io) async {
    if (status == RowStatus.decicionNeeded) {
      return null;
    }

    if (sentToServer) {
      return null;
    }

    await io.sendToServer(content, status == RowStatus.accepted);

    return copyWith(status, true);
  }
}

class ContentDecicionStreamLogic<C> {
  final ApiManager api;

  final BehaviorSubject<ContentDecicionStreamStatus> _moderationStatus = BehaviorSubject.seeded(
    ContentDecicionStreamStatus.loading,
  );

  final ContentIo<C> io;

  ModerationCacher<C> cacher;
  var showTextsWhichBotsCanModerate = false;
  var loadManager = LoadMoreManager<C>();

  Stream<ContentDecicionStreamStatus> get moderationStatus => _moderationStatus.stream;

  ContentDecicionStreamLogic(this.api, this.io) : cacher = ModerationCacher<C>(api);

  Future<void> dispose() async {
    await _moderationStatus.close();
    await loadManager.dispose();
  }

  void reset() {
    _moderationStatus.add(ContentDecicionStreamStatus.loading);
    final currentLoadManager = loadManager;
    loadManager = LoadMoreManager();
    currentLoadManager.dispose();
    cacher = ModerationCacher(api);
    cacher.getMoreModerationRequests(io).then((value) {
      final firstState = value.firstOrNull;
      if (firstState == null || firstState is AllModerated) {
        _moderationStatus.add(ContentDecicionStreamStatus.allHandled);
      } else {
        _moderationStatus.add(ContentDecicionStreamStatus.handling);
        loadManager.handleNewStates(value);
      }
    });
  }

  Stream<RowState<C>> getRow(int index) async* {
    if (_moderationStatus.value == ContentDecicionStreamStatus.loading) {
      return;
    }

    yield* loadManager.getRow(index, cacher, io);
  }

  void moderateRow(int index, bool accept) async {
    final relay = loadManager.rows[index];
    if (relay == null) {
      return;
    }

    final currentState = relay.value;
    if (currentState is ContentRow<C> && currentState.status == RowStatus.decicionNeeded) {
      final status = accept ? RowStatus.accepted : RowStatus.rejected;
      final newState = currentState.copyWith(status, currentState.sentToServer);
      relay.add(newState);
      final newerState = await newState.sendToServer(io);
      if (newerState != null) {
        relay.add(newerState);
      }
    }
  }

  bool rejectingIsPossible(int index) {
    final relay = loadManager.rows[index];
    if (relay == null) {
      return false;
    }

    final currentState = relay.value;
    return currentState is ContentRow<C> && !currentState.sentToServer;
  }
}

sealed class LoadMoreState {
  Future<void> dispose() async {}
}

class Idle extends LoadMoreState {}

class AlreadyLoading extends LoadMoreState {
  final BehaviorSubject<bool> _completed = BehaviorSubject.seeded(false);

  @override
  Future<void> dispose() async {
    await _completed.close();
  }

  Future<void> completeAndDispose() async {
    _completed.add(true);
    await _completed.close();
  }

  Future<void> waitCompletion() async {
    try {
      await _completed.where((event) => event).firstOrNull;
    } catch (_) {
      // Disposed
    }
  }
}

class LoadMoreManager<C> {
  LoadMoreState state = Idle();
  final LinkedHashMap<int, BehaviorSubject<RowState<C>>> rows = LinkedHashMap();

  Future<void> dispose() async {
    for (final v in rows.values) {
      await v.close();
    }
    await state.dispose();
  }

  Stream<RowState<C>> getRow(int i, ModerationCacher<C> cacher, ContentIo<C> logic) async* {
    while (true) {
      final relay = rows[i];

      if (relay != null) {
        yield* relay;
        return;
      }

      yield Loading();

      switch (state) {
        case Idle():
          final newState = AlreadyLoading();
          state = newState;
          final imgStates = await cacher.getMoreModerationRequests(logic);
          handleNewStates(imgStates);
          await newState.completeAndDispose();
          state = Idle();
        case AlreadyLoading state:
          await state.waitCompletion();
      }
    }
  }

  void handleNewStates(List<RowState<C>> newStates) {
    var nextI = rows.length;
    for (final s in newStates) {
      rows.putIfAbsent(nextI++, () => BehaviorSubject.seeded(s));
    }
  }
}

class ModerationCacher<C> {
  final HashSet<C> alreadyStoredContent = HashSet();
  final ApiManager api;

  ModerationCacher(this.api);

  /// Return only new RowState
  Future<List<RowState<C>>> getMoreModerationRequests(ContentIo<C> io) async {
    final texts = await io.getNextContent().ok();

    if (texts == null) {
      return List.generate(10, (index) => AllModerated());
    }

    final newStates = <RowState<C>>[];

    for (final m in texts) {
      if (alreadyStoredContent.contains(m)) {
        continue;
      }

      newStates.add(ContentRow(m, status: RowStatus.decicionNeeded));

      alreadyStoredContent.add(m);
    }

    if (newStates.isEmpty) {
      newStates.add(AllModerated());
    }

    return newStates;
  }
}

/// The C must have equality and hashCode implemented properly.
abstract class ContentIo<C> {
  /// Get next content available. Previous content might
  /// be returned.
  Future<Result<List<C>, ()>> getNextContent();

  Future<void> sendToServer(C content, bool accept);
}
