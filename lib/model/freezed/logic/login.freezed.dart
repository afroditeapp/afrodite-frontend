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
  bool get logoutInProgress => throw _privateConstructorErrorLoginBlocData;

  LoginBlocData copyWith({
    AccountId? accountId,
    bool? logoutInProgress,
  }) => throw _privateConstructorErrorLoginBlocData;
}

/// @nodoc
abstract class _LoginBlocData extends LoginBlocData {
  factory _LoginBlocData({
    AccountId? accountId,
    bool logoutInProgress,
  }) = _$LoginBlocDataImpl;
  _LoginBlocData._() : super._();
}

/// @nodoc
class _$LoginBlocDataImpl extends _LoginBlocData with DiagnosticableTreeMixin {
  static const bool _logoutInProgressDefaultValue = false;
  
  _$LoginBlocDataImpl({
    this.accountId,
    this.logoutInProgress = _logoutInProgressDefaultValue,
  }) : super._();

  @override
  final AccountId? accountId;
  @override
  final bool logoutInProgress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginBlocData(accountId: $accountId, logoutInProgress: $logoutInProgress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginBlocData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('logoutInProgress', logoutInProgress));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$LoginBlocDataImpl &&
        (identical(other.accountId, accountId) ||
          other.accountId == accountId) &&
        (identical(other.logoutInProgress, logoutInProgress) ||
          other.logoutInProgress == logoutInProgress)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accountId,
    logoutInProgress,
  );

  @override
  LoginBlocData copyWith({
    Object? accountId = _detectDefaultValueInCopyWith,
    Object? logoutInProgress,
  }) => _$LoginBlocDataImpl(
    accountId: (accountId == _detectDefaultValueInCopyWith ? this.accountId : accountId) as AccountId?,
    logoutInProgress: (logoutInProgress ?? this.logoutInProgress) as bool,
  );
}
