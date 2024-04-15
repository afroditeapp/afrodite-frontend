// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_processing.dart';

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
final _privateConstructorErrorImageProcessingData = UnsupportedError(
    'Private constructor ImageProcessingData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ImageProcessingData {
  ProcessingState? get processingState => throw _privateConstructorErrorImageProcessingData;
  ProcessedAccountImage? get processedImage => throw _privateConstructorErrorImageProcessingData;

  ImageProcessingData copyWith({
    ProcessingState? processingState,
    ProcessedAccountImage? processedImage,
  }) => throw _privateConstructorErrorImageProcessingData;
}

/// @nodoc
abstract class _ImageProcessingData implements ImageProcessingData {
  factory _ImageProcessingData({
    ProcessingState? processingState,
    ProcessedAccountImage? processedImage,
  }) = _$ImageProcessingDataImpl;
}

/// @nodoc
class _$ImageProcessingDataImpl implements _ImageProcessingData {
  _$ImageProcessingDataImpl({
    this.processingState,
    this.processedImage,
  });

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
          other.processedImage == processedImage)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    processingState,
    processedImage,
  );

  @override
  ImageProcessingData copyWith({
    Object? processingState = _detectDefaultValueInCopyWith,
    Object? processedImage = _detectDefaultValueInCopyWith,
  }) => _$ImageProcessingDataImpl(
    processingState: (processingState == _detectDefaultValueInCopyWith ? this.processingState : processingState) as ProcessingState?,
    processedImage: (processedImage == _detectDefaultValueInCopyWith ? this.processedImage : processedImage) as ProcessedAccountImage?,
  );
}
