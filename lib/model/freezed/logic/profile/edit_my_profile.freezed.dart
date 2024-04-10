// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_my_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditMyProfileData {
  int? get age => throw _privateConstructorUsedError;
  String? get initial => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditMyProfileDataCopyWith<EditMyProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditMyProfileDataCopyWith<$Res> {
  factory $EditMyProfileDataCopyWith(
          EditMyProfileData value, $Res Function(EditMyProfileData) then) =
      _$EditMyProfileDataCopyWithImpl<$Res, EditMyProfileData>;
  @useResult
  $Res call({int? age, String? initial});
}

/// @nodoc
class _$EditMyProfileDataCopyWithImpl<$Res, $Val extends EditMyProfileData>
    implements $EditMyProfileDataCopyWith<$Res> {
  _$EditMyProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? initial = freezed,
  }) {
    return _then(_value.copyWith(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      initial: freezed == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditMyProfileDataImplCopyWith<$Res>
    implements $EditMyProfileDataCopyWith<$Res> {
  factory _$$EditMyProfileDataImplCopyWith(_$EditMyProfileDataImpl value,
          $Res Function(_$EditMyProfileDataImpl) then) =
      __$$EditMyProfileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? age, String? initial});
}

/// @nodoc
class __$$EditMyProfileDataImplCopyWithImpl<$Res>
    extends _$EditMyProfileDataCopyWithImpl<$Res, _$EditMyProfileDataImpl>
    implements _$$EditMyProfileDataImplCopyWith<$Res> {
  __$$EditMyProfileDataImplCopyWithImpl(_$EditMyProfileDataImpl _value,
      $Res Function(_$EditMyProfileDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? initial = freezed,
  }) {
    return _then(_$EditMyProfileDataImpl(
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      initial: freezed == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EditMyProfileDataImpl
    with DiagnosticableTreeMixin
    implements _EditMyProfileData {
  _$EditMyProfileDataImpl({this.age, this.initial});

  @override
  final int? age;
  @override
  final String? initial;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EditMyProfileData(age: $age, initial: $initial)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EditMyProfileData'))
      ..add(DiagnosticsProperty('age', age))
      ..add(DiagnosticsProperty('initial', initial));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditMyProfileDataImpl &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.initial, initial) || other.initial == initial));
  }

  @override
  int get hashCode => Object.hash(runtimeType, age, initial);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditMyProfileDataImplCopyWith<_$EditMyProfileDataImpl> get copyWith =>
      __$$EditMyProfileDataImplCopyWithImpl<_$EditMyProfileDataImpl>(
          this, _$identity);
}

abstract class _EditMyProfileData implements EditMyProfileData {
  factory _EditMyProfileData({final int? age, final String? initial}) =
      _$EditMyProfileDataImpl;

  @override
  int? get age;
  @override
  String? get initial;
  @override
  @JsonKey(ignore: true)
  _$$EditMyProfileDataImplCopyWith<_$EditMyProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
