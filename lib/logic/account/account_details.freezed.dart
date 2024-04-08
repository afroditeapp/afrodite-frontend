// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountDetailsBlocData {
  String? get email => throw _privateConstructorUsedError;
  String? get birthdate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountDetailsBlocDataCopyWith<AccountDetailsBlocData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDetailsBlocDataCopyWith<$Res> {
  factory $AccountDetailsBlocDataCopyWith(AccountDetailsBlocData value,
          $Res Function(AccountDetailsBlocData) then) =
      _$AccountDetailsBlocDataCopyWithImpl<$Res, AccountDetailsBlocData>;
  @useResult
  $Res call({String? email, String? birthdate});
}

/// @nodoc
class _$AccountDetailsBlocDataCopyWithImpl<$Res,
        $Val extends AccountDetailsBlocData>
    implements $AccountDetailsBlocDataCopyWith<$Res> {
  _$AccountDetailsBlocDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountDetailsBlocDataImplCopyWith<$Res>
    implements $AccountDetailsBlocDataCopyWith<$Res> {
  factory _$$AccountDetailsBlocDataImplCopyWith(
          _$AccountDetailsBlocDataImpl value,
          $Res Function(_$AccountDetailsBlocDataImpl) then) =
      __$$AccountDetailsBlocDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? birthdate});
}

/// @nodoc
class __$$AccountDetailsBlocDataImplCopyWithImpl<$Res>
    extends _$AccountDetailsBlocDataCopyWithImpl<$Res,
        _$AccountDetailsBlocDataImpl>
    implements _$$AccountDetailsBlocDataImplCopyWith<$Res> {
  __$$AccountDetailsBlocDataImplCopyWithImpl(
      _$AccountDetailsBlocDataImpl _value,
      $Res Function(_$AccountDetailsBlocDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_$AccountDetailsBlocDataImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AccountDetailsBlocDataImpl
    with DiagnosticableTreeMixin
    implements _AccountDetailsBlocData {
  _$AccountDetailsBlocDataImpl({this.email, this.birthdate});

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
            (identical(other.email, email) || other.email == email) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, birthdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDetailsBlocDataImplCopyWith<_$AccountDetailsBlocDataImpl>
      get copyWith => __$$AccountDetailsBlocDataImplCopyWithImpl<
          _$AccountDetailsBlocDataImpl>(this, _$identity);
}

abstract class _AccountDetailsBlocData implements AccountDetailsBlocData {
  factory _AccountDetailsBlocData(
      {final String? email,
      final String? birthdate}) = _$AccountDetailsBlocDataImpl;

  @override
  String? get email;
  @override
  String? get birthdate;
  @override
  @JsonKey(ignore: true)
  _$$AccountDetailsBlocDataImplCopyWith<_$AccountDetailsBlocDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
