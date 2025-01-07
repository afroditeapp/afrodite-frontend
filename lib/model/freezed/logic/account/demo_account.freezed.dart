// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_account.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorDemoAccountBlocData = UnsupportedError(
    'Private constructor DemoAccountBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$DemoAccountBlocData {
  bool get logoutInProgress => throw _privateConstructorErrorDemoAccountBlocData;
  UnmodifiableList<AccessibleAccount> get accounts => throw _privateConstructorErrorDemoAccountBlocData;

  DemoAccountBlocData copyWith({
    bool? logoutInProgress,
    UnmodifiableList<AccessibleAccount>? accounts,
  }) => throw _privateConstructorErrorDemoAccountBlocData;
}

/// @nodoc
abstract class _DemoAccountBlocData implements DemoAccountBlocData {
  factory _DemoAccountBlocData({
    bool logoutInProgress,
    UnmodifiableList<AccessibleAccount> accounts,
  }) = _$DemoAccountBlocDataImpl;
}

/// @nodoc
class _$DemoAccountBlocDataImpl with DiagnosticableTreeMixin implements _DemoAccountBlocData {
  static const bool _logoutInProgressDefaultValue = false;
  static const UnmodifiableList<AccessibleAccount> _accountsDefaultValue = UnmodifiableList<AccessibleAccount>.empty();
  
  _$DemoAccountBlocDataImpl({
    this.logoutInProgress = _logoutInProgressDefaultValue,
    this.accounts = _accountsDefaultValue,
  });

  @override
  final bool logoutInProgress;
  @override
  final UnmodifiableList<AccessibleAccount> accounts;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemoAccountBlocData(logoutInProgress: $logoutInProgress, accounts: $accounts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemoAccountBlocData'))
      ..add(DiagnosticsProperty('logoutInProgress', logoutInProgress))
      ..add(DiagnosticsProperty('accounts', accounts));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$DemoAccountBlocDataImpl &&
        (identical(other.logoutInProgress, logoutInProgress) ||
          other.logoutInProgress == logoutInProgress) &&
        (identical(other.accounts, accounts) ||
          other.accounts == accounts)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    logoutInProgress,
    accounts,
  );

  @override
  DemoAccountBlocData copyWith({
    Object? logoutInProgress,
    Object? accounts,
  }) => _$DemoAccountBlocDataImpl(
    logoutInProgress: (logoutInProgress ?? this.logoutInProgress) as bool,
    accounts: (accounts ?? this.accounts) as UnmodifiableList<AccessibleAccount>,
  );
}
