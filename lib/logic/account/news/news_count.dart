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
class CountUserViewedUpdate extends NewsCountEvent {
  final int value;
  CountUserViewedUpdate(this.value);
}
class MarkAllNewsViewed extends NewsCountEvent {}

class NewsCountBloc extends Bloc<NewsCountEvent, NewsCountData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;

  StreamSubscription<NewsCount?>? _countSubscription;
  StreamSubscription<NewsCount?>? _countUserViewedSubscription;

  NewsCountBloc() : super(NewsCountData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        newsCount: data.value,
      ));
    },
      transformer: sequential(),
    );
    on<CountUserViewedUpdate>((data, emit) {
      emit(state.copyWith(
        newsCountUserViewed: data.value,
      ));
    },
      transformer: sequential(),
    );
    on<MarkAllNewsViewed>((data, emit) async {
      await db.accountAction((db) => db.daoNews.setNewsCountUserViewed(count: NewsCount(c: state.newsCount)));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.daoNews.watchNewsCount()).listen((data) {
      add(CountUpdate(data?.c ?? 0));
    });
    _countUserViewedSubscription = db.accountStream((db) => db.daoNews.watchNewsCountUserViewed()).listen((data) {
      add(CountUserViewedUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    await _countUserViewedSubscription?.cancel();
    return super.close();
  }
}
