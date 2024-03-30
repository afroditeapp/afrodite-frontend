// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_moderation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrentModerationRequestData {
  ModerationRequest? get processingState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentModerationRequestDataCopyWith<CurrentModerationRequestData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentModerationRequestDataCopyWith<$Res> {
  factory $CurrentModerationRequestDataCopyWith(
          CurrentModerationRequestData value,
          $Res Function(CurrentModerationRequestData) then) =
      _$CurrentModerationRequestDataCopyWithImpl<$Res,
          CurrentModerationRequestData>;
  @useResult
  $Res call({ModerationRequest? processingState});
}

/// @nodoc
class _$CurrentModerationRequestDataCopyWithImpl<$Res,
        $Val extends CurrentModerationRequestData>
    implements $CurrentModerationRequestDataCopyWith<$Res> {
  _$CurrentModerationRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processingState = freezed,
  }) {
    return _then(_value.copyWith(
      processingState: freezed == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as ModerationRequest?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrentModerationRequestDataImplCopyWith<$Res>
    implements $CurrentModerationRequestDataCopyWith<$Res> {
  factory _$$CurrentModerationRequestDataImplCopyWith(
          _$CurrentModerationRequestDataImpl value,
          $Res Function(_$CurrentModerationRequestDataImpl) then) =
      __$$CurrentModerationRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ModerationRequest? processingState});
}

/// @nodoc
class __$$CurrentModerationRequestDataImplCopyWithImpl<$Res>
    extends _$CurrentModerationRequestDataCopyWithImpl<$Res,
        _$CurrentModerationRequestDataImpl>
    implements _$$CurrentModerationRequestDataImplCopyWith<$Res> {
  __$$CurrentModerationRequestDataImplCopyWithImpl(
      _$CurrentModerationRequestDataImpl _value,
      $Res Function(_$CurrentModerationRequestDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processingState = freezed,
  }) {
    return _then(_$CurrentModerationRequestDataImpl(
      processingState: freezed == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as ModerationRequest?,
    ));
  }
}

/// @nodoc

class _$CurrentModerationRequestDataImpl
    implements _CurrentModerationRequestData {
  _$CurrentModerationRequestDataImpl({this.processingState});

  @override
  final ModerationRequest? processingState;

  @override
  String toString() {
    return 'CurrentModerationRequestData(processingState: $processingState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentModerationRequestDataImpl &&
            (identical(other.processingState, processingState) ||
                other.processingState == processingState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, processingState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentModerationRequestDataImplCopyWith<
          _$CurrentModerationRequestDataImpl>
      get copyWith => __$$CurrentModerationRequestDataImplCopyWithImpl<
          _$CurrentModerationRequestDataImpl>(this, _$identity);
}

abstract class _CurrentModerationRequestData
    implements CurrentModerationRequestData {
  factory _CurrentModerationRequestData(
          {final ModerationRequest? processingState}) =
      _$CurrentModerationRequestDataImpl;

  @override
  ModerationRequest? get processingState;
  @override
  @JsonKey(ignore: true)
  _$$CurrentModerationRequestDataImplCopyWith<
          _$CurrentModerationRequestDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
