
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:app/utils/immutable_list.dart";

part 'select_content.freezed.dart';

@freezed
class SelectContentData with _$SelectContentData {
  factory SelectContentData({
    @Default(UnmodifiableList<ContentIdAndFaceDetected>.empty()) UnmodifiableList<ContentIdAndFaceDetected> availableContent,
    @Default(UnmodifiableList<ContentIdAndFaceDetected>.empty()) UnmodifiableList<ContentIdAndFaceDetected> pendingModeration,
    @Default(false) bool initialModerationOngoing,
    @Default(false) bool showMakeNewModerationRequest,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
  }) = _SelectContentData;
}

class ContentIdAndFaceDetected {
  final ContentId contentId;
  final bool faceDetected;
  ContentIdAndFaceDetected(this.contentId, this.faceDetected);
}
