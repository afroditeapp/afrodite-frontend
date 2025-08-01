import "package:app/ui_utils/attribute/attribute.dart";
import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'attributes.freezed.dart';

@freezed
class AttributesData with _$AttributesData {
  AttributesData._();
  factory AttributesData({
    String? locale,
    ProfileAttributes? attributes,
    AttributeManager? manager,
  }) = _AttributesData;

  int requiredAttributesCount() => manager?.requiredAttributes().length ?? 0;
}
