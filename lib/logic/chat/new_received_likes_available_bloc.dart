import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/general/notification/state/like_received.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/logic/app/app_visibility_provider.dart";
import "package:app/logic/app/bottom_navigation_state.dart";
import "package:app/utils/result.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable, sequential;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/model/freezed/logic/chat/new_received_likes_available_bloc.dart";
import "package:rxdart/rxdart.dart";

sealed class NewReceivedLikesAvailableEvent {}

class _CountUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  _CountUpdate(this.value);
}

class _CountUpdateDebounced extends NewReceivedLikesAvailableEvent {}

class _IsForegroundChanged extends NewReceivedLikesAvailableEvent {
  final bool isForeground;
  _IsForegroundChanged(this.isForeground);
}

class LikesScreenNowVisible extends NewReceivedLikesAvailableEvent {}

class RefreshReceivedLikes extends NewReceivedLikesAvailableEvent {}

class MarkReceivedLikesRefreshDone extends NewReceivedLikesAvailableEvent {}

class _ResetBadgeCount extends NewReceivedLikesAvailableEvent {
  final completer = Completer<()>();
}

class ReceivedLikesRefreshScheduler {
  static const _cooldown = Duration(minutes: 2);

  DateTime? _lastRefreshTime;

  bool shouldRefreshNow() {
    final now = DateTime.now();
    final refreshCooldownPassed =
        _lastRefreshTime == null || now.difference(_lastRefreshTime!) >= _cooldown;

    final notScrolled =
        !BottomNavigationStateBlocInstance.getInstance().navigationState.isScrolledLikes;

    return refreshCooldownPassed && notScrolled;
  }

  void markRefreshDone() {
    _lastRefreshTime = DateTime.now();
  }
}

class NewReceivedLikesAvailableBloc
    extends Bloc<NewReceivedLikesAvailableEvent, NewReceivedLikesAvailableData> {
  final ApiManager api;
  final AccountDatabaseManager db;
  final ReceivedLikesRefreshScheduler _refreshScheduler = ReceivedLikesRefreshScheduler();

  StreamSubscription<NewReceivedLikesCount?>? _countSubscription;
  StreamSubscription<NewReceivedLikesCount?>? _countDebounceSubscription;
  StreamSubscription<void>? _isForegroundSubscription;

  NewReceivedLikesAvailableBloc(RepositoryInstances r)
    : api = r.api,
      db = r.accountDb,
      super(NewReceivedLikesAvailableData()) {
    on<_CountUpdate>((data, emit) {
      if (AppVisibilityProvider.getInstance().isForeground && data.value > 0) {
        emit(state.copyWith(newReceivedLikesCount: data.value, showRefreshButton: true));
      } else {
        emit(state.copyWith(newReceivedLikesCount: data.value));
      }
    }, transformer: sequential());
    on<_CountUpdateDebounced>((data, emit) {
      if (state.newReceivedLikesCount > 0 &&
          AppVisibilityProvider.getInstance().isForeground &&
          _refreshScheduler.shouldRefreshNow()) {
        if (NotificationLikeReceived.getInstance().isLikesUiOpen()) {
          add(RefreshReceivedLikes());
          // The event calls _refreshScheduler.markRefreshDone()
        } else {
          // Leave badge count unchanged
          emit(state.copyWith(triggerReceivedLikesRefresh: true, showRefreshButton: false));
          _refreshScheduler.markRefreshDone();
        }
      }
    }, transformer: sequential());
    on<_IsForegroundChanged>((data, emit) async {
      if (data.isForeground) {
        final latestReceivedLikeId = await db
            .accountStreamSingle((db) => db.common.watchLatestReceivedLikeId())
            .ok();
        final latestIteratorState = await db
            .accountStreamSingle((db) => db.common.watchReceivedLikesIteratorState())
            .ok();
        if ((latestReceivedLikeId == null ||
                latestIteratorState == null ||
                latestReceivedLikeId != latestIteratorState.idAtReset) &&
            _refreshScheduler.shouldRefreshNow()) {
          if (NotificationLikeReceived.getInstance().isLikesUiOpen()) {
            add(RefreshReceivedLikes());
            // The event calls _refreshScheduler.markRefreshDone()
          } else {
            // Leave badge count unchanged
            emit(state.copyWith(triggerReceivedLikesRefresh: true, showRefreshButton: false));
            _refreshScheduler.markRefreshDone();
          }
        }
      }
    }, transformer: sequential());
    on<RefreshReceivedLikes>((data, emit) async {
      emit(state.copyWith(showRefreshButton: false));
      final event = _ResetBadgeCount();
      add(event);
      await event.completer.future;
      emit(state.copyWith(triggerReceivedLikesRefresh: true));
      _refreshScheduler.markRefreshDone();
    }, transformer: droppable());
    on<MarkReceivedLikesRefreshDone>((data, emit) {
      emit(state.copyWith(triggerReceivedLikesRefresh: false));
    }, transformer: sequential());
    on<LikesScreenNowVisible>((data, emit) async {
      // Handle "leave badge count unchanged" cases from _CountUpdateDebounced
      // and _IsForegroundChanged.
      if (!state.showRefreshButton) {
        add(_ResetBadgeCount());
      }
      await NotificationLikeReceived.getInstance().hideReceivedLikesNotification(db);
    }, transformer: sequential());
    on<_ResetBadgeCount>((data, emit) async {
      if (state.newReceivedLikesCount != 0) {
        final r = await api.chat((api) => api.postResetNewReceivedLikesCount());
        if (r case Ok(:final v)) {
          await db.accountAction((db) => db.common.updateSyncVersionReceivedLikes(v));
        }
      }
      data.completer.complete(());
    }, transformer: sequential());

    _countSubscription = db.accountStream((db) => db.common.watchReceivedLikesCount()).listen((
      data,
    ) {
      add(_CountUpdate(data?.c ?? 0));
    });
    _countDebounceSubscription = db
        .accountStream((db) => db.common.watchReceivedLikesCount())
        .debounceTime(Duration(seconds: 1))
        .listen((_) {
          add(_CountUpdateDebounced());
        });
    _isForegroundSubscription = AppVisibilityProvider.getInstance().isForegroundStream.listen((
      isForeground,
    ) {
      add(_IsForegroundChanged(isForeground));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    await _countDebounceSubscription?.cancel();
    await _isForegroundSubscription?.cancel();
    return super.close();
  }
}
