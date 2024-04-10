// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_processing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageProcessingData {
  ProcessingState? get processingState => throw _privateConstructorUsedError;
  ProcessedAccountImage? get processedImage =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageProcessingDataCopyWith<ImageProcessingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageProcessingDataCopyWith<$Res> {
  factory $ImageProcessingDataCopyWith(
          ImageProcessingData value, $Res Function(ImageProcessingData) then) =
      _$ImageProcessingDataCopyWithImpl<$Res, ImageProcessingData>;
  @useResult
  $Res call(
      {ProcessingState? processingState,
      ProcessedAccountImage? processedImage});
}

/// @nodoc
class _$ImageProcessingDataCopyWithImpl<$Res, $Val extends ImageProcessingData>
    implements $ImageProcessingDataCopyWith<$Res> {
  _$ImageProcessingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processingState = freezed,
    Object? processedImage = freezed,
  }) {
    return _then(_value.copyWith(
      processingState: freezed == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as ProcessingState?,
      processedImage: freezed == processedImage
          ? _value.processedImage
          : processedImage // ignore: cast_nullable_to_non_nullable
              as ProcessedAccountImage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageProcessingDataImplCopyWith<$Res>
    implements $ImageProcessingDataCopyWith<$Res> {
  factory _$$ImageProcessingDataImplCopyWith(_$ImageProcessingDataImpl value,
          $Res Function(_$ImageProcessingDataImpl) then) =
      __$$ImageProcessingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessingState? processingState,
      ProcessedAccountImage? processedImage});
}

/// @nodoc
class __$$ImageProcessingDataImplCopyWithImpl<$Res>
    extends _$ImageProcessingDataCopyWithImpl<$Res, _$ImageProcessingDataImpl>
    implements _$$ImageProcessingDataImplCopyWith<$Res> {
  __$$ImageProcessingDataImplCopyWithImpl(_$ImageProcessingDataImpl _value,
      $Res Function(_$ImageProcessingDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processingState = freezed,
    Object? processedImage = freezed,
  }) {
    return _then(_$ImageProcessingDataImpl(
      processingState: freezed == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as ProcessingState?,
      processedImage: freezed == processedImage
          ? _value.processedImage
          : processedImage // ignore: cast_nullable_to_non_nullable
              as ProcessedAccountImage?,
    ));
  }
}

/// @nodoc

class _$ImageProcessingDataImpl implements _ImageProcessingData {
  _$ImageProcessingDataImpl({this.processingState, this.processedImage});

  @override
  final ProcessingState? processingState;
  @override
  final ProcessedAccountImage? processedImage;

  @override
  String toString() {
    return 'ImageProcessingData(processingState: $processingState, processedImage: $processedImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageProcessingDataImpl &&
            (identical(other.processingState, processingState) ||
                other.processingState == processingState) &&
            (identical(other.processedImage, processedImage) ||
                other.processedImage == processedImage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, processingState, processedImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageProcessingDataImplCopyWith<_$ImageProcessingDataImpl> get copyWith =>
      __$$ImageProcessingDataImplCopyWithImpl<_$ImageProcessingDataImpl>(
          this, _$identity);
}

abstract class _ImageProcessingData implements ImageProcessingData {
  factory _ImageProcessingData(
      {final ProcessingState? processingState,
      final ProcessedAccountImage? processedImage}) = _$ImageProcessingDataImpl;

  @override
  ProcessingState? get processingState;
  @override
  ProcessedAccountImage? get processedImage;
  @override
  @JsonKey(ignore: true)
  _$$ImageProcessingDataImplCopyWith<_$ImageProcessingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
