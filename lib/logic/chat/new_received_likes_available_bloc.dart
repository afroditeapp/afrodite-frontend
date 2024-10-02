import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/account_background_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/chat/new_received_likes_available_bloc.dart";
import "package:rxdart/rxdart.dart";

sealed class NewReceivedLikesAvailableEvent {}
class CountUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  CountUpdate(this.value);
}
class CountNotViewedUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  CountNotViewedUpdate(this.value);
}
class UpdateReceivedLikesCountNotViewed extends NewReceivedLikesAvailableEvent {
  final int value;
  final BehaviorSubject<bool> waitDone = BehaviorSubject.seeded(false);
  UpdateReceivedLikesCountNotViewed(this.value);
}
class SetTriggerReceivedLikesRefresh extends NewReceivedLikesAvailableEvent {
  final bool value;
  SetTriggerReceivedLikesRefresh(this.value);
}

class NewReceivedLikesAvailableBloc extends Bloc<NewReceivedLikesAvailableEvent, NewReceivedLikesAvailableData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<NewReceivedLikesCount?>? _countSubscription;
  StreamSubscription<NewReceivedLikesCount?>? _countNotViewedSubscription;

  NewReceivedLikesAvailableBloc() : super(NewReceivedLikesAvailableData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        newReceivedLikesCount: data.value,
      ));
    },
      transformer: sequential(),
    );
    on<CountNotViewedUpdate>((data, emit) {
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
    on<SetTriggerReceivedLikesRefresh>((data, emit) async {
      emit(state.copyWith(
        triggerReceivedLikesRefresh: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCount()).listen((data) {
      add(CountUpdate(data?.c ?? 0));
    });
    _countNotViewedSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCountNotViewed()).listen((data) {
      add(CountNotViewedUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    await _countNotViewedSubscription?.cancel();
    return super.close();
  }
}
