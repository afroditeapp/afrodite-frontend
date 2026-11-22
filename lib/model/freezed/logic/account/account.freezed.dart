// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

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
final _privateConstructorErrorAccountBlocData = UnsupportedError(
    'Private constructor AccountBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AccountBlocData {
  String? get email => throw _privateConstructorErrorAccountBlocData;
  bool get emailVerified => throw _privateConstructorErrorAccountBlocData;
  AccountStateInternal? get accountState => throw _privateConstructorErrorAccountBlocData;
  Permissions get permissions => throw _privateConstructorErrorAccountBlocData;
  ProfileVisibility get visibility => throw _privateConstructorErrorAccountBlocData;
  Gender? get gender => throw _privateConstructorErrorAccountBlocData;

  AccountBlocData copyWith({
    String? email,
    bool? emailVerified,
    AccountStateInternal? accountState,
    Permissions? permissions,
    ProfileVisibility? visibility,
    Gender? gender,
  }) => throw _privateConstructorErrorAccountBlocData;
}

/// @nodoc
abstract class _AccountBlocData extends AccountBlocData {
  factory _AccountBlocData({
    String? email,
    bool emailVerified,
    required AccountStateInternal? accountState,
    required Permissions permissions,
    required ProfileVisibility visibility,
    Gender? gender,
  }) = _$AccountBlocDataImpl;
  _AccountBlocData._() : super._();
}

/// @nodoc
class _$AccountBlocDataImpl extends _AccountBlocData with DiagnosticableTreeMixin {
  static const bool _emailVerifiedDefaultValue = true;

  _$AccountBlocDataImpl({
    this.email,
    this.emailVerified = _emailVerifiedDefaultValue,
    required this.accountState,
    required this.permissions,
    required this.visibility,
    this.gender,
  }) : super._();

  @override
  final String? email;
  @override
  final bool emailVerified;
  @override
  final AccountStateInternal? accountState;
  @override
  final Permissions permissions;
  @override
  final ProfileVisibility visibility;
  @override
  final Gender? gender;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountBlocData(email: $email, emailVerified: $emailVerified, accountState: $accountState, permissions: $permissions, visibility: $visibility, gender: $gender)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountBlocData'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('emailVerified', emailVerified))
      ..add(DiagnosticsProperty('accountState', accountState))
      ..add(DiagnosticsProperty('permissions', permissions))
      ..add(DiagnosticsProperty('visibility', visibility))
      ..add(DiagnosticsProperty('gender', gender));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountBlocDataImpl &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.emailVerified, emailVerified) ||
          other.emailVerified == emailVerified) &&
        (identical(other.accountState, accountState) ||
          other.accountState == accountState) &&
        (identical(other.permissions, permissions) ||
          other.permissions == permissions) &&
        (identical(other.visibility, visibility) ||
          other.visibility == visibility) &&
        (identical(other.gender, gender) ||
          other.gender == gender)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    email,
    emailVerified,
    accountState,
    permissions,
    visibility,
    gender,
  );

  @override
  AccountBlocData copyWith({
    Object? email = _detectDefaultValueInCopyWith,
    Object? emailVerified,
    Object? accountState = _detectDefaultValueInCopyWith,
    Object? permissions,
    Object? visibility,
    Object? gender = _detectDefaultValueInCopyWith,
  }) => _$AccountBlocDataImpl(
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    emailVerified: (emailVerified ?? this.emailVerified) as bool,
    accountState: (accountState == _detectDefaultValueInCopyWith ? this.accountState : accountState) as AccountStateInternal?,
    permissions: (permissions ?? this.permissions) as Permissions,
    visibility: (visibility ?? this.visibility) as ProfileVisibility,
    gender: (gender == _detectDefaultValueInCopyWith ? this.gender : gender) as Gender?,
  );
}
