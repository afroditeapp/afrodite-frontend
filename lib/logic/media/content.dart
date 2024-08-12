import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/login_repository.dart";

import "package:pihka_frontend/data/media_repository.dart";
import 'package:database/database.dart';
import "package:pihka_frontend/database/account_database_manager.dart";
import "package:pihka_frontend/model/freezed/logic/media/content.dart";


final log = Logger("ContentBloc");


sealed class ContentEvent {}

class NewPublicContent extends ContentEvent {
  final CurrentProfileContent? content;
  NewPublicContent(this.content);
}
class NewSecurityContent extends ContentEvent {
  final ContentId? content;
  NewSecurityContent(this.content);
}
class NewPendingContent extends ContentEvent {
  final PendingProfileContentInternal? content;
  NewPendingContent(this.content);
}
class NewPendingSecurityContent extends ContentEvent {
  final ContentId? content;
  NewPendingSecurityContent(this.content);
}

class ContentBloc extends Bloc<ContentEvent, ContentData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;

  StreamSubscription<CurrentProfileContent?>? _publicContentSubscription;
  StreamSubscription<ContentId?>? _securityContentSubscription;
  StreamSubscription<PendingProfileContentInternal?>? _pendingContentSubscription;
  StreamSubscription<ContentId?>? _pendingSecurityContentSubscription;

  ContentBloc() : super(ContentData()) {
    on<NewPublicContent>((data, emit) {
      emit(state.copyWith(
        content: data.content,
      ));
    });
    on<NewSecurityContent>((data, emit) {
      emit(state.copyWith(
        securityContent: data.content,
      ));
    });
    on<NewPendingContent>((data, emit) {
      emit(state.copyWith(
        pendingContent: data.content,
      ));
    });
    on<NewPendingSecurityContent>((data, emit) {
      emit(state.copyWith(
        pendingSecurityContent: data.content,
      ));
    });

    _publicContentSubscription = db.accountStream((db) => db.daoCurrentContent.watchCurrentProfileContent()).listen((event) {
      add(NewPublicContent(event));
    });
    _securityContentSubscription = db.accountStream((db) => db.daoCurrentContent.watchCurrentSecurityContent()).listen((event) {
      add(NewSecurityContent(event));
    });
    _pendingContentSubscription = db.accountStream((db) => db.daoPendingContent.watchPendingProfileContent()).listen((event) {
      add(NewPendingContent(event));
    });
    _pendingSecurityContentSubscription = db.accountStream((db) => db.daoPendingContent.watchPendingSecurityContent()).listen((event) {
      add(NewPendingSecurityContent(event));
    });
  }

  @override
  Future<void> close() async {
    await _publicContentSubscription?.cancel();
    await _securityContentSubscription?.cancel();
    await _pendingContentSubscription?.cancel();
    await _pendingSecurityContentSubscription?.cancel();
    await super.close();
  }
}
