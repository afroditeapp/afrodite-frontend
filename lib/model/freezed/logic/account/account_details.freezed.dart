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
  String? get email => throw _privateConstructorErrorAccountDetailsBlocData;
  String? get birthdate => throw _privateConstructorErrorAccountDetailsBlocData;

  AccountDetailsBlocData copyWith({
    String? email,
    String? birthdate,
  }) => throw _privateConstructorErrorAccountDetailsBlocData;
}

/// @nodoc
abstract class _AccountDetailsBlocData implements AccountDetailsBlocData {
  factory _AccountDetailsBlocData({
    String? email,
    String? birthdate,
  }) = _$AccountDetailsBlocDataImpl;
}

/// @nodoc
class _$AccountDetailsBlocDataImpl with DiagnosticableTreeMixin implements _AccountDetailsBlocData {
  _$AccountDetailsBlocDataImpl({
    this.email,
    this.birthdate,
  });

  @override
  final String? email;
  @override
  final String? birthdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountDetailsBlocData(email: $email, birthdate: $birthdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountDetailsBlocData'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('birthdate', birthdate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$AccountDetailsBlocDataImpl &&
        (identical(other.email, email) ||
          other.email == email) &&
        (identical(other.birthdate, birthdate) ||
          other.birthdate == birthdate)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    email,
    birthdate,
  );

  @override
  AccountDetailsBlocData copyWith({
    Object? email = _detectDefaultValueInCopyWith,
    Object? birthdate = _detectDefaultValueInCopyWith,
  }) => _$AccountDetailsBlocDataImpl(
    email: (email == _detectDefaultValueInCopyWith ? this.email : email) as String?,
    birthdate: (birthdate == _detectDefaultValueInCopyWith ? this.birthdate : birthdate) as String?,
  );
}
