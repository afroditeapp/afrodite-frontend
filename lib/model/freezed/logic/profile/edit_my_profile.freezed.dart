// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_my_profile.dart';

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
final _privateConstructorErrorEditMyProfileData = UnsupportedError(
    'Private constructor EditMyProfileData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EditMyProfileData {
  int? get age => throw _privateConstructorErrorEditMyProfileData;
  String? get initial => throw _privateConstructorErrorEditMyProfileData;

  EditMyProfileData copyWith({
    int? age,
    String? initial,
  }) => throw _privateConstructorErrorEditMyProfileData;
}

/// @nodoc
abstract class _EditMyProfileData implements EditMyProfileData {
  factory _EditMyProfileData({
    int? age,
    String? initial,
  }) = _$EditMyProfileDataImpl;
}

/// @nodoc
class _$EditMyProfileDataImpl with DiagnosticableTreeMixin implements _EditMyProfileData {
  _$EditMyProfileDataImpl({
    this.age,
    this.initial,
  });

  @override
  final int? age;
  @override
  final String? initial;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditMyProfileData(age: $age, initial: $initial)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditMyProfileData'))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('initial', initial));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EditMyProfileDataImpl &&
        (identical(other.age, age) ||
          other.age == age) &&
        (identical(other.initial, initial) ||
          other.initial == initial)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    age,
    initial,
  );

  @override
  EditMyProfileData copyWith({
    Object? age = _detectDefaultValueInCopyWith,
    Object? initial = _detectDefaultValueInCopyWith,
  }) => _$EditMyProfileDataImpl(
    age: (age == _detectDefaultValueInCopyWith ? this.age : age) as int?,
    initial: (initial == _detectDefaultValueInCopyWith ? this.initial : initial) as String?,
  );
}
