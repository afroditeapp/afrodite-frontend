import "dart:async";

import "package:app/database/account_background_database_manager.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/model/freezed/logic/account/news/news_count.dart";

sealed class NewsCountEvent {}
class CountUpdate extends NewsCountEvent {
  final int value;
  CountUpdate(this.value);
}

class NewsCountBloc extends Bloc<NewsCountEvent, NewsCountData> {
  final AccountBackgroundDatabaseManager db = LoginRepository.getInstance().repositories.accountBackgroundDb;

  StreamSubscription<UnreadNewsCount?>? _countSubscription;

  NewsCountBloc() : super(NewsCountData()) {
    on<CountUpdate>((data, emit) {
      emit(state.copyWith(
        newsCount: data.value,
      ));
    },
      transformer: sequential(),
    );

    _countSubscription = db.accountStream((db) => db.news.watchUnreadNewsCount()).listen((data) {
      add(CountUpdate(data?.c ?? 0));
    });
  }

  @override
  Future<void> close() async {
    await _countSubscription?.cancel();
    return super.close();
  }
}
