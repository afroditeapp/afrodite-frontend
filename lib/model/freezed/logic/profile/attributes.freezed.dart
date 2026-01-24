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
  bool get loadingComplete => throw _privateConstructorErrorAttributesData;

  AttributesData copyWith({
    String? locale,
    ProfileAttributes? attributes,
    AttributeManager? manager,
    bool? loadingComplete,
  }) => throw _privateConstructorErrorAttributesData;
}

/// @nodoc
abstract class _AttributesData extends AttributesData {
  factory _AttributesData({
    String? locale,
    ProfileAttributes? attributes,
    AttributeManager? manager,
    bool loadingComplete,
  }) = _$AttributesDataImpl;
  _AttributesData._() : super._();
}

/// @nodoc
class _$AttributesDataImpl extends _AttributesData {
  static const bool _loadingCompleteDefaultValue = false;
  
  _$AttributesDataImpl({
    this.locale,
    this.attributes,
    this.manager,
    this.loadingComplete = _loadingCompleteDefaultValue,
  }) : super._();

  @override
  final String? locale;
  @override
  final ProfileAttributes? attributes;
  @override
  final AttributeManager? manager;
  @override
  final bool loadingComplete;

  @override
  String toString() {
    return 'AttributesData(locale: $locale, attributes: $attributes, manager: $manager, loadingComplete: $loadingComplete)';
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
          other.manager == manager) &&
        (identical(other.loadingComplete, loadingComplete) ||
          other.loadingComplete == loadingComplete)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    locale,
    attributes,
    manager,
    loadingComplete,
  );

  @override
  AttributesData copyWith({
    Object? locale = _detectDefaultValueInCopyWith,
    Object? attributes = _detectDefaultValueInCopyWith,
    Object? manager = _detectDefaultValueInCopyWith,
    Object? loadingComplete,
  }) => _$AttributesDataImpl(
    locale: (locale == _detectDefaultValueInCopyWith ? this.locale : locale) as String?,
    attributes: (attributes == _detectDefaultValueInCopyWith ? this.attributes : attributes) as ProfileAttributes?,
    manager: (manager == _detectDefaultValueInCopyWith ? this.manager : manager) as AttributeManager?,
    loadingComplete: (loadingComplete ?? this.loadingComplete) as bool,
  );
}
