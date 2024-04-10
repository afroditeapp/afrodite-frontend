// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MyProfileData {
  ProfileUpdateState get profileUpdateState =>
      throw _privateConstructorUsedError;
  ProfileEntry? get profile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyProfileDataCopyWith<MyProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProfileDataCopyWith<$Res> {
  factory $MyProfileDataCopyWith(
          MyProfileData value, $Res Function(MyProfileData) then) =
      _$MyProfileDataCopyWithImpl<$Res, MyProfileData>;
  @useResult
  $Res call({ProfileUpdateState profileUpdateState, ProfileEntry? profile});
}

/// @nodoc
class _$MyProfileDataCopyWithImpl<$Res, $Val extends MyProfileData>
    implements $MyProfileDataCopyWith<$Res> {
  _$MyProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileUpdateState = null,
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      profileUpdateState: null == profileUpdateState
          ? _value.profileUpdateState
          : profileUpdateState // ignore: cast_nullable_to_non_nullable
              as ProfileUpdateState,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileEntry?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyProfileDataImplCopyWith<$Res>
    implements $MyProfileDataCopyWith<$Res> {
  factory _$$MyProfileDataImplCopyWith(
          _$MyProfileDataImpl value, $Res Function(_$MyProfileDataImpl) then) =
      __$$MyProfileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProfileUpdateState profileUpdateState, ProfileEntry? profile});
}

/// @nodoc
class __$$MyProfileDataImplCopyWithImpl<$Res>
    extends _$MyProfileDataCopyWithImpl<$Res, _$MyProfileDataImpl>
    implements _$$MyProfileDataImplCopyWith<$Res> {
  __$$MyProfileDataImplCopyWithImpl(
      _$MyProfileDataImpl _value, $Res Function(_$MyProfileDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileUpdateState = null,
    Object? profile = freezed,
  }) {
    return _then(_$MyProfileDataImpl(
      profileUpdateState: null == profileUpdateState
          ? _value.profileUpdateState
          : profileUpdateState // ignore: cast_nullable_to_non_nullable
              as ProfileUpdateState,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as ProfileEntry?,
    ));
  }
}

/// @nodoc

class _$MyProfileDataImpl extends _MyProfileData with DiagnosticableTreeMixin {
  _$MyProfileDataImpl(
      {this.profileUpdateState = const ProfileUpdateIdle(), this.profile})
      : super._();

  @override
  @JsonKey()
  final ProfileUpdateState profileUpdateState;
  @override
  final ProfileEntry? profile;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyProfileData(profileUpdateState: $profileUpdateState, profile: $profile)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyProfileData'))
      ..add(DiagnosticsProperty('profileUpdateState', profileUpdateState))
      ..add(DiagnosticsProperty('profile', profile));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyProfileDataImpl &&
            (identical(other.profileUpdateState, profileUpdateState) ||
                other.profileUpdateState == profileUpdateState) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profileUpdateState, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyProfileDataImplCopyWith<_$MyProfileDataImpl> get copyWith =>
      __$$MyProfileDataImplCopyWithImpl<_$MyProfileDataImpl>(this, _$identity);
}

abstract class _MyProfileData extends MyProfileData {
  factory _MyProfileData(
      {final ProfileUpdateState profileUpdateState,
      final ProfileEntry? profile}) = _$MyProfileDataImpl;
  _MyProfileData._() : super._();

  @override
  ProfileUpdateState get profileUpdateState;
  @override
  ProfileEntry? get profile;
  @override
  @JsonKey(ignore: true)
  _$$MyProfileDataImplCopyWith<_$MyProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
