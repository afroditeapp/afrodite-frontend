
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/utils.dart";

part 'current_moderation_request.freezed.dart';


@freezed
class CurrentModerationRequestData with _$CurrentModerationRequestData {
  factory CurrentModerationRequestData({
    ModerationRequest? moderationRequest,
  }) = _CurrentModerationRequestData;
}
