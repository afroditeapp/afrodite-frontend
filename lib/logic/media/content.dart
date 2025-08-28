import "dart:async";

import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/api/server_connection_manager.dart";
import "package:app/data/image_cache.dart";
import "package:app/data/login_repository.dart";

import "package:app/data/media_repository.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/media/content.dart";

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

class ChangeSecurityContent extends ContentEvent {
  final ContentId content;
  ChangeSecurityContent(this.content);
}

class ContentBloc extends Bloc<ContentEvent, ContentData> with ActionRunner {
  final AccountDatabaseManager db = LoginRepository.getInstance().repositories.accountDb;
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ServerConnectionManager connection =
      LoginRepository.getInstance().repositories.connectionManager;
  final ImageCacheData cache = ImageCacheData.getInstance();
  final AccountId currentUser = LoginRepository.getInstance().repositories.accountId;
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  StreamSubscription<PrimaryProfileContent?>? _primaryContentSubscription;
  StreamSubscription<MyContent?>? _securityContentSubscription;
  StreamSubscription<void>? _primaryImageDataAvailable;

  ContentBloc() : super(ContentData()) {
    on<NewPrimaryContent>((data, emit) {
      emit(state.copyWith(primaryContent: data.content, isLoadingPrimaryContent: false));
    });
    on<NewSecurityContent>((data, emit) {
      emit(state.copyWith(securityContent: data.content, isLoadingSecurityContent: false));
    });
    on<NewPrimaryImageDataAvailable>((data, emit) {
      emit(state.copyWith(primaryImageDataAvailable: data.value));
    });
    on<ChangeSecurityContent>((data, emit) async {
      await runOnce(() async {
        final changeResult = await api.mediaAction(
          (api) => api.putSecurityContentInfo(data.content),
        );
        final updateResult = await media.reloadMyMediaContent();
        if (changeResult.isErr() || updateResult.isErr()) {
          showSnackBar(R.strings.generic_error_occurred);
        } else {
          showSnackBar(R.strings.current_security_selfie_screen_security_selfie_changed);
        }
      });
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
        await connection.state.where((v) => v == ServerConnectionState.connected).first;
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
