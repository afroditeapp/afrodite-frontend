// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProfileData {
  Profile? get profile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileDataCopyWith<ProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileDataCopyWith<$Res> {
  factory $ProfileDataCopyWith(
          ProfileData value, $Res Function(ProfileData) then) =
      _$ProfileDataCopyWithImpl<$Res, ProfileData>;
  @useResult
  $Res call({Profile? profile});
}

/// @nodoc
class _$ProfileDataCopyWithImpl<$Res, $Val extends ProfileData>
    implements $ProfileDataCopyWith<$Res> {
  _$ProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProfileDataCopyWith<$Res>
    implements $ProfileDataCopyWith<$Res> {
  factory _$$_ProfileDataCopyWith(
          _$_ProfileData value, $Res Function(_$_ProfileData) then) =
      __$$_ProfileDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Profile? profile});
}

/// @nodoc
class __$$_ProfileDataCopyWithImpl<$Res>
    extends _$ProfileDataCopyWithImpl<$Res, _$_ProfileData>
    implements _$$_ProfileDataCopyWith<$Res> {
  __$$_ProfileDataCopyWithImpl(
      _$_ProfileData _value, $Res Function(_$_ProfileData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = freezed,
  }) {
    return _then(_$_ProfileData(
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
    ));
  }
}

/// @nodoc

class _$_ProfileData with DiagnosticableTreeMixin implements _ProfileData {
  _$_ProfileData({this.profile});

  @override
  final Profile? profile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProfileData(profile: $profile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProfileData'))
      ..add(DiagnosticsProperty('profile', profile));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileData &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileDataCopyWith<_$_ProfileData> get copyWith =>
      __$$_ProfileDataCopyWithImpl<_$_ProfileData>(this, _$identity);
}

abstract class _ProfileData implements ProfileData {
  factory _ProfileData({final Profile? profile}) = _$_ProfileData;

  @override
  Profile? get profile;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileDataCopyWith<_$_ProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}
