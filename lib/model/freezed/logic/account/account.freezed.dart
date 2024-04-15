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
  AccountId? get accountId => throw _privateConstructorErrorAccountBlocData;
  String? get email => throw _privateConstructorErrorAccountBlocData;
  AccountState? get accountState => throw _privateConstructorErrorAccountBlocData;
  Capabilities get capabilities => throw _privateConstructorErrorAccountBlocData;
  ProfileVisibility get visibility => throw _privateConstructorErrorAccountBlocData;

  AccountBlocData copyWith({
    AccountId? accountId,
    String? email,
    AccountState? accountState,
    Capabilities? capabilities,
    ProfileVisibility? visibility,
  }) => throw _privateConstructorErrorAccountBlocData;
}

/// @nodoc
abstract class _AccountBlocData implements AccountBlocData {
  factory _AccountBlocData({
    AccountId? accountId,
    String? email,
    AccountState? accountState,
    required Capabilities capabilities,
    required ProfileVisibility visibility,
  }) = _$AccountBlocDataImpl;
}

/// @nodoc
class _$AccountBlocDataImpl with DiagnosticableTreeMixin implements _AccountBlocData {
  _$AccountBlocDataImpl({
    this.accountId,
    this.email,
    this.accountState,
    required this.capabilities,
    required this.visibility,
  });

  @override
  final AccountId? accountId;
  @override
  final String? email;
  @override
  final AccountState? accountState;
  @override
  final Capabilities capabilities;
  @override
  final ProfileVisibility visibility;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountBlocData(accountId: $accountId, email: $email, accountState: $accountState, capabilities: $capabilities, visibility: $visibility)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountBlocData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('accountState', accountState))
      ..add(DiagnosticsProperty('capabilities', capabilities))
      ..add(DiagnosticsProperty('visibility', visibility));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountBlocDataImpl &&
        (identical(other.accountId, accountId) ||
          other.accountId == accountId) &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.accountState, accountState) ||
          other.accountState == accountState) &&
        (identical(other.capabilities, capabilities) ||
          other.capabilities == capabilities) &&
        (identical(other.visibility, visibility) ||
          other.visibility == visibility)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    email,
    accountState,
    capabilities,
    visibility,
  );

  @override
  AccountBlocData copyWith({
    Object? accountId = _detectDefaultValueInCopyWith,
    Object? email = _detectDefaultValueInCopyWith,
    Object? accountState = _detectDefaultValueInCopyWith,
    Object? capabilities,
    Object? visibility,
  }) => _$AccountBlocDataImpl(
    accountId: (accountId == _detectDefaultValueInCopyWith ? this.accountId : accountId) as AccountId?,
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    accountState: (accountState == _detectDefaultValueInCopyWith ? this.accountState : accountState) as AccountState?,
    capabilities: (capabilities ?? this.capabilities) as Capabilities,
    visibility: (visibility ?? this.visibility) as ProfileVisibility,
  );
}
