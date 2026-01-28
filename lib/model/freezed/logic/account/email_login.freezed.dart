// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_login.dart';

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
final _privateConstructorErrorEmailLoginBlocData = UnsupportedError(
    'Private constructor EmailLoginBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$EmailLoginBlocData {
  bool get isLoading => throw _privateConstructorErrorEmailLoginBlocData;
  EmailLoginError? get error => throw _privateConstructorErrorEmailLoginBlocData;
  String? get email => throw _privateConstructorErrorEmailLoginBlocData;
  EmailLoginToken? get clientToken => throw _privateConstructorErrorEmailLoginBlocData;
  int? get tokenValiditySeconds => throw _privateConstructorErrorEmailLoginBlocData;
  int? get resendWaitSeconds => throw _privateConstructorErrorEmailLoginBlocData;
  UpdateState get updateState => throw _privateConstructorErrorEmailLoginBlocData;

  EmailLoginBlocData copyWith({
    bool? isLoading,
    EmailLoginError? error,
    String? email,
    EmailLoginToken? clientToken,
    int? tokenValiditySeconds,
    int? resendWaitSeconds,
    UpdateState? updateState,
  }) => throw _privateConstructorErrorEmailLoginBlocData;
}

/// @nodoc
abstract class _EmailLoginBlocData implements EmailLoginBlocData {
  factory _EmailLoginBlocData({
    bool isLoading,
    EmailLoginError? error,
    String? email,
    EmailLoginToken? clientToken,
    int? tokenValiditySeconds,
    int? resendWaitSeconds,
    UpdateState updateState,
  }) = _$EmailLoginBlocDataImpl;
}

/// @nodoc
class _$EmailLoginBlocDataImpl with DiagnosticableTreeMixin implements _EmailLoginBlocData {
  static const bool _isLoadingDefaultValue = false;
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$EmailLoginBlocDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.error,
    this.email,
    this.clientToken,
    this.tokenValiditySeconds,
    this.resendWaitSeconds,
    this.updateState = _updateStateDefaultValue,
  });

  @override
  final bool isLoading;
  @override
  final EmailLoginError? error;
  @override
  final String? email;
  @override
  final EmailLoginToken? clientToken;
  @override
  final int? tokenValiditySeconds;
  @override
  final int? resendWaitSeconds;
  @override
  final UpdateState updateState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EmailLoginBlocData(isLoading: $isLoading, error: $error, email: $email, clientToken: $clientToken, tokenValiditySeconds: $tokenValiditySeconds, resendWaitSeconds: $resendWaitSeconds, updateState: $updateState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EmailLoginBlocData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('clientToken', clientToken))
      ..add(DiagnosticsProperty('tokenValiditySeconds', tokenValiditySeconds))
      ..add(DiagnosticsProperty('resendWaitSeconds', resendWaitSeconds))
      ..add(DiagnosticsProperty('updateState', updateState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$EmailLoginBlocDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.error, error) ||
          other.error == error) &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.clientToken, clientToken) ||
          other.clientToken == clientToken) &&
        (identical(other.tokenValiditySeconds, tokenValiditySeconds) ||
          other.tokenValiditySeconds == tokenValiditySeconds) &&
        (identical(other.resendWaitSeconds, resendWaitSeconds) ||
          other.resendWaitSeconds == resendWaitSeconds) &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    error,
    email,
    clientToken,
    tokenValiditySeconds,
    resendWaitSeconds,
    updateState,
  );

  @override
  EmailLoginBlocData copyWith({
    Object? isLoading,
    Object? error = _detectDefaultValueInCopyWith,
    Object? email = _detectDefaultValueInCopyWith,
    Object? clientToken = _detectDefaultValueInCopyWith,
    Object? tokenValiditySeconds = _detectDefaultValueInCopyWith,
    Object? resendWaitSeconds = _detectDefaultValueInCopyWith,
    Object? updateState,
  }) => _$EmailLoginBlocDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    error: (error == _detectDefaultValueInCopyWith ? this.error : error) as EmailLoginError?,
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    clientToken: (clientToken == _detectDefaultValueInCopyWith ? this.clientToken : clientToken) as EmailLoginToken?,
    tokenValiditySeconds: (tokenValiditySeconds == _detectDefaultValueInCopyWith ? this.tokenValiditySeconds : tokenValiditySeconds) as int?,
    resendWaitSeconds: (resendWaitSeconds == _detectDefaultValueInCopyWith ? this.resendWaitSeconds : resendWaitSeconds) as int?,
    updateState: (updateState ?? this.updateState) as UpdateState,
  );
}
