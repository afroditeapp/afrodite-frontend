// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_enabled.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorChatEnabledData = UnsupportedError(
    'Private constructor ChatEnabledData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ChatEnabledData {
  bool get chatEnabled => throw _privateConstructorErrorChatEnabledData;
  bool get isEnabling => throw _privateConstructorErrorChatEnabledData;
  bool get enableError => throw _privateConstructorErrorChatEnabledData;

  ChatEnabledData copyWith({
    bool? chatEnabled,
    bool? isEnabling,
    bool? enableError,
  }) => throw _privateConstructorErrorChatEnabledData;
}

/// @nodoc
abstract class _ChatEnabledData implements ChatEnabledData {
  const factory _ChatEnabledData({
    bool chatEnabled,
    bool isEnabling,
    bool enableError,
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
  });

  @override
  final bool chatEnabled;
  @override
  final bool isEnabling;
  @override
  final bool enableError;

  @override
  String toString() {
    return 'ChatEnabledData(chatEnabled: $chatEnabled, isEnabling: $isEnabling, enableError: $enableError)';
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
          other.enableError == enableError)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    chatEnabled,
    isEnabling,
    enableError,
  );

  @override
  ChatEnabledData copyWith({
    Object? chatEnabled,
    Object? isEnabling,
    Object? enableError,
  }) => _$ChatEnabledDataImpl(
    chatEnabled: (chatEnabled ?? this.chatEnabled) as bool,
    isEnabling: (isEnabling ?? this.isEnabling) as bool,
    enableError: (enableError ?? this.enableError) as bool,
  );
}
