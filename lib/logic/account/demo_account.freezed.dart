// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DemoAccountBlocData {
  String? get userId => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DemoAccountBlocDataCopyWith<DemoAccountBlocData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoAccountBlocDataCopyWith<$Res> {
  factory $DemoAccountBlocDataCopyWith(
          DemoAccountBlocData value, $Res Function(DemoAccountBlocData) then) =
      _$DemoAccountBlocDataCopyWithImpl<$Res, DemoAccountBlocData>;
  @useResult
  $Res call({String? userId, String? password});
}

/// @nodoc
class _$DemoAccountBlocDataCopyWithImpl<$Res, $Val extends DemoAccountBlocData>
    implements $DemoAccountBlocDataCopyWith<$Res> {
  _$DemoAccountBlocDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DemoAccountBlocDataImplCopyWith<$Res>
    implements $DemoAccountBlocDataCopyWith<$Res> {
  factory _$$DemoAccountBlocDataImplCopyWith(_$DemoAccountBlocDataImpl value,
          $Res Function(_$DemoAccountBlocDataImpl) then) =
      __$$DemoAccountBlocDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? userId, String? password});
}

/// @nodoc
class __$$DemoAccountBlocDataImplCopyWithImpl<$Res>
    extends _$DemoAccountBlocDataCopyWithImpl<$Res, _$DemoAccountBlocDataImpl>
    implements _$$DemoAccountBlocDataImplCopyWith<$Res> {
  __$$DemoAccountBlocDataImplCopyWithImpl(_$DemoAccountBlocDataImpl _value,
      $Res Function(_$DemoAccountBlocDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? password = freezed,
  }) {
    return _then(_$DemoAccountBlocDataImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DemoAccountBlocDataImpl
    with DiagnosticableTreeMixin
    implements _DemoAccountBlocData {
  _$DemoAccountBlocDataImpl({this.userId, this.password});

  @override
  final String? userId;
  @override
  final String? password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DemoAccountBlocData(userId: $userId, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DemoAccountBlocData'))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoAccountBlocDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DemoAccountBlocDataImplCopyWith<_$DemoAccountBlocDataImpl> get copyWith =>
      __$$DemoAccountBlocDataImplCopyWithImpl<_$DemoAccountBlocDataImpl>(
          this, _$identity);
}

abstract class _DemoAccountBlocData implements DemoAccountBlocData {
  factory _DemoAccountBlocData({final String? userId, final String? password}) =
      _$DemoAccountBlocDataImpl;

  @override
  String? get userId;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$DemoAccountBlocDataImplCopyWith<_$DemoAccountBlocDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
