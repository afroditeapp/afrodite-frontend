import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/account_background_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/chat/unread_conversations_count_bloc.dart";


sealed class UnreadConversationsCountEvent {}
class CountUpdate extends UnreadConversationsCountEvent {
  final int value;
  CountUpdate(this.value);
}

class UnreadConversationsCountBloc extends Bloc<UnreadConversationsCountEvent, UnreadConversationsCountData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<int?>? _countSubscription;

  UnreadConversationsCountBloc() : super(UnreadConversationsCountData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        unreadConversations: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoConversationsBackground.watchUnreadConversationsCount()).listen((data) {
      add(CountUpdate(data ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    return super.close();
  }
}
