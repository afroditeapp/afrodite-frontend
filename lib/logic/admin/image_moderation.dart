import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'image_moderation.freezed.dart';

@freezed
class ImageModerationData with _$ImageModerationData {
  factory ImageModerationData({
    int? test,
  }) = _ImageModerationData;
}

abstract class ImageModerationEvent {}
class ModerateContentId extends ImageModerationEvent {
  final ContentId id;
  ModerateContentId(this.id);
}


class ImageModerationBloc extends Bloc<ImageModerationEvent, ImageModerationData> {
  final MediaRepository media;

  ImageModerationBloc(this.media) : super(ImageModerationData()) {
    on<ModerateContentId>((data, emit) async {

      // emit(state.copyWith(

      // ));
    });
  }
}
