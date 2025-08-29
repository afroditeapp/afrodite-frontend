import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/chat/unread_conversations_count_bloc.dart";

sealed class UnreadConversationsCountEvent {}

class CountUpdate extends UnreadConversationsCountEvent {
  final int value;
  CountUpdate(this.value);
}

class UnreadConversationsCountBloc
    extends Bloc<UnreadConversationsCountEvent, UnreadConversationsCountData> {
  final AccountBackgroundDatabaseManager db;

  StreamSubscription<int?>? _countSubscription;

  UnreadConversationsCountBloc(RepositoryInstances r)
    : db = r.accountBackgroundDb,
      super(UnreadConversationsCountData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(unreadConversations: data.value));
    }, transformer: sequential());

    _countSubscription = db
        .accountStream((db) => db.unreadMessagesCount.watchUnreadConversationsCount())
        .listen((data) {
          add(CountUpdate(data ?? 0));
        });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    return super.close();
  }
}
