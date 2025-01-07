// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorLoginBlocData = UnsupportedError(
    'Private constructor LoginBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$LoginBlocData {
  bool get logoutInProgress => throw _privateConstructorErrorLoginBlocData;

  LoginBlocData copyWith({
    bool? logoutInProgress,
  }) => throw _privateConstructorErrorLoginBlocData;
}

/// @nodoc
abstract class _LoginBlocData extends LoginBlocData {
  factory _LoginBlocData({
    bool logoutInProgress,
  }) = _$LoginBlocDataImpl;
  _LoginBlocData._() : super._();
}

/// @nodoc
class _$LoginBlocDataImpl extends _LoginBlocData with DiagnosticableTreeMixin {
  static const bool _logoutInProgressDefaultValue = false;
  
  _$LoginBlocDataImpl({
    this.logoutInProgress = _logoutInProgressDefaultValue,
  }) : super._();

  @override
  final bool logoutInProgress;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LoginBlocData(logoutInProgress: $logoutInProgress)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LoginBlocData'))
      ..add(DiagnosticsProperty('logoutInProgress', logoutInProgress));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$LoginBlocDataImpl &&
        (identical(other.logoutInProgress, logoutInProgress) ||
          other.logoutInProgress == logoutInProgress)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    logoutInProgress,
  );

  @override
  LoginBlocData copyWith({
    Object? logoutInProgress,
  }) => _$LoginBlocDataImpl(
    logoutInProgress: (logoutInProgress ?? this.logoutInProgress) as bool,
  );
}
