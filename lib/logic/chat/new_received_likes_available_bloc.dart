import "dart:async";

import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/utils/result.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/chat/new_received_likes_available_bloc.dart";
import "package:rxdart/rxdart.dart";

sealed class NewReceivedLikesAvailableEvent {}

class _CountUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  _CountUpdate(this.value);
}

class ResetReceivedLikesCount extends NewReceivedLikesAvailableEvent {}

class SetTriggerReceivedLikesRefreshWithButton extends NewReceivedLikesAvailableEvent {
  final bool value;
  SetTriggerReceivedLikesRefreshWithButton(this.value);
}

class _SetShowRefreshButton extends NewReceivedLikesAvailableEvent {
  final bool value;
  _SetShowRefreshButton(this.value);
}

class NewReceivedLikesAvailableBloc
    extends Bloc<NewReceivedLikesAvailableEvent, NewReceivedLikesAvailableData> {
  final ApiManager api;
  final AccountBackgroundDatabaseManager db;

  StreamSubscription<NewReceivedLikesCount?>? _countSubscription;
  StreamSubscription<NewReceivedLikesCount?>? _countDebouncedSubscription;

  NewReceivedLikesAvailableBloc(RepositoryInstances r)
    : api = r.api,
      db = r.accountBackgroundDb,
      super(NewReceivedLikesAvailableData()) {
    on<_CountUpdate>((data, emit) {
      emit(state.copyWith(newReceivedLikesCount: data.value));
    }, transformer: sequential());
    on<ResetReceivedLikesCount>((data, emit) async {
      if (state.newReceivedLikesCount != 0) {
        final r = await api.chat((api) => api.postResetNewReceivedLikesCount());
        if (r case Ok(:final v)) {
          await db.accountAction(
            (db) => db.newReceivedLikesCount.updateSyncVersionReceivedLikes(v.v, v.c),
          );
          emit(state.copyWith(showRefreshButton: false));
        }
      }
    }, transformer: sequential());
    on<SetTriggerReceivedLikesRefreshWithButton>((data, emit) async {
      if (data.value) {
        emit(state.copyWith(triggerReceivedLikesRefresh: data.value, showRefreshButton: false));
      } else {
        emit(state.copyWith(triggerReceivedLikesRefresh: data.value));
      }
    }, transformer: sequential());
    on<_SetShowRefreshButton>((data, emit) async {
      emit(state.copyWith(showRefreshButton: data.value));
    }, transformer: sequential());

    _countSubscription = db
        .accountStream((db) => db.newReceivedLikesCount.watchReceivedLikesCount())
        .listen((data) {
          add(_CountUpdate(data?.c ?? 0));
        });
    _countDebouncedSubscription = db
        .accountStream((db) => db.newReceivedLikesCount.watchReceivedLikesCount())
        .debounceTime(const Duration(milliseconds: 1500))
        .listen((_) {
          // Debounce is needed as button should not be shown
          // when automatic refresh happens.
          add(_SetShowRefreshButton(state.newReceivedLikesCount > 0));
        });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    await _countDebouncedSubscription?.cancel();
    return super.close();
  }
}
