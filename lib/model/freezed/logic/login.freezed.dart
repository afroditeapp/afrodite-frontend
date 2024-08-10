// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

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
final _privateConstructorErrorLoginBlocData = UnsupportedError(
    'Private constructor LoginBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$LoginBlocData {
  AccountId? get accountId => throw _privateConstructorErrorLoginBlocData;

  LoginBlocData copyWith({
    AccountId? accountId,
  }) => throw _privateConstructorErrorLoginBlocData;
}

/// @nodoc
abstract class _LoginBlocData extends LoginBlocData {
  factory _LoginBlocData({
    AccountId? accountId,
  }) = _$LoginBlocDataImpl;
  _LoginBlocData._() : super._();
}

/// @nodoc
class _$LoginBlocDataImpl extends _LoginBlocData with DiagnosticableTreeMixin {
  _$LoginBlocDataImpl({
    this.accountId,
  }) : super._();

  @override
  final AccountId? accountId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginBlocData(accountId: $accountId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginBlocData'))
      ..add(DiagnosticsProperty('accountId', accountId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$LoginBlocDataImpl &&
        (identical(other.accountId, accountId) ||
          other.accountId == accountId)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
  );

  @override
  LoginBlocData copyWith({
    Object? accountId = _detectDefaultValueInCopyWith,
  }) => _$LoginBlocDataImpl(
    accountId: (accountId == _detectDefaultValueInCopyWith ? this.accountId : accountId) as AccountId?,
  );
}
