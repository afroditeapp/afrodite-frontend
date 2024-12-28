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
  ProfileAttributes? get attributes => throw _privateConstructorErrorAttributesData;
  AttributeRefreshState? get refreshState => throw _privateConstructorErrorAttributesData;

  AttributesData copyWith({
    ProfileAttributes? attributes,
    AttributeRefreshState? refreshState,
  }) => throw _privateConstructorErrorAttributesData;
}

/// @nodoc
abstract class _AttributesData implements AttributesData {
  factory _AttributesData({
    ProfileAttributes? attributes,
    AttributeRefreshState? refreshState,
  }) = _$AttributesDataImpl;
}

/// @nodoc
class _$AttributesDataImpl implements _AttributesData {
  _$AttributesDataImpl({
    this.attributes,
    this.refreshState,
  });

  @override
  final ProfileAttributes? attributes;
  @override
  final AttributeRefreshState? refreshState;

  @override
  String toString() {
    return 'AttributesData(attributes: $attributes, refreshState: $refreshState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AttributesDataImpl &&
        (identical(other.attributes, attributes) ||
          other.attributes == attributes) &&
        (identical(other.refreshState, refreshState) ||
          other.refreshState == refreshState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    attributes,
    refreshState,
  );

  @override
  AttributesData copyWith({
    Object? attributes = _detectDefaultValueInCopyWith,
    Object? refreshState = _detectDefaultValueInCopyWith,
  }) => _$AttributesDataImpl(
    attributes: (attributes == _detectDefaultValueInCopyWith ? this.attributes : attributes) as ProfileAttributes?,
    refreshState: (refreshState == _detectDefaultValueInCopyWith ? this.refreshState : refreshState) as AttributeRefreshState?,
  );
}
