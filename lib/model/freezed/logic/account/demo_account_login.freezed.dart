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
  String? get username => throw _privateConstructorErrorDemoAccountLoginData;
  String? get password => throw _privateConstructorErrorDemoAccountLoginData;
  bool get loginProgressVisible => throw _privateConstructorErrorDemoAccountLoginData;

  DemoAccountLoginData copyWith({
    String? username,
    String? password,
    bool? loginProgressVisible,
  }) => throw _privateConstructorErrorDemoAccountLoginData;
}

/// @nodoc
abstract class _DemoAccountLoginData implements DemoAccountLoginData {
  factory _DemoAccountLoginData({
    String? username,
    String? password,
    bool loginProgressVisible,
  }) = _$DemoAccountLoginDataImpl;
}

/// @nodoc
class _$DemoAccountLoginDataImpl with DiagnosticableTreeMixin implements _DemoAccountLoginData {
  static const bool _loginProgressVisibleDefaultValue = false;
  
  _$DemoAccountLoginDataImpl({
    this.username,
    this.password,
    this.loginProgressVisible = _loginProgressVisibleDefaultValue,
  });

  @override
  final String? username;
  @override
  final String? password;
  @override
  final bool loginProgressVisible;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemoAccountLoginData(username: $username, password: $password, loginProgressVisible: $loginProgressVisible)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemoAccountLoginData'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('loginProgressVisible', loginProgressVisible));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$DemoAccountLoginDataImpl &&
        (identical(other.username, username) ||
          other.username == username) &&
        (identical(other.password, password) ||
          other.password == password) &&
        (identical(other.loginProgressVisible, loginProgressVisible) ||
          other.loginProgressVisible == loginProgressVisible)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    username,
    password,
    loginProgressVisible,
  );

  @override
  DemoAccountLoginData copyWith({
    Object? username = _detectDefaultValueInCopyWith,
    Object? password = _detectDefaultValueInCopyWith,
    Object? loginProgressVisible,
  }) => _$DemoAccountLoginDataImpl(
    username: (username == _detectDefaultValueInCopyWith ? this.username : username) as String?,
    password: (password == _detectDefaultValueInCopyWith ? this.password : password) as String?,
    loginProgressVisible: (loginProgressVisible ?? this.loginProgressVisible) as bool,
  );
}
