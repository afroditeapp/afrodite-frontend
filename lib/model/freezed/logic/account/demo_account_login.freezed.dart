// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_account_login.dart';

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
final _privateConstructorErrorDemoAccountLoginData = UnsupportedError(
    'Private constructor DemoAccountLoginData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$DemoAccountLoginData {
  String? get userId => throw _privateConstructorErrorDemoAccountLoginData;
  String? get password => throw _privateConstructorErrorDemoAccountLoginData;
  bool get loginProgressVisible => throw _privateConstructorErrorDemoAccountLoginData;

  DemoAccountLoginData copyWith({
    String? userId,
    String? password,
    bool? loginProgressVisible,
  }) => throw _privateConstructorErrorDemoAccountLoginData;
}

/// @nodoc
abstract class _DemoAccountLoginData implements DemoAccountLoginData {
  factory _DemoAccountLoginData({
    String? userId,
    String? password,
    bool loginProgressVisible,
  }) = _$DemoAccountLoginDataImpl;
}

/// @nodoc
class _$DemoAccountLoginDataImpl with DiagnosticableTreeMixin implements _DemoAccountLoginData {
  static const bool _loginProgressVisibleDefaultValue = false;
  
  _$DemoAccountLoginDataImpl({
    this.userId,
    this.password,
    this.loginProgressVisible = _loginProgressVisibleDefaultValue,
  });

  @override
  final String? userId;
  @override
  final String? password;
  @override
  final bool loginProgressVisible;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemoAccountLoginData(userId: $userId, password: $password, loginProgressVisible: $loginProgressVisible)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemoAccountLoginData'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('loginProgressVisible', loginProgressVisible));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$DemoAccountLoginDataImpl &&
        (identical(other.userId, userId) ||
          other.userId == userId) &&
        (identical(other.password, password) ||
          other.password == password) &&
        (identical(other.loginProgressVisible, loginProgressVisible) ||
          other.loginProgressVisible == loginProgressVisible)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    password,
    loginProgressVisible,
  );

  @override
  DemoAccountLoginData copyWith({
    Object? userId = _detectDefaultValueInCopyWith,
    Object? password = _detectDefaultValueInCopyWith,
    Object? loginProgressVisible,
  }) => _$DemoAccountLoginDataImpl(
    userId: (userId == _detectDefaultValueInCopyWith ? this.userId : userId) as String?,
    password: (password == _detectDefaultValueInCopyWith ? this.password : password) as String?,
    loginProgressVisible: (loginProgressVisible ?? this.loginProgressVisible) as bool,
  );
}
