// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_moderation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageModerationData {
  int? get test => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageModerationDataCopyWith<ImageModerationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageModerationDataCopyWith<$Res> {
  factory $ImageModerationDataCopyWith(
          ImageModerationData value, $Res Function(ImageModerationData) then) =
      _$ImageModerationDataCopyWithImpl<$Res, ImageModerationData>;
  @useResult
  $Res call({int? test});
}

/// @nodoc
class _$ImageModerationDataCopyWithImpl<$Res, $Val extends ImageModerationData>
    implements $ImageModerationDataCopyWith<$Res> {
  _$ImageModerationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test = freezed,
  }) {
    return _then(_value.copyWith(
      test: freezed == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageModerationDataCopyWith<$Res>
    implements $ImageModerationDataCopyWith<$Res> {
  factory _$$_ImageModerationDataCopyWith(_$_ImageModerationData value,
          $Res Function(_$_ImageModerationData) then) =
      __$$_ImageModerationDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? test});
}

/// @nodoc
class __$$_ImageModerationDataCopyWithImpl<$Res>
    extends _$ImageModerationDataCopyWithImpl<$Res, _$_ImageModerationData>
    implements _$$_ImageModerationDataCopyWith<$Res> {
  __$$_ImageModerationDataCopyWithImpl(_$_ImageModerationData _value,
      $Res Function(_$_ImageModerationData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test = freezed,
  }) {
    return _then(_$_ImageModerationData(
      test: freezed == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ImageModerationData
    with DiagnosticableTreeMixin
    implements _ImageModerationData {
  _$_ImageModerationData({this.test});

  @override
  final int? test;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageModerationData(test: $test)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageModerationData'))
      ..add(DiagnosticsProperty('test', test));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageModerationData &&
            (identical(other.test, test) || other.test == test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, test);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageModerationDataCopyWith<_$_ImageModerationData> get copyWith =>
      __$$_ImageModerationDataCopyWithImpl<_$_ImageModerationData>(
          this, _$identity);
}

abstract class _ImageModerationData implements ImageModerationData {
  factory _ImageModerationData({final int? test}) = _$_ImageModerationData;

  @override
  int? get test;
  @override
  @JsonKey(ignore: true)
  _$$_ImageModerationDataCopyWith<_$_ImageModerationData> get copyWith =>
      throw _privateConstructorUsedError;
}
