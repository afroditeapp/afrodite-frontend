import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/database/account/dao_current_content.dart";
import "package:pihka_frontend/database/account/dao_pending_content.dart";
import "package:pihka_frontend/database/database_manager.dart";
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";


part 'content.freezed.dart';

final log = Logger("ContentBloc");

@freezed
class ContentData with _$ContentData {
  const ContentData._();

  factory ContentData({
    CurrentProfileContent? content,
    ContentId? securityContent,
    PendingProfileContentInternal? pendingContent,
    ContentId? pendingSecurityContent,
  }) = _ContentData;

  ContentId? get primaryProfilePicture {
    return content?.contentId0 ?? pendingContent?.pendingContentId0;
  }

  CropResults get primaryProfilePictureCropInfo {
    final size = content?.gridCropSize ?? pendingContent?.pendingGridCropSize ?? 1.0;
    final x = content?.gridCropX ?? pendingContent?.pendingGridCropX ?? 0.0;
    final y = content?.gridCropY ?? pendingContent?.pendingGridCropY ?? 0.0;
    return CropResults.fromValues(size, x, y);
  }
}

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
class ReloadProfileContentIfNull extends ContentEvent {}

class ContentBloc extends Bloc<ContentEvent, ContentData> {
  final DatabaseManager db = DatabaseManager.getInstance();
  final MediaRepository media = MediaRepository.getInstance();

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
    on<ReloadProfileContentIfNull>((data, emit) async {
      final beforeFirstModeration = state.content?.contentId0 == null && state.pendingContent?.pendingContentId0 == null;
      final afterFirstModeration = state.content?.contentId0 == null;
      if (beforeFirstModeration || afterFirstModeration) {
        await media.reloadMyProfileContent();
      }
    });

    db.accountStream((db) => db.daoCurrentContent.watchCurrentProfileContent()).listen((event) {
      add(NewPublicContent(event));
    });
    db.accountStream((db) => db.daoCurrentContent.watchCurrentSecurityContent()).listen((event) {
      add(NewSecurityContent(event));
    });
    db.accountStream((db) => db.daoPendingContent.watchPendingProfileContent()).listen((event) {
      add(NewPendingContent(event));
    });
    db.accountStream((db) => db.daoPendingContent.watchPendingSecurityContent()).listen((event) {
      add(NewPendingSecurityContent(event));
    });
  }
}
