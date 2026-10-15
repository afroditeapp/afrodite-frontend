import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/media/content.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";

sealed class ContentEvent {}

class NewPrimaryContent extends ContentEvent {
  final PrimaryProfileContent? content;
  NewPrimaryContent(this.content);
}

class NewSecurityContent extends ContentEvent {
  final MyContent? content;
  NewSecurityContent(this.content);
}

class ContentBloc extends Bloc<ContentEvent, ContentData> {
  final AccountDatabaseManager db;

  StreamSubscription<PrimaryProfileContent?>? _primaryContentSubscription;
  StreamSubscription<MyContent?>? _securityContentSubscription;

  ContentBloc(RepositoryInstances r) : db = r.accountDb, super(ContentData()) {
    on<NewPrimaryContent>((data, emit) {
      emit(state.copyWith(primaryContent: data.content, isLoadingPrimaryContent: false));
    });
    on<NewSecurityContent>((data, emit) {
      emit(state.copyWith(securityContent: data.content, isLoadingSecurityContent: false));
    });

    _primaryContentSubscription = db
        .accountStream((db) => db.myMedia.watchMyPrimaryProfileContent())
        .listen((event) {
          add(NewPrimaryContent(event));
        });
    _securityContentSubscription = db
        .accountStream((db) => db.myMedia.watchMyCurrentSecurityContent())
        .listen((event) {
          add(NewSecurityContent(event));
        });
  }

  @override
  Future<void> close() async {
    await _primaryContentSubscription?.cancel();
    await _securityContentSubscription?.cancel();
    await super.close();
  }
}
