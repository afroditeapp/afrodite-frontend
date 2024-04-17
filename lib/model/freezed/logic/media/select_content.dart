
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

part 'select_content.freezed.dart';

@freezed
class SelectContentData with _$SelectContentData {
  factory SelectContentData({
    @Default(UnmodifiableList<ContentId>.empty()) UnmodifiableList<ContentId> availableContent,
    @Default(false) bool isLoading,
  }) = _SelectContentData;
}
