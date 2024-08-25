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
  UnmodifiableList<IdAndEntry> get conversations => throw _privateConstructorErrorConversationListData;
  UnmodifiableList<ListItemChangeWithEntry> get changesBetweenCurrentAndPrevious => throw _privateConstructorErrorConversationListData;
  bool get initialLoadDone => throw _privateConstructorErrorConversationListData;

  ConversationListData copyWith({
    UnmodifiableList<IdAndEntry>? conversations,
    UnmodifiableList<ListItemChangeWithEntry>? changesBetweenCurrentAndPrevious,
    bool? initialLoadDone,
  }) => throw _privateConstructorErrorConversationListData;
}

/// @nodoc
abstract class _ConversationListData implements ConversationListData {
  factory _ConversationListData({
    UnmodifiableList<IdAndEntry> conversations,
    UnmodifiableList<ListItemChangeWithEntry> changesBetweenCurrentAndPrevious,
    bool initialLoadDone,
  }) = _$ConversationListDataImpl;
}

/// @nodoc
class _$ConversationListDataImpl with DiagnosticableTreeMixin implements _ConversationListData {
  static const UnmodifiableList<IdAndEntry> _conversationsDefaultValue = UnmodifiableList<IdAndEntry>.empty();
  static const UnmodifiableList<ListItemChangeWithEntry> _changesBetweenCurrentAndPreviousDefaultValue = UnmodifiableList<ListItemChangeWithEntry>.empty();
  static const bool _initialLoadDoneDefaultValue = false;
  
  _$ConversationListDataImpl({
    this.conversations = _conversationsDefaultValue,
    this.changesBetweenCurrentAndPrevious = _changesBetweenCurrentAndPreviousDefaultValue,
    this.initialLoadDone = _initialLoadDoneDefaultValue,
  });

  @override
  final UnmodifiableList<IdAndEntry> conversations;
  @override
  final UnmodifiableList<ListItemChangeWithEntry> changesBetweenCurrentAndPrevious;
  @override
  final bool initialLoadDone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConversationListData(conversations: $conversations, changesBetweenCurrentAndPrevious: $changesBetweenCurrentAndPrevious, initialLoadDone: $initialLoadDone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConversationListData'))
      ..add(DiagnosticsProperty('conversations', conversations))
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
    changesBetweenCurrentAndPrevious,
    initialLoadDone,
  );

  @override
  ConversationListData copyWith({
    Object? conversations,
    Object? changesBetweenCurrentAndPrevious,
    Object? initialLoadDone,
  }) => _$ConversationListDataImpl(
    conversations: (conversations ?? this.conversations) as UnmodifiableList<IdAndEntry>,
    changesBetweenCurrentAndPrevious: (changesBetweenCurrentAndPrevious ?? this.changesBetweenCurrentAndPrevious) as UnmodifiableList<ListItemChangeWithEntry>,
    initialLoadDone: (initialLoadDone ?? this.initialLoadDone) as bool,
  );
}
