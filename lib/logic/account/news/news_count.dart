import "dart:async";

import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:async/async.dart" show StreamExtensions;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/database/account_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/account/news/news_count.dart";

sealed class NewsCountEvent {}
class CountUpdate extends NewsCountEvent {
  final int value;
  CountUpdate(this.value);
}

class NewsCountBloc extends Bloc<NewsCountEvent, NewsCountData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<UnreadNewsCount?>? _countSubscription;

  NewsCountBloc() : super(NewsCountData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        newsCount: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoNews.watchUnreadNewsCount()).listen((data) {
      add(CountUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    return super.close();
  }
}
