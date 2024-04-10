import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";

part 'attributes.freezed.dart';

@freezed
class AttributesData with _$AttributesData {
  factory AttributesData({
    AvailableProfileAttributes? attributes,
    AttributeRefreshState? refreshState,
  }) = _AttributesData;
}

sealed class AttributeRefreshState {}
class AttributeRefreshLoading extends AttributeRefreshState {}
