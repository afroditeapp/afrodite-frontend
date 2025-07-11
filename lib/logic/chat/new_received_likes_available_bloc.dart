import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/chat/new_received_likes_available_bloc.dart";
import "package:rxdart/rxdart.dart";

sealed class NewReceivedLikesAvailableEvent {}
class _CountUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  _CountUpdate(this.value);
}
class _CountUpdateDebounced extends NewReceivedLikesAvailableEvent {
  final int value;
  _CountUpdateDebounced(this.value);
}
class _CountNotViewedUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  _CountNotViewedUpdate(this.value);
}
class UpdateReceivedLikesCountNotViewed extends NewReceivedLikesAvailableEvent {
  final int value;
  final BehaviorSubject<bool> waitDone = BehaviorSubject.seeded(false);
  UpdateReceivedLikesCountNotViewed(this.value);
}
class SetTriggerReceivedLikesRefreshWithButton extends NewReceivedLikesAvailableEvent {
  final bool value;
  SetTriggerReceivedLikesRefreshWithButton(this.value);
}
class _SetShowRefreshButton extends NewReceivedLikesAvailableEvent {
  final bool value;
  _SetShowRefreshButton(this.value);
}

class NewReceivedLikesAvailableBloc extends Bloc<NewReceivedLikesAvailableEvent, NewReceivedLikesAvailableData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<NewReceivedLikesCount?>? _countSubscription;
  StreamSubscription<NewReceivedLikesCount?>? _countDebouncedSubscription;
  StreamSubscription<NewReceivedLikesCount?>? _countNotViewedSubscription;

  NewReceivedLikesAvailableBloc() : super(NewReceivedLikesAvailableData()) {
    on<_CountUpdate>((data, emit) {
      if (data.value < state.newReceivedLikesCountPartiallyDebounced) {
        emit(state.copyWith(
          newReceivedLikesCount: data.value,
          newReceivedLikesCountPartiallyDebounced: data.value,
        ));
      } else {
        emit(state.copyWith(
          newReceivedLikesCount: data.value,
        ));
      }
    },
      transformer: sequential(),
    );
    on<_CountUpdateDebounced>((data, emit) {
      emit(state.copyWith(
        newReceivedLikesCountPartiallyDebounced: data.value,
      ));
    },
      transformer: sequential(),
    );
    on<_CountNotViewedUpdate>((data, emit) {
      emit(state.copyWith(
        newReceivedLikesCountNotViewed: data.value,
      ));
    },
      transformer: sequential(),
    );
    on<UpdateReceivedLikesCountNotViewed>((data, emit) async {
      await db.accountAction((db) => db.daoNewReceivedLikesAvailable.updateReceivedLikesCountNotViewed(NewReceivedLikesCount(c: data.value)));
      data.waitDone.add(true);
    },
      transformer: sequential(),
    );
    on<SetTriggerReceivedLikesRefreshWithButton>((data, emit) async {
      if (data.value) {
        emit(state.copyWith(
          triggerReceivedLikesRefresh: data.value,
          showRefreshButton: false,
        ));
      } else {
        emit(state.copyWith(
          triggerReceivedLikesRefresh: data.value,
        ));
      }
    },
      transformer: sequential(),
    );
    on<_SetShowRefreshButton>((data, emit) async {
      emit(state.copyWith(
        showRefreshButton: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCount()).listen((data) {
      add(_CountUpdate(data?.c ?? 0));
    });
    _countDebouncedSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCount())
      .debounceTime(const Duration(milliseconds: 1500))
      .listen((data) {
        final count = data?.c ?? 0;
        add(_SetShowRefreshButton(count > 0));
        add(_CountUpdateDebounced(count));
      });
    _countNotViewedSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCountNotViewed()).listen((data) {
      add(_CountNotViewedUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    await _countDebouncedSubscription?.cancel();
    await _countNotViewedSubscription?.cancel();
    return super.close();
  }
}
