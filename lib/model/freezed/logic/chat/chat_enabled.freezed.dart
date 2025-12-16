// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_enabled.dart';

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
final _privateConstructorErrorChatEnabledData = UnsupportedError(
    'Private constructor ChatEnabledData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ChatEnabledData {
  bool get chatEnabled => throw _privateConstructorErrorChatEnabledData;
  bool get isEnabling => throw _privateConstructorErrorChatEnabledData;
  bool get enableError => throw _privateConstructorErrorChatEnabledData;
  int? get remainingKeyGenerations => throw _privateConstructorErrorChatEnabledData;

  ChatEnabledData copyWith({
    bool? chatEnabled,
    bool? isEnabling,
    bool? enableError,
    int? remainingKeyGenerations,
  }) => throw _privateConstructorErrorChatEnabledData;
}

/// @nodoc
abstract class _ChatEnabledData implements ChatEnabledData {
  const factory _ChatEnabledData({
    bool chatEnabled,
    bool isEnabling,
    bool enableError,
    int? remainingKeyGenerations,
  }) = _$ChatEnabledDataImpl;
}

/// @nodoc
class _$ChatEnabledDataImpl implements _ChatEnabledData {
  static const bool _chatEnabledDefaultValue = true;
  static const bool _isEnablingDefaultValue = false;
  static const bool _enableErrorDefaultValue = false;
  
  const _$ChatEnabledDataImpl({
    this.chatEnabled = _chatEnabledDefaultValue,
    this.isEnabling = _isEnablingDefaultValue,
    this.enableError = _enableErrorDefaultValue,
    this.remainingKeyGenerations,
  });

  @override
  final bool chatEnabled;
  @override
  final bool isEnabling;
  @override
  final bool enableError;
  @override
  final int? remainingKeyGenerations;

  @override
  String toString() {
    return 'ChatEnabledData(chatEnabled: $chatEnabled, isEnabling: $isEnabling, enableError: $enableError, remainingKeyGenerations: $remainingKeyGenerations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ChatEnabledDataImpl &&
        (identical(other.chatEnabled, chatEnabled) ||
          other.chatEnabled == chatEnabled) &&
        (identical(other.isEnabling, isEnabling) ||
          other.isEnabling == isEnabling) &&
        (identical(other.enableError, enableError) ||
          other.enableError == enableError) &&
        (identical(other.remainingKeyGenerations, remainingKeyGenerations) ||
          other.remainingKeyGenerations == remainingKeyGenerations)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    chatEnabled,
    isEnabling,
    enableError,
    remainingKeyGenerations,
  );

  @override
  ChatEnabledData copyWith({
    Object? chatEnabled,
    Object? isEnabling,
    Object? enableError,
    Object? remainingKeyGenerations = _detectDefaultValueInCopyWith,
  }) => _$ChatEnabledDataImpl(
    chatEnabled: (chatEnabled ?? this.chatEnabled) as bool,
    isEnabling: (isEnabling ?? this.isEnabling) as bool,
    enableError: (enableError ?? this.enableError) as bool,
    remainingKeyGenerations: (remainingKeyGenerations == _detectDefaultValueInCopyWith ? this.remainingKeyGenerations : remainingKeyGenerations) as int?,
  );
}
