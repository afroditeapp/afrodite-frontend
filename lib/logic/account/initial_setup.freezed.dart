// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initial_setup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InitialSetupData {
  String get email => throw _privateConstructorUsedError;
  String get profileName => throw _privateConstructorUsedError;
  XFile? get securitySelfie => throw _privateConstructorUsedError;
  XFile? get profileImage => throw _privateConstructorUsedError;
  String? get sendError => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InitialSetupDataCopyWith<InitialSetupData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitialSetupDataCopyWith<$Res> {
  factory $InitialSetupDataCopyWith(
          InitialSetupData value, $Res Function(InitialSetupData) then) =
      _$InitialSetupDataCopyWithImpl<$Res, InitialSetupData>;
  @useResult
  $Res call(
      {String email,
      String profileName,
      XFile? securitySelfie,
      XFile? profileImage,
      String? sendError,
      int currentStep});
}

/// @nodoc
class _$InitialSetupDataCopyWithImpl<$Res, $Val extends InitialSetupData>
    implements $InitialSetupDataCopyWith<$Res> {
  _$InitialSetupDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? profileName = null,
    Object? securitySelfie = freezed,
    Object? profileImage = freezed,
    Object? sendError = freezed,
    Object? currentStep = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileName: null == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String,
      securitySelfie: freezed == securitySelfie
          ? _value.securitySelfie
          : securitySelfie // ignore: cast_nullable_to_non_nullable
              as XFile?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      sendError: freezed == sendError
          ? _value.sendError
          : sendError // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialSetupDataCopyWith<$Res>
    implements $InitialSetupDataCopyWith<$Res> {
  factory _$$_InitialSetupDataCopyWith(
          _$_InitialSetupData value, $Res Function(_$_InitialSetupData) then) =
      __$$_InitialSetupDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String profileName,
      XFile? securitySelfie,
      XFile? profileImage,
      String? sendError,
      int currentStep});
}

/// @nodoc
class __$$_InitialSetupDataCopyWithImpl<$Res>
    extends _$InitialSetupDataCopyWithImpl<$Res, _$_InitialSetupData>
    implements _$$_InitialSetupDataCopyWith<$Res> {
  __$$_InitialSetupDataCopyWithImpl(
      _$_InitialSetupData _value, $Res Function(_$_InitialSetupData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? profileName = null,
    Object? securitySelfie = freezed,
    Object? profileImage = freezed,
    Object? sendError = freezed,
    Object? currentStep = null,
  }) {
    return _then(_$_InitialSetupData(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileName: null == profileName
          ? _value.profileName
          : profileName // ignore: cast_nullable_to_non_nullable
              as String,
      securitySelfie: freezed == securitySelfie
          ? _value.securitySelfie
          : securitySelfie // ignore: cast_nullable_to_non_nullable
              as XFile?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as XFile?,
      sendError: freezed == sendError
          ? _value.sendError
          : sendError // ignore: cast_nullable_to_non_nullable
              as String?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_InitialSetupData
    with DiagnosticableTreeMixin
    implements _InitialSetupData {
  _$_InitialSetupData(
      {this.email = "",
      this.profileName = "",
      this.securitySelfie,
      this.profileImage,
      this.sendError,
      this.currentStep = 0});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String profileName;
  @override
  final XFile? securitySelfie;
  @override
  final XFile? profileImage;
  @override
  final String? sendError;
  @override
  @JsonKey()
  final int currentStep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InitialSetupData(email: $email, profileName: $profileName, securitySelfie: $securitySelfie, profileImage: $profileImage, sendError: $sendError, currentStep: $currentStep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InitialSetupData'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('profileName', profileName))
      ..add(DiagnosticsProperty('securitySelfie', securitySelfie))
      ..add(DiagnosticsProperty('profileImage', profileImage))
      ..add(DiagnosticsProperty('sendError', sendError))
      ..add(DiagnosticsProperty('currentStep', currentStep));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InitialSetupData &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileName, profileName) ||
                other.profileName == profileName) &&
            (identical(other.securitySelfie, securitySelfie) ||
                other.securitySelfie == securitySelfie) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.sendError, sendError) ||
                other.sendError == sendError) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, profileName,
      securitySelfie, profileImage, sendError, currentStep);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialSetupDataCopyWith<_$_InitialSetupData> get copyWith =>
      __$$_InitialSetupDataCopyWithImpl<_$_InitialSetupData>(this, _$identity);
}

abstract class _InitialSetupData implements InitialSetupData {
  factory _InitialSetupData(
      {final String email,
      final String profileName,
      final XFile? securitySelfie,
      final XFile? profileImage,
      final String? sendError,
      final int currentStep}) = _$_InitialSetupData;

  @override
  String get email;
  @override
  String get profileName;
  @override
  XFile? get securitySelfie;
  @override
  XFile? get profileImage;
  @override
  String? get sendError;
  @override
  int get currentStep;
  @override
  @JsonKey(ignore: true)
  _$$_InitialSetupDataCopyWith<_$_InitialSetupData> get copyWith =>
      throw _privateConstructorUsedError;
}
