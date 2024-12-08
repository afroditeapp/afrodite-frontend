
import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:app/utils/immutable_list.dart";

part 'select_content.freezed.dart';

@freezed
class SelectContentData with _$SelectContentData {
  factory SelectContentData({
    @Default(UnmodifiableList<MyContent>.empty()) UnmodifiableList<MyContent> availableContent,
    @Default(0) int maxContent,
    @Default(false) bool showAddNewContent,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
  }) = _SelectContentData;
}
