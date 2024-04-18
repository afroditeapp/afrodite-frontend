// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_moderation_request.dart';

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
final _privateConstructorErrorCurrentModerationRequestData = UnsupportedError(
    'Private constructor CurrentModerationRequestData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$CurrentModerationRequestData {
  ModerationRequest? get moderationRequest => throw _privateConstructorErrorCurrentModerationRequestData;
  bool get isError => throw _privateConstructorErrorCurrentModerationRequestData;
  bool get isLoading => throw _privateConstructorErrorCurrentModerationRequestData;

  CurrentModerationRequestData copyWith({
    ModerationRequest? moderationRequest,
    bool? isError,
    bool? isLoading,
  }) => throw _privateConstructorErrorCurrentModerationRequestData;
}

/// @nodoc
abstract class _CurrentModerationRequestData implements CurrentModerationRequestData {
  factory _CurrentModerationRequestData({
    ModerationRequest? moderationRequest,
    bool isError,
    bool isLoading,
  }) = _$CurrentModerationRequestDataImpl;
}

/// @nodoc
class _$CurrentModerationRequestDataImpl implements _CurrentModerationRequestData {
  static const bool _isErrorDefaultValue = false;
  static const bool _isLoadingDefaultValue = false;
  
  _$CurrentModerationRequestDataImpl({
    this.moderationRequest,
    this.isError = _isErrorDefaultValue,
    this.isLoading = _isLoadingDefaultValue,
  });

  @override
  final ModerationRequest? moderationRequest;
  @override
  final bool isError;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'CurrentModerationRequestData(moderationRequest: $moderationRequest, isError: $isError, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$CurrentModerationRequestDataImpl &&
        (identical(other.moderationRequest, moderationRequest) ||
          other.moderationRequest == moderationRequest) &&
        (identical(other.isError, isError) ||
          other.isError == isError) &&
        (identical(other.isLoading, isLoading) ||
          other.isLoading == isLoading)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    moderationRequest,
    isError,
    isLoading,
  );

  @override
  CurrentModerationRequestData copyWith({
    Object? moderationRequest = _detectDefaultValueInCopyWith,
    Object? isError,
    Object? isLoading,
  }) => _$CurrentModerationRequestDataImpl(
    moderationRequest: (moderationRequest == _detectDefaultValueInCopyWith ? this.moderationRequest : moderationRequest) as ModerationRequest?,
    isError: (isError ?? this.isError) as bool,
    isLoading: (isLoading ?? this.isLoading) as bool,
  );
}
