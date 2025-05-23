// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributes.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
class _DetectDefaultValueInCopyWith {
  const _DetectDefaultValueInCopyWith();
}

/// @nodoc
const _detectDefaultValueInCopyWith = _DetectDefaultValueInCopyWith();

/// @nodoc
final _privateConstructorErrorAttributesData = UnsupportedError(
    'Private constructor AttributesData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AttributesData {
  String? get locale => throw _privateConstructorErrorAttributesData;
  ProfileAttributes? get attributes => throw _privateConstructorErrorAttributesData;
  AttributeManager? get manager => throw _privateConstructorErrorAttributesData;

  AttributesData copyWith({
    String? locale,
    ProfileAttributes? attributes,
    AttributeManager? manager,
  }) => throw _privateConstructorErrorAttributesData;
}

/// @nodoc
abstract class _AttributesData extends AttributesData {
  factory _AttributesData({
    String? locale,
    ProfileAttributes? attributes,
    AttributeManager? manager,
  }) = _$AttributesDataImpl;
  _AttributesData._() : super._();
}

/// @nodoc
class _$AttributesDataImpl extends _AttributesData {
  _$AttributesDataImpl({
    this.locale,
    this.attributes,
    this.manager,
  }) : super._();

  @override
  final String? locale;
  @override
  final ProfileAttributes? attributes;
  @override
  final AttributeManager? manager;

  @override
  String toString() {
    return 'AttributesData(locale: $locale, attributes: $attributes, manager: $manager)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AttributesDataImpl &&
        (identical(other.locale, locale) ||
          other.locale == locale) &&
        (identical(other.attributes, attributes) ||
          other.attributes == attributes) &&
        (identical(other.manager, manager) ||
          other.manager == manager)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    locale,
    attributes,
    manager,
  );

  @override
  AttributesData copyWith({
    Object? locale = _detectDefaultValueInCopyWith,
    Object? attributes = _detectDefaultValueInCopyWith,
    Object? manager = _detectDefaultValueInCopyWith,
  }) => _$AttributesDataImpl(
    locale: (locale == _detectDefaultValueInCopyWith ? this.locale : locale) as String?,
    attributes: (attributes == _detectDefaultValueInCopyWith ? this.attributes : attributes) as ProfileAttributes?,
    manager: (manager == _detectDefaultValueInCopyWith ? this.manager : manager) as AttributeManager?,
  );
}
