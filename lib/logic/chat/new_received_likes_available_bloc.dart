import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/account_background_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/chat/new_received_likes_available_bloc.dart";

sealed class NewReceivedLikesAvailableEvent {}
class CountUpdate extends NewReceivedLikesAvailableEvent {
  final int value;
  CountUpdate(this.value);
}

class NewReceivedLikesAvailableBloc extends Bloc<NewReceivedLikesAvailableEvent, NewReceivedLikesAvailableData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<NewReceivedLikesCount?>? _countSubscription;

  NewReceivedLikesAvailableBloc() : super(NewReceivedLikesAvailableData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        newReceivedLikesCount: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoNewReceivedLikesAvailable.watchReceivedLikesCount()).listen((data) {
      add(CountUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    return super.close();
  }
}
