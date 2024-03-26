// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attributes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AttributesData {
  AvailableProfileAttributes? get attributes =>
      throw _privateConstructorUsedError;
  AttributeRefreshState? get refreshState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AttributesDataCopyWith<AttributesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributesDataCopyWith<$Res> {
  factory $AttributesDataCopyWith(
          AttributesData value, $Res Function(AttributesData) then) =
      _$AttributesDataCopyWithImpl<$Res, AttributesData>;
  @useResult
  $Res call(
      {AvailableProfileAttributes? attributes,
      AttributeRefreshState? refreshState});
}

/// @nodoc
class _$AttributesDataCopyWithImpl<$Res, $Val extends AttributesData>
    implements $AttributesDataCopyWith<$Res> {
  _$AttributesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributes = freezed,
    Object? refreshState = freezed,
  }) {
    return _then(_value.copyWith(
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as AvailableProfileAttributes?,
      refreshState: freezed == refreshState
          ? _value.refreshState
          : refreshState // ignore: cast_nullable_to_non_nullable
              as AttributeRefreshState?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttributesDataImplCopyWith<$Res>
    implements $AttributesDataCopyWith<$Res> {
  factory _$$AttributesDataImplCopyWith(_$AttributesDataImpl value,
          $Res Function(_$AttributesDataImpl) then) =
      __$$AttributesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AvailableProfileAttributes? attributes,
      AttributeRefreshState? refreshState});
}

/// @nodoc
class __$$AttributesDataImplCopyWithImpl<$Res>
    extends _$AttributesDataCopyWithImpl<$Res, _$AttributesDataImpl>
    implements _$$AttributesDataImplCopyWith<$Res> {
  __$$AttributesDataImplCopyWithImpl(
      _$AttributesDataImpl _value, $Res Function(_$AttributesDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributes = freezed,
    Object? refreshState = freezed,
  }) {
    return _then(_$AttributesDataImpl(
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as AvailableProfileAttributes?,
      refreshState: freezed == refreshState
          ? _value.refreshState
          : refreshState // ignore: cast_nullable_to_non_nullable
              as AttributeRefreshState?,
    ));
  }
}

/// @nodoc

class _$AttributesDataImpl implements _AttributesData {
  _$AttributesDataImpl({this.attributes, this.refreshState});

  @override
  final AvailableProfileAttributes? attributes;
  @override
  final AttributeRefreshState? refreshState;

  @override
  String toString() {
    return 'AttributesData(attributes: $attributes, refreshState: $refreshState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttributesDataImpl &&
            (identical(other.attributes, attributes) ||
                other.attributes == attributes) &&
            (identical(other.refreshState, refreshState) ||
                other.refreshState == refreshState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attributes, refreshState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttributesDataImplCopyWith<_$AttributesDataImpl> get copyWith =>
      __$$AttributesDataImplCopyWithImpl<_$AttributesDataImpl>(
          this, _$identity);
}

abstract class _AttributesData implements AttributesData {
  factory _AttributesData(
      {final AvailableProfileAttributes? attributes,
      final AttributeRefreshState? refreshState}) = _$AttributesDataImpl;

  @override
  AvailableProfileAttributes? get attributes;
  @override
  AttributeRefreshState? get refreshState;
  @override
  @JsonKey(ignore: true)
  _$$AttributesDataImplCopyWith<_$AttributesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
