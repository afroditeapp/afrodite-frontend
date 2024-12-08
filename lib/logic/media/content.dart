import "dart:async";

import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/image_cache.dart";
import "package:app/data/login_repository.dart";

import "package:app/data/media_repository.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/media/content.dart";

final log = Logger("ContentBloc");

sealed class ContentEvent {}

class NewPrimaryContent extends ContentEvent {
  final PrimaryProfileContent? content;
  NewPrimaryContent(this.content);
}
class NewSecurityContent extends ContentEvent {
  final MyContent? content;
  NewSecurityContent(this.content);
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

  StreamSubscription<PrimaryProfileContent?>? _primaryContentSubscription;
  StreamSubscription<MyContent?>? _securityContentSubscription;
  StreamSubscription<void>? _primaryImageDataAvailable;

  ContentBloc() : super(ContentData()) {
    on<NewPrimaryContent>((data, emit) {
      emit(state.copyWith(
        primaryContent: data.content,
      ));
    });
    on<NewSecurityContent>((data, emit) {
      emit(state.copyWith(
        securityContent: data.content,
      ));
    });
    on<NewPrimaryImageDataAvailable>((data, emit) {
      emit(state.copyWith(
        primaryImageDataAvailable: data.value,
      ));
    });

    _primaryContentSubscription = db.accountStream((db) => db.daoCurrentContent.watchPrimaryProfileContent()).listen((event) {
      add(NewPrimaryContent(event));
    });
    _securityContentSubscription = db.accountStream((db) => db.daoCurrentContent.watchCurrentSecurityContent()).listen((event) {
      add(NewSecurityContent(event));
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
    await _primaryContentSubscription?.cancel();
    await _securityContentSubscription?.cancel();
    await _primaryImageDataAvailable?.cancel();
    await super.close();
  }
}
