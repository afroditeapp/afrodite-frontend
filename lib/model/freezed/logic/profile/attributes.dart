import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'attributes.freezed.dart';

@freezed
class AttributesData with _$AttributesData {
  factory AttributesData({
    ProfileAttributes? attributes,
    AttributeRefreshState? refreshState,
  }) = _AttributesData;
}

sealed class AttributeRefreshState {}
class AttributeRefreshLoading extends AttributeRefreshState {}
