

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/model/freezed/logic/account/news/view_news.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";

abstract class ViewNewsEvent {}
class InitialLoad extends ViewNewsEvent {}

class ViewNewsBloc extends Bloc<ViewNewsEvent, ViewNewsData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;
  final NewsId id;
  final String locale;
  ViewNewsBloc(this.id, this.locale) : super(ViewNewsData()) {
    on<InitialLoad>((key, emit) async {
      await runOnce(() async {
        emit(ViewNewsData().copyWith(isLoading: true));

        final r = await api.account((api) => api.getNewsItem(id.nid, locale));
        switch (r) {
          case Ok():
            emit(state.copyWith(
              isLoading: false,
              isError: false,
              item: r.value.item,
            ));
          case Err():
            emit(state.copyWith(
              isLoading: false,
              isError: true,
            ));
        }
      });
    });

    add(InitialLoad());
  }
}
