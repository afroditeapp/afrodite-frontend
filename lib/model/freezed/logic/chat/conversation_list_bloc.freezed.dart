// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_list_bloc.dart';

// **************************************************************************
// Generated with Icegen
// **************************************************************************

/// @nodoc
final _privateConstructorErrorConversationListData = UnsupportedError(
    'Private constructor ConversationListData._() was called. Please call factory constructor instead.');

/// @nodoc
mixin _$ConversationListData {
  UnmodifiableList<AccountId> get conversations => throw _privateConstructorErrorConversationListData;
  UnmodifiableList<AccountId> get previousConversations => throw _privateConstructorErrorConversationListData;
  UnmodifiableList<ListItemChange> get changesBetweenCurrentAndPrevious => throw _privateConstructorErrorConversationListData;
  bool get initialLoadDone => throw _privateConstructorErrorConversationListData;

  ConversationListData copyWith({
    UnmodifiableList<AccountId>? conversations,
    UnmodifiableList<AccountId>? previousConversations,
    UnmodifiableList<ListItemChange>? changesBetweenCurrentAndPrevious,
    bool? initialLoadDone,
  }) => throw _privateConstructorErrorConversationListData;
}

/// @nodoc
abstract class _ConversationListData implements ConversationListData {
  factory _ConversationListData({
    UnmodifiableList<AccountId> conversations,
    UnmodifiableList<AccountId> previousConversations,
    UnmodifiableList<ListItemChange> changesBetweenCurrentAndPrevious,
    bool initialLoadDone,
  }) = _$ConversationListDataImpl;
}

/// @nodoc
class _$ConversationListDataImpl with DiagnosticableTreeMixin implements _ConversationListData {
  static const UnmodifiableList<AccountId> _conversationsDefaultValue = UnmodifiableList<AccountId>.empty();
  static const UnmodifiableList<AccountId> _previousConversationsDefaultValue = UnmodifiableList<AccountId>.empty();
  static const UnmodifiableList<ListItemChange> _changesBetweenCurrentAndPreviousDefaultValue = UnmodifiableList<ListItemChange>.empty();
  static const bool _initialLoadDoneDefaultValue = false;
  
  _$ConversationListDataImpl({
    this.conversations = _conversationsDefaultValue,
    this.previousConversations = _previousConversationsDefaultValue,
    this.changesBetweenCurrentAndPrevious = _changesBetweenCurrentAndPreviousDefaultValue,
    this.initialLoadDone = _initialLoadDoneDefaultValue,
  });

  @override
  final UnmodifiableList<AccountId> conversations;
  @override
  final UnmodifiableList<AccountId> previousConversations;
  @override
  final UnmodifiableList<ListItemChange> changesBetweenCurrentAndPrevious;
  @override
  final bool initialLoadDone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationListData(conversations: $conversations, previousConversations: $previousConversations, changesBetweenCurrentAndPrevious: $changesBetweenCurrentAndPrevious, initialLoadDone: $initialLoadDone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationListData'))
      ..add(DiagnosticsProperty('conversations', conversations))
      ..add(DiagnosticsProperty('previousConversations', previousConversations))
      ..add(DiagnosticsProperty('changesBetweenCurrentAndPrevious', changesBetweenCurrentAndPrevious))
      ..add(DiagnosticsProperty('initialLoadDone', initialLoadDone));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      (other.runtimeType == runtimeType &&
        other is _$ConversationListDataImpl &&
        (identical(other.conversations, conversations) ||
          other.conversations == conversations) &&
        (identical(other.previousConversations, previousConversations) ||
          other.previousConversations == previousConversations) &&
        (identical(other.changesBetweenCurrentAndPrevious, changesBetweenCurrentAndPrevious) ||
          other.changesBetweenCurrentAndPrevious == changesBetweenCurrentAndPrevious) &&
        (identical(other.initialLoadDone, initialLoadDone) ||
          other.initialLoadDone == initialLoadDone)
    );
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    conversations,
    previousConversations,
    changesBetweenCurrentAndPrevious,
    initialLoadDone,
  );

  @override
  ConversationListData copyWith({
    Object? conversations,
    Object? previousConversations,
    Object? changesBetweenCurrentAndPrevious,
    Object? initialLoadDone,
  }) => _$ConversationListDataImpl(
    conversations: (conversations ?? this.conversations) as UnmodifiableList<AccountId>,
    previousConversations: (previousConversations ?? this.previousConversations) as UnmodifiableList<AccountId>,
    changesBetweenCurrentAndPrevious: (changesBetweenCurrentAndPrevious ?? this.changesBetweenCurrentAndPrevious) as UnmodifiableList<ListItemChange>,
    initialLoadDone: (initialLoadDone ?? this.initialLoadDone) as bool,
  );
}
