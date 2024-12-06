// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_content_moderation.dart';

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
final _privateConstructorErrorInitialContentModerationData = UnsupportedError(
    'Private constructor InitialContentModerationData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$InitialContentModerationData {
  bool? get accepted => throw _privateConstructorErrorInitialContentModerationData;
  bool get isError => throw _privateConstructorErrorInitialContentModerationData;
  bool get isLoading => throw _privateConstructorErrorInitialContentModerationData;

  InitialContentModerationData copyWith({
    bool? accepted,
    bool? isError,
    bool? isLoading,
  }) => throw _privateConstructorErrorInitialContentModerationData;
}

/// @nodoc
abstract class _InitialContentModerationData implements InitialContentModerationData {
  factory _InitialContentModerationData({
    bool? accepted,
    bool isError,
    bool isLoading,
  }) = _$InitialContentModerationDataImpl;
}

/// @nodoc
class _$InitialContentModerationDataImpl implements _InitialContentModerationData {
  static const bool _isErrorDefaultValue = false;
  static const bool _isLoadingDefaultValue = false;
  
  _$InitialContentModerationDataImpl({
    this.accepted,
    this.isError = _isErrorDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
  });

  @override
  final bool? accepted;
  @override
  final bool isError;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'InitialContentModerationData(accepted: $accepted, isError: $isError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$InitialContentModerationDataImpl &&
        (identical(other.accepted, accepted) ||
          other.accepted == accepted) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    accepted,
    isError,
    isLoading,
  );

  @override
  InitialContentModerationData copyWith({
    Object? accepted = _detectDefaultValueInCopyWith,
    Object? isError,
    Object? isLoading,
  }) => _$InitialContentModerationDataImpl(
    accepted: (accepted == _detectDefaultValueInCopyWith ? this.accepted : accepted) as bool?,
    isError: (isError ?? this.isError) as bool,
    isLoading: (isLoading ?? this.isLoading) as bool,
  );
}
