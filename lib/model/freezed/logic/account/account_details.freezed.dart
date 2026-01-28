// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details.dart';

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
final _privateConstructorErrorAccountDetailsBlocData = UnsupportedError(
    'Private constructor AccountDetailsBlocData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$AccountDetailsBlocData {
  bool get isLoading => throw _privateConstructorErrorAccountDetailsBlocData;
  bool get isError => throw _privateConstructorErrorAccountDetailsBlocData;
  String? get email => throw _privateConstructorErrorAccountDetailsBlocData;
  String? get emailChange => throw _privateConstructorErrorAccountDetailsBlocData;
  bool? get emailChangeVerified => throw _privateConstructorErrorAccountDetailsBlocData;
  UtcDateTime? get emailChangeCompletionTime => throw _privateConstructorErrorAccountDetailsBlocData;
  UpdateState get updateState => throw _privateConstructorErrorAccountDetailsBlocData;

  AccountDetailsBlocData copyWith({
    bool? isLoading,
    bool? isError,
    String? email,
    String? emailChange,
    bool? emailChangeVerified,
    UtcDateTime? emailChangeCompletionTime,
    UpdateState? updateState,
  }) => throw _privateConstructorErrorAccountDetailsBlocData;
}

/// @nodoc
abstract class _AccountDetailsBlocData implements AccountDetailsBlocData {
  factory _AccountDetailsBlocData({
    bool isLoading,
    bool isError,
    String? email,
    String? emailChange,
    bool? emailChangeVerified,
    UtcDateTime? emailChangeCompletionTime,
    UpdateState updateState,
  }) = _$AccountDetailsBlocDataImpl;
}

/// @nodoc
class _$AccountDetailsBlocDataImpl with DiagnosticableTreeMixin implements _AccountDetailsBlocData {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  static const UpdateState _updateStateDefaultValue = UpdateIdle();

  _$AccountDetailsBlocDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.email,
    this.emailChange,
    this.emailChangeVerified,
    this.emailChangeCompletionTime,
    this.updateState = _updateStateDefaultValue,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final String? email;
  @override
  final String? emailChange;
  @override
  final bool? emailChangeVerified;
  @override
  final UtcDateTime? emailChangeCompletionTime;
  @override
  final UpdateState updateState;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountDetailsBlocData(isLoading: $isLoading, isError: $isError, email: $email, emailChange: $emailChange, emailChangeVerified: $emailChangeVerified, emailChangeCompletionTime: $emailChangeCompletionTime, updateState: $updateState)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountDetailsBlocData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('emailChange', emailChange))
      ..add(DiagnosticsProperty('emailChangeVerified', emailChangeVerified))
      ..add(DiagnosticsProperty('emailChangeCompletionTime', emailChangeCompletionTime))
      ..add(DiagnosticsProperty('updateState', updateState));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountDetailsBlocDataImpl &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.emailChange, emailChange) ||
          other.emailChange == emailChange) &&
        (identical(other.emailChangeVerified, emailChangeVerified) ||
          other.emailChangeVerified == emailChangeVerified) &&
        (identical(other.emailChangeCompletionTime, emailChangeCompletionTime) ||
          other.emailChangeCompletionTime == emailChangeCompletionTime) &&
        (identical(other.updateState, updateState) ||
          other.updateState == updateState)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    email,
    emailChange,
    emailChangeVerified,
    emailChangeCompletionTime,
    updateState,
  );

  @override
  AccountDetailsBlocData copyWith({
    Object? isLoading,
    Object? isError,
    Object? email = _detectDefaultValueInCopyWith,
    Object? emailChange = _detectDefaultValueInCopyWith,
    Object? emailChangeVerified = _detectDefaultValueInCopyWith,
    Object? emailChangeCompletionTime = _detectDefaultValueInCopyWith,
    Object? updateState,
  }) => _$AccountDetailsBlocDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    emailChange: (emailChange == _detectDefaultValueInCopyWith ? this.emailChange : emailChange) as String?,
    emailChangeVerified: (emailChangeVerified == _detectDefaultValueInCopyWith ? this.emailChangeVerified : emailChangeVerified) as bool?,
    emailChangeCompletionTime: (emailChangeCompletionTime == _detectDefaultValueInCopyWith ? this.emailChangeCompletionTime : emailChangeCompletionTime) as UtcDateTime?,
    updateState: (updateState ?? this.updateState) as UpdateState,
  );
}
