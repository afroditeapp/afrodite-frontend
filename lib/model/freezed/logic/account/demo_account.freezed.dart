// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_account.dart';

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
final _privateConstructorErrorDemoAccountBlocData = UnsupportedError(
    'Private constructor DemoAccountBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$DemoAccountBlocData {
  String? get userId => throw _privateConstructorErrorDemoAccountBlocData;
  String? get password => throw _privateConstructorErrorDemoAccountBlocData;
  bool get loginProgressVisible => throw _privateConstructorErrorDemoAccountBlocData;
  List<AccessibleAccount> get accounts => throw _privateConstructorErrorDemoAccountBlocData;

  DemoAccountBlocData copyWith({
    String? userId,
    String? password,
    bool? loginProgressVisible,
    List<AccessibleAccount>? accounts,
  }) => throw _privateConstructorErrorDemoAccountBlocData;
}

/// @nodoc
abstract class _DemoAccountBlocData implements DemoAccountBlocData {
  factory _DemoAccountBlocData({
    String? userId,
    String? password,
    bool loginProgressVisible,
    List<AccessibleAccount> accounts,
  }) = _$DemoAccountBlocDataImpl;
}

/// @nodoc
class _$DemoAccountBlocDataImpl with DiagnosticableTreeMixin implements _DemoAccountBlocData {
  static const bool _loginProgressVisibleDefaultValue = false;
  static const List<AccessibleAccount> _accountsDefaultValue = [];
  
  _$DemoAccountBlocDataImpl({
    this.userId,
    this.password,
    this.loginProgressVisible = _loginProgressVisibleDefaultValue,
    this.accounts = _accountsDefaultValue,
  });

  @override
  final String? userId;
  @override
  final String? password;
  @override
  final bool loginProgressVisible;
  @override
  final List<AccessibleAccount> accounts;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemoAccountBlocData(userId: $userId, password: $password, loginProgressVisible: $loginProgressVisible, accounts: $accounts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemoAccountBlocData'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('loginProgressVisible', loginProgressVisible))
      ..add(DiagnosticsProperty('accounts', accounts));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$DemoAccountBlocDataImpl &&
        (identical(other.userId, userId) ||
          other.userId == userId) &&
        (identical(other.password, password) ||
          other.password == password) &&
        (identical(other.loginProgressVisible, loginProgressVisible) ||
          other.loginProgressVisible == loginProgressVisible) &&
        (identical(other.accounts, accounts) ||
          other.accounts == accounts)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    password,
    loginProgressVisible,
    accounts,
  );

  @override
  DemoAccountBlocData copyWith({
    Object? userId = _detectDefaultValueInCopyWith,
    Object? password = _detectDefaultValueInCopyWith,
    Object? loginProgressVisible,
    Object? accounts,
  }) => _$DemoAccountBlocDataImpl(
    userId: (userId == _detectDefaultValueInCopyWith ? this.userId : userId) as String?,
    password: (password == _detectDefaultValueInCopyWith ? this.password : password) as String?,
    loginProgressVisible: (loginProgressVisible ?? this.loginProgressVisible) as bool,
    accounts: (accounts ?? this.accounts) as List<AccessibleAccount>,
  );
}
