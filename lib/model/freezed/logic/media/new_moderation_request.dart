
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

part 'new_moderation_request.freezed.dart';


@freezed
class NewModerationRequestData with _$NewModerationRequestData {
  factory NewModerationRequestData({
    @Default(UnmodifiableList<ContentId>.empty()) UnmodifiableList<ContentId> selectedImgs,
  }) = _NewModerationRequestData;
}
