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
  AccountState? get accountState => throw _privateConstructorErrorAccountBlocData;
  Permissions get permissions => throw _privateConstructorErrorAccountBlocData;
  ProfileVisibility get visibility => throw _privateConstructorErrorAccountBlocData;

  AccountBlocData copyWith({
    String? email,
    AccountState? accountState,
    Permissions? permissions,
    ProfileVisibility? visibility,
  }) => throw _privateConstructorErrorAccountBlocData;
}

/// @nodoc
abstract class _AccountBlocData extends AccountBlocData {
  factory _AccountBlocData({
    String? email,
    required AccountState? accountState,
    required Permissions permissions,
    required ProfileVisibility visibility,
  }) = _$AccountBlocDataImpl;
  _AccountBlocData._() : super._();
}

/// @nodoc
class _$AccountBlocDataImpl extends _AccountBlocData with DiagnosticableTreeMixin {
  _$AccountBlocDataImpl({
    this.email,
    required this.accountState,
    required this.permissions,
    required this.visibility,
  }) : super._();

  @override
  final String? email;
  @override
  final AccountState? accountState;
  @override
  final Permissions permissions;
  @override
  final ProfileVisibility visibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountBlocData(email: $email, accountState: $accountState, permissions: $permissions, visibility: $visibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountBlocData'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('accountState', accountState))
      ..add(DiagnosticsProperty('permissions', permissions))
      ..add(DiagnosticsProperty('visibility', visibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountBlocDataImpl &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.accountState, accountState) ||
          other.accountState == accountState) &&
        (identical(other.permissions, permissions) ||
          other.permissions == permissions) &&
        (identical(other.visibility, visibility) ||
          other.visibility == visibility)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    email,
    accountState,
    permissions,
    visibility,
  );

  @override
  AccountBlocData copyWith({
    Object? email = _detectDefaultValueInCopyWith,
    Object? accountState = _detectDefaultValueInCopyWith,
    Object? permissions,
    Object? visibility,
  }) => _$AccountBlocDataImpl(
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    accountState: (accountState == _detectDefaultValueInCopyWith ? this.accountState : accountState) as AccountState?,
    permissions: (permissions ?? this.permissions) as Permissions,
    visibility: (visibility ?? this.visibility) as ProfileVisibility,
  );
}
