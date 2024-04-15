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

  CurrentModerationRequestData copyWith({
    ModerationRequest? moderationRequest,
  }) => throw _privateConstructorErrorCurrentModerationRequestData;
}

/// @nodoc
abstract class _CurrentModerationRequestData implements CurrentModerationRequestData {
  factory _CurrentModerationRequestData({
    ModerationRequest? moderationRequest,
  }) = _$CurrentModerationRequestDataImpl;
}

/// @nodoc
class _$CurrentModerationRequestDataImpl implements _CurrentModerationRequestData {
  _$CurrentModerationRequestDataImpl({
    this.moderationRequest,
  });

  @override
  final ModerationRequest? moderationRequest;

  @override
  String toString() {
    return 'CurrentModerationRequestData(moderationRequest: $moderationRequest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$CurrentModerationRequestDataImpl &&
        (identical(other.moderationRequest, moderationRequest) ||
          other.moderationRequest == moderationRequest)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    moderationRequest,
  );

  @override
  CurrentModerationRequestData copyWith({
    Object? moderationRequest = _detectDefaultValueInCopyWith,
  }) => _$CurrentModerationRequestDataImpl(
    moderationRequest: (moderationRequest == _detectDefaultValueInCopyWith ? this.moderationRequest : moderationRequest) as ModerationRequest?,
  );
}
