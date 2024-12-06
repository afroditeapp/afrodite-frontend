
import "package:freezed_annotation/freezed_annotation.dart";

part 'initial_content_moderation.freezed.dart';

@freezed
class InitialContentModerationData with _$InitialContentModerationData {
  factory InitialContentModerationData({
    bool? accepted,
    @Default(false) bool isError,
    @Default(false) bool isLoading,
  }) = _InitialContentModerationData;
}
