import 'dart:async';

import 'package:app/data/account_repository.dart';
import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/data/chat/typing_indicator_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/ui/normal/chat/chat_list/message_adapter.dart';
import 'package:database/database.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat_core;
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:rxdart/rxdart.dart';

final _log = Logger("ChatListLogic");

sealed class _ChatEvent {}

class _MessageCountChanged extends _ChatEvent {}

class _TypingStateChanged extends _ChatEvent {
  final bool isTyping;
  _TypingStateChanged(this.isTyping);
}

class _LoadOldMessagesRequested extends _ChatEvent {
  final Completer<bool> endReachedCompleter;
  _LoadOldMessagesRequested(this.endReachedCompleter);
}

class ChatListLogic {
  final chat_core.InMemoryChatController chatController;
  final ChatRepository chatRepository;
  final AccountRepository accountRepository;
  final TypingIndicatorManager typingIndicatorManager;
  final MessageDatabaseIterator oldMessagesIterator;
  final AccountId currentUser;
  final AccountId messageReceiver;
  final AccountDatabaseManager db;

  static const String _typingIndicatorMessageId = 'typing_indicator_message';

  StreamSubscription<void>? _eventSubscription;
  final PublishSubject<_LoadOldMessagesRequested> _loadOldMessagesRelay = PublishSubject();

  ChatListLogic({
    required this.chatController,
    required this.chatRepository,
    required this.accountRepository,
    required this.typingIndicatorManager,
    required this.oldMessagesIterator,
    required this.currentUser,
    required this.messageReceiver,
    required this.db,
  }) {
    _setupEventSubscription();
  }

  void _setupEventSubscription() {
    final messageEvents = chatRepository
        .getMessageCountAndChanges(messageReceiver)
        .map((_) => _MessageCountChanged());

    final typingEvents = typingIndicatorManager
        .getTypingState(messageReceiver)
        .map((isTyping) => _TypingStateChanged(isTyping));

    final loadOldMessagesEvents = _loadOldMessagesRelay.stream;

    _eventSubscription = Rx.merge([
      messageEvents,
      typingEvents,
      loadOldMessagesEvents,
    ]).asyncMap((event) async => await _handleEvent(event)).listen((_) {});
  }

  Future<void> _handleEvent(_ChatEvent event) async {
    switch (event) {
      case _MessageCountChanged():
        await _loadNewMessages();
      case _TypingStateChanged(:final isTyping):
        await _updateTypingIndicatorMessage(isTyping);
      case _LoadOldMessagesRequested(:final endReachedCompleter):
        await _loadOldMessages(endReachedCompleter);
    }
  }

  Future<void> _loadNewMessages() async {
    _log.fine("Loading newer messages");

    final latestMessage = chatController.messages
        .where(
          (element) =>
              element.metadata?["generated"] != true && element.id != _typingIndicatorMessageId,
        )
        .lastOrNull;
    final LocalMessageId? latestMessageId;
    if (latestMessage != null) {
      latestMessageId = LocalMessageId(int.parse(latestMessage.id));
    } else {
      latestMessageId = null;
    }

    final newMessages = await _getNewMessages(
      latestMessageId,
      currentUser: currentUser,
      messageReceiver: messageReceiver,
      db: db,
    );

    if (newMessages.isNotEmpty) {
      final chatMessages = MessageAdapter.toFlutterChatMessages(newMessages, currentUser.aid);

      final lastMessage = chatController.messages.lastOrNull;
      final hasTypingIndicator = lastMessage?.id == _typingIndicatorMessageId;
      final insertIndex = hasTypingIndicator
          ? chatController.messages.length - 1
          : chatController.messages.length;

      await chatController.insertAllMessages(chatMessages, index: insertIndex, animated: true);

      if (lastMessage != null && hasTypingIndicator) {
        await chatController.removeMessage(lastMessage);
      }

      final messageEntries = newMessages
          .whereType<IteratorMessageEntry>()
          .map((e) => e.entry)
          .toList();
      await _markMessagesAsSeenIfNeeded(messageEntries);

      _log.fine("Loaded ${newMessages.length} newer messages");
    }
  }

  Future<void> _loadOldMessages(Completer<bool> endReachedCompleter) async {
    final oldMessages = await oldMessagesIterator.nextList();
    oldMessages.addAll(await oldMessagesIterator.nextList());
    oldMessages.addAll(await oldMessagesIterator.nextList());
    oldMessages.addAll(await oldMessagesIterator.nextList());
    oldMessages.addAll(await oldMessagesIterator.nextList());

    if (oldMessages.isEmpty) {
      endReachedCompleter.complete(true);
      return;
    }

    final chatMessages = MessageAdapter.toFlutterChatMessages(
      oldMessages.reversed.toList(),
      currentUser.aid,
    );

    await chatController.insertAllMessages(chatMessages, index: 0, animated: false);

    endReachedCompleter.complete(false);
  }

  Future<void> _updateTypingIndicatorMessage(bool isTyping) async {
    final lastMessage = chatController.messages.lastOrNull;
    final existingTypingIndicator = lastMessage?.id == _typingIndicatorMessageId;
    if (isTyping && !existingTypingIndicator) {
      final typingMessage = chat_core.CustomMessage(
        id: _typingIndicatorMessageId,
        authorId: messageReceiver.aid,
        createdAt: DateTime.now(),
        metadata: const {'type': 'typing_indicator'},
      );
      await chatController.insertMessage(typingMessage, index: chatController.messages.length);
    } else if (!isTyping && lastMessage != null && existingTypingIndicator) {
      await chatController.removeMessage(lastMessage);
    }
  }

  /// Request loading old messages. Returns a Future that completes with true if end was reached.
  Future<bool> requestLoadOldMessages() async {
    final completer = Completer<bool>();
    _loadOldMessagesRelay.add(_LoadOldMessagesRequested(completer));
    return completer.future;
  }

  Future<void> _markMessagesAsSeenIfNeeded(List<MessageEntry> entries) async {
    final messageSeenEnabled =
        accountRepository.clientFeaturesConfigValue.chat?.messageStateSeen ?? false;
    if (!messageSeenEnabled) {
      return;
    }

    final entriesToMark = entries
        .where((entry) => entry.messageState == MessageState.received)
        .toList();

    if (entriesToMark.isEmpty) {
      return;
    }

    for (final entry in entriesToMark) {
      await db.accountAction((db) => db.message.updateStateToReceivedAndSeenLocally(entry.localId));
    }

    await markMessageEntryListSeen(chatRepository.api, db, entriesToMark);
  }

  Future<void> dispose() async {
    await _eventSubscription?.cancel();
    await _loadOldMessagesRelay.close();
  }
}

/// Get all messages or new messages until latestCurrentMessageLocalId. The
/// latest message is the last message.
Future<List<IteratorMessage>> _getNewMessages(
  LocalMessageId? latestCurrentMessageLocalId, {
  required AccountDatabaseManager db,
  required AccountId currentUser,
  required AccountId messageReceiver,
}) async {
  final messageIterator = MessageDatabaseIterator(db);
  await messageIterator.switchConversation(currentUser, messageReceiver);

  final List<IteratorMessage> newMessages = [];
  bool readMessages = true;
  while (readMessages) {
    final messages = await messageIterator.nextList();
    if (messages.isEmpty) {
      break;
    }

    for (final iteratorMessage in messages) {
      if (iteratorMessage case IteratorMessageEntry(
        :final entry,
      ) when entry.localId == latestCurrentMessageLocalId) {
        readMessages = false;
        break;
      } else {
        newMessages.add(iteratorMessage);
      }
    }
  }

  if (newMessages.any((v) => v is IteratorMessageEntry)) {
    // MessageDatabaseIterator must only create new system message
    // IteratorMessages together with new MessageEntries.
    return newMessages.reversed.toList();
  } else {
    return [];
  }
}
