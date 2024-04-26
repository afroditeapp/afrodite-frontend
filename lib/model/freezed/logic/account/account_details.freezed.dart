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
  String? get birthdate => throw _privateConstructorErrorAccountDetailsBlocData;

  AccountDetailsBlocData copyWith({
    bool? isLoading,
    bool? isError,
    String? email,
    String? birthdate,
  }) => throw _privateConstructorErrorAccountDetailsBlocData;
}

/// @nodoc
abstract class _AccountDetailsBlocData implements AccountDetailsBlocData {
  factory _AccountDetailsBlocData({
    bool isLoading,
    bool isError,
    String? email,
    String? birthdate,
  }) = _$AccountDetailsBlocDataImpl;
}

/// @nodoc
class _$AccountDetailsBlocDataImpl with DiagnosticableTreeMixin implements _AccountDetailsBlocData {
  static const bool _isLoadingDefaultValue = false;
  static const bool _isErrorDefaultValue = false;
  
  _$AccountDetailsBlocDataImpl({
    this.isLoading = _isLoadingDefaultValue,
    this.isError = _isErrorDefaultValue,
    this.email,
    this.birthdate,
  });

  @override
  final bool isLoading;
  @override
  final bool isError;
  @override
  final String? email;
  @override
  final String? birthdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountDetailsBlocData(isLoading: $isLoading, isError: $isError, email: $email, birthdate: $birthdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountDetailsBlocData'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isError', isError))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('birthdate', birthdate));
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
        (identical(other.birthdate, birthdate) ||
          other.birthdate == birthdate)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isError,
    email,
    birthdate,
  );

  @override
  AccountDetailsBlocData copyWith({
    Object? isLoading,
    Object? isError,
    Object? email = _detectDefaultValueInCopyWith,
    Object? birthdate = _detectDefaultValueInCopyWith,
  }) => _$AccountDetailsBlocDataImpl(
    isLoading: (isLoading ?? this.isLoading) as bool,
    isError: (isError ?? this.isError) as bool,
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    birthdate: (birthdate == _detectDefaultValueInCopyWith ? this.birthdate : birthdate) as String?,
  );
}
