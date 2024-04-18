
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'current_moderation_request.freezed.dart';


@freezed
class CurrentModerationRequestData with _$CurrentModerationRequestData {
  factory CurrentModerationRequestData({
    ModerationRequest? moderationRequest,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
  }) = _CurrentModerationRequestData;
}
