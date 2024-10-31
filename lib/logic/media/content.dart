import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/image_cache.dart";
import "package:app/data/login_repository.dart";

import "package:app/data/media_repository.dart";
import 'package:database/database.dart';
import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/media/content.dart";


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
class NewPrimaryImageDataAvailable extends ContentEvent {
  final bool value;
  NewPrimaryImageDataAvailable(this.value);
}

class ContentBloc extends Bloc<ContentEvent, ContentData> {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ServerConnectionManager connection = LoginRepository.getInstance().repositories.connectionManager;
  final ImageCacheData cache = ImageCacheData.getInstance();
  final AccountId currentUser =  LoginRepository.getInstance().repositories.accountId;

  StreamSubscription<CurrentProfileContent?>? _publicContentSubscription;
  StreamSubscription<ContentId?>? _securityContentSubscription;
  StreamSubscription<PendingProfileContentInternal?>? _pendingContentSubscription;
  StreamSubscription<ContentId?>? _pendingSecurityContentSubscription;
  StreamSubscription<void>? _primaryImageDataAvailable;

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
    on<NewPrimaryImageDataAvailable>((data, emit) {
      emit(state.copyWith(
        primaryImageDataAvailable: data.value,
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

    // Retry main screen my profile primary image thumbnail loading
    // if it is not available at the first try.
    _primaryImageDataAvailable = primaryImageDataAvailable().listen((event) {
      add(NewPrimaryImageDataAvailable(event));
    });
  }

  Stream<bool> primaryImageDataAvailable() async* {
    ContentId? previousImg;
    await for (final s in stream) {
      final newImg = s.primaryProfilePicture;
      if (newImg != null && previousImg != newImg) {
        previousImg = newImg;
        final imgData = await cache.getImage(currentUser, newImg, media: media);
        if (imgData == null) {
          yield false;
        } else {
          yield true;
        }
        await connection.state.where((v) => v == ApiManagerState.connected).first;
        final imgData2 = await cache.getImage(currentUser, newImg, media: media);
        if (imgData2 == null) {
          yield false;
        } else {
          yield true;
        }
      }
    }
  }

  @override
  Future<void> close() async {
    await _publicContentSubscription?.cancel();
    await _securityContentSubscription?.cancel();
    await _pendingContentSubscription?.cancel();
    await _pendingSecurityContentSubscription?.cancel();
    await _primaryImageDataAvailable?.cancel();
    await super.close();
  }
}
