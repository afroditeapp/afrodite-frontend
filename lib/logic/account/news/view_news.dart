import "package:app/data/utils/repository_instances.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/api/server_connection_manager.dart";
import "package:app/model/freezed/logic/account/news/view_news.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

abstract class ViewNewsEvent {}

class Reload extends ViewNewsEvent {}

class ViewNewsBloc extends Bloc<ViewNewsEvent, ViewNewsData> with ActionRunner {
  final ApiManager api;
  final NewsId id;
  final String locale;
  ViewNewsBloc(RepositoryInstances r, this.id, this.locale) : api = r.api, super(ViewNewsData()) {
    on<Reload>((key, emit) async {
      await runOnce(() async {
        emit(ViewNewsData().copyWith(isLoading: true));

        final r = await api.account((api) => api.getNewsItem(id.nid, locale));
        switch (r) {
          case Ok():
            emit(state.copyWith(isLoading: false, isError: false, item: r.value.item));
          case Err():
            emit(state.copyWith(isLoading: false, isError: true));
        }
      });
    });

    add(Reload());
  }
}
