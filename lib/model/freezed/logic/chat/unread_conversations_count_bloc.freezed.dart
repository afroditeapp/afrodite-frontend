// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_conversations_count_bloc.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorUnreadConversationsCountData = UnsupportedError(
    'Private constructor UnreadConversationsCountData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$UnreadConversationsCountData {
  int get unreadConversations => throw _privateConstructorErrorUnreadConversationsCountData;

  UnreadConversationsCountData copyWith({
    int? unreadConversations,
  }) => throw _privateConstructorErrorUnreadConversationsCountData;
}

/// @nodoc
abstract class _UnreadConversationsCountData extends UnreadConversationsCountData {
  factory _UnreadConversationsCountData({
    int unreadConversations,
  }) = _$UnreadConversationsCountDataImpl;
  const _UnreadConversationsCountData._() : super._();
}

/// @nodoc
class _$UnreadConversationsCountDataImpl extends _UnreadConversationsCountData with DiagnosticableTreeMixin {
  static const int _unreadConversationsDefaultValue = 0;

  _$UnreadConversationsCountDataImpl({
    this.unreadConversations = _unreadConversationsDefaultValue,
  }) : super._();

  @override
  final int unreadConversations;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UnreadConversationsCountData(unreadConversations: $unreadConversations)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UnreadConversationsCountData'))
      ..add(DiagnosticsProperty('unreadConversations', unreadConversations));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$UnreadConversationsCountDataImpl &&
        (identical(other.unreadConversations, unreadConversations) ||
          other.unreadConversations == unreadConversations)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    unreadConversations,
  );

  @override
  UnreadConversationsCountData copyWith({
    Object? unreadConversations,
  }) => _$UnreadConversationsCountDataImpl(
    unreadConversations: (unreadConversations ?? this.unreadConversations) as int,
  );
}
