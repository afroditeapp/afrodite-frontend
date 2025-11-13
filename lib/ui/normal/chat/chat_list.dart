import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/chat/message_adapter.dart';
import 'package:app/ui/normal/chat/message_row.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/time.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat_core;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';
import 'dart:async';

final _log = Logger("ChatList");

/// Two pages must be queried from MessageDatabaseIterator so
/// that _reversed boolean will work correctly.
class ChatList extends StatefulWidget {
  final AccountId currentUser;
  final AccountId messageReceiver;
  final ProfileEntry? profileEntry;
  final List<MessageEntry> initialMessages;
  final MessageDatabaseIterator oldMessagesIterator;
  final AccountDatabaseManager db;
  const ChatList(
    this.profileEntry,
    this.initialMessages,
    this.oldMessagesIterator, {
    required this.currentUser,
    required this.messageReceiver,
    required this.db,
    super.key,
  });

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late chat_core.InMemoryChatController _chatController;

  bool _reversed = false;
  bool _loadingOldMessages = false;
  bool _endReached = false;

  StreamSubscription<void>? _messageCountSubscription;
  bool _loadingNewMessages = false;

  @override
  void initState() {
    super.initState();
    _log.finest("Opening conversation for account: ${widget.messageReceiver}");

    final initialMessages = MessageAdapter.toFlutterChatMessages(
      widget.initialMessages,
      widget.currentUser.aid,
    );

    _chatController = chat_core.InMemoryChatController(messages: initialMessages);

    // Use reversed mode only when there is enough
    // messages as otherwise there would be empty space
    // on top. When reversed is false, loading old messages
    // is not smooth, so that is disabled as 19 messages
    // means that there is no more old messages
    // (two pages = 20 messages).
    _reversed = initialMessages.length >= 20;

    final r = context.read<RepositoryInstances>();
    _messageCountSubscription = r.chat
        .getMessageCountAndChanges(widget.messageReceiver)
        .asyncMap((_) async {
          await _loadNewMessages();
        })
        .listen((_) {});
  }

  Future<void> _loadNewMessages() async {
    if (!context.mounted || _loadingNewMessages) {
      return;
    }

    _loadingNewMessages = true;
    _log.fine("Loading newer messages");

    try {
      final latestMessage = _chatController.messages.lastOrNull;
      final LocalMessageId? latestMessageId;
      if (latestMessage != null) {
        latestMessageId = LocalMessageId(int.parse(latestMessage.id));
      } else {
        latestMessageId = null;
      }

      final newMessages = await _getNewMessages(
        latestMessageId,
        currentUser: widget.currentUser,
        messageReceiver: widget.messageReceiver,
        db: widget.db,
      );

      if (!context.mounted) {
        return;
      }

      if (newMessages.isNotEmpty) {
        final chatMessages = MessageAdapter.toFlutterChatMessages(
          newMessages,
          widget.currentUser.aid,
        );

        await _chatController.insertAllMessages(
          chatMessages,
          index: _chatController.messages.length,
          animated: true,
        );

        _log.fine("Loaded ${newMessages.length} newer messages");
      }
    } finally {
      _loadingNewMessages = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = chat_core.ChatTheme.fromThemeData(Theme.of(context));
    return chat_ui.Chat(
      theme: baseTheme,
      currentUserId: widget.currentUser.aid,
      chatController: _chatController,
      resolveUser: (_) => Future<chat_core.User?>.value(null),
      onMessageSend: (String text) {
        final textMessage = TextMessage.create(text);
        if (text.characters.length > 4000 || textMessage == null) {
          showSnackBar(context.strings.conversation_screen_message_too_long);
          return;
        }
        sendMessage(context, textMessage);
      },
      onMessageLongPress:
          (
            BuildContext ctx,
            chat_core.Message message, {
            int index = 0,
            LongPressStartDetails? details,
          }) async {
            if (message is chat_core.SystemMessage) {
              return;
            }

            final localMessageId = LocalMessageId(int.parse(message.id));
            final r = context.read<RepositoryInstances>();

            final entry = await r.chat.getMessageWithLocalId(localMessageId).first;

            if (entry != null && ctx.mounted) {
              openMessageMenu(ctx, entry);
            }
          },
      builders: chat_core.Builders(
        chatAnimatedListBuilder: (context, itemBuilder) {
          return chat_ui.ChatAnimatedList(
            reversed: _reversed,
            itemBuilder: itemBuilder,
            onEndReached: !_reversed || (_reversed && _endReached)
                ? null
                : () async {
                    if (_loadingOldMessages) return;
                    _loadingOldMessages = true;

                    await Future<void>.delayed(Duration(seconds: 1));

                    final oldMessages = await widget.oldMessagesIterator.nextList();
                    oldMessages.addAll(await widget.oldMessagesIterator.nextList());
                    oldMessages.addAll(await widget.oldMessagesIterator.nextList());
                    oldMessages.addAll(await widget.oldMessagesIterator.nextList());
                    oldMessages.addAll(await widget.oldMessagesIterator.nextList());
                    if (oldMessages.isEmpty) {
                      setState(() {
                        _endReached = true;
                      });
                      return;
                    }

                    final chatMessages = MessageAdapter.toFlutterChatMessages(
                      oldMessages.reversed.toList(),
                      widget.currentUser.aid,
                    );

                    if (!context.mounted) {
                      return;
                    }

                    await _chatController.insertAllMessages(
                      chatMessages,
                      index: 0,
                      animated: false,
                    );

                    _loadingOldMessages = false;
                  },
          );
        },
        systemMessageBuilder:
            (
              BuildContext ctx,
              chat_core.SystemMessage message,
              int index, {
              required bool isSentByMe,
              chat_core.MessageGroupStatus? groupStatus,
            }) {
              final IconData iconData;
              final String text;
              final infoType = message.metadata?['infoMessageType'] as String?;

              switch (infoType) {
                case 'infoMatchFirstPublicKeyReceived':
                  iconData = Icons.lock;
                  text = context.strings.conversation_screen_message_info_encryption_started;
                case 'infoMatchPublicKeyChanged':
                  iconData = Icons.key;
                  text = context.strings.conversation_screen_message_info_encryption_key_changed;
                default:
                  iconData = Icons.error;
                  text = context.strings.conversation_screen_message_unsupported;
              }

              final color = Theme.of(context).colorScheme.onSurface.withAlpha(128);
              final textStyle = TextStyle(color: color, fontSize: 13.0);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(iconData, color: color, size: 20),
                    ),
                    Flexible(
                      child: Text(text, style: textStyle, textAlign: TextAlign.center),
                    ),
                  ],
                ),
              );
            },
        customMessageBuilder:
            (
              BuildContext ctx,
              chat_core.CustomMessage message,
              int index, {
              required bool isSentByMe,
              chat_core.MessageGroupStatus? groupStatus,
            }) {
              final metadata = message.metadata;
              final messageType = metadata?['type'] as String?;

              if (messageType == 'video_call_invitation') {
                final timeTextStyle = TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12.0,
                );

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => joinVideoCall(ctx, widget.messageReceiver),
                        icon: const Icon(Icons.videocam),
                        label: Text(
                          context.strings.conversation_screen_join_video_call_button,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(_formatTimestamp(message.createdAt), style: timeTextStyle),
                    ],
                  ),
                );
              }

              if (messageType == 'error_message') {
                final errorType = metadata?['errorType'] as String?;
                final String errorText;

                switch (errorType) {
                  case 'decrypting_failed':
                    errorText = context.strings.conversation_screen_message_state_decrypting_failed;
                  case 'key_download_failed':
                    errorText = context
                        .strings
                        .conversation_screen_message_state_public_key_download_failed;
                  case 'unsupported':
                    errorText = context.strings.conversation_screen_message_unsupported;
                  default:
                    errorText = context.strings.generic_error;
                }

                final textStyle = TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                  fontSize: 16.0,
                );

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.onErrorContainer,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(child: Text(errorText, style: textStyle)),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        _formatTimestamp(message.createdAt),
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onErrorContainer.withValues(alpha: 0.7),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
        textMessageBuilder:
            (
              BuildContext ctx,
              chat_core.TextMessage message,
              int index, {
              required bool isSentByMe,
              chat_core.MessageGroupStatus? groupStatus,
            }) {
              final localMessageId = LocalMessageId(int.parse(message.id));
              final r = context.read<RepositoryInstances>();

              final messageWidget = chat_ui.SimpleTextMessage(
                message: message,
                index: index,
                timeAndStatusPosition: isSentByMe
                    ? chat_core.TimeAndStatusPosition.end
                    : chat_core.TimeAndStatusPosition.start,
              );

              final wrappedMessage = message.status == chat_core.MessageStatus.error
                  ? Provider<chat_core.ChatTheme>.value(
                      value: baseTheme.copyWith(
                        colors: baseTheme.colors.copyWith(
                          surfaceContainer: Theme.of(context).colorScheme.errorContainer,
                          onSurface: Theme.of(context).colorScheme.onErrorContainer,
                          primary: Theme.of(context).colorScheme.errorContainer,
                          onPrimary: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                      child: messageWidget,
                    )
                  : Provider<chat_core.ChatTheme>.value(
                      value: baseTheme.copyWith(
                        colors: baseTheme.colors.copyWith(
                          surfaceContainer: Theme.of(context).colorScheme.primaryContainer,
                          onSurface: Theme.of(context).colorScheme.onPrimaryContainer,
                          primary: Theme.of(context).colorScheme.primaryContainer,
                          onPrimary: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      child: messageWidget,
                    );

              return _MessageStateWatcher(
                localMessageId: localMessageId,
                messageId: message.id,
                chatController: _chatController,
                chatRepository: r.chat,
                currentUserId: r.chat.currentUser.aid,
                child: wrappedMessage,
              );
            },
      ),
    );
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    final utcDateTime = UtcDateTime.fromDateTime(timestamp);
    return timeOnlyString(utcDateTime);
  }

  @override
  void dispose() {
    _messageCountSubscription?.cancel();
    _chatController.dispose();
    super.dispose();
  }
}

sealed class _MessageStreamItem {}

class _MessageExists extends _MessageStreamItem {
  final MessageEntry entry;
  _MessageExists(this.entry);
}

class _MessageDeleted extends _MessageStreamItem {}

/// A widget that watches for message state changes and updates the chat controller.
/// This allows each message to manage its own subscription instead of the controller
/// managing all subscriptions centrally.
class _MessageStateWatcher extends StatefulWidget {
  final LocalMessageId localMessageId;
  final String messageId;
  final chat_core.InMemoryChatController chatController;
  final ChatRepository chatRepository;
  final String currentUserId;
  final Widget child;

  const _MessageStateWatcher({
    required this.localMessageId,
    required this.messageId,
    required this.chatController,
    required this.chatRepository,
    required this.currentUserId,
    required this.child,
  });

  @override
  State<_MessageStateWatcher> createState() => _MessageStateWatcherState();
}

class _MessageStateWatcherState extends State<_MessageStateWatcher> {
  late Stream<_MessageStreamItem> _messageStream;

  @override
  void initState() {
    super.initState();
    _messageStream = _createMessageStateStream();
  }

  Stream<_MessageStreamItem> _createMessageStateStream() async* {
    await for (final entry in widget.chatRepository.getMessageWithLocalId(widget.localMessageId)) {
      if (entry != null) {
        yield _MessageExists(entry);
      } else {
        yield _MessageDeleted();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<_MessageStreamItem>(
      stream: _messageStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null) {
          switch (data) {
            case _MessageExists(:final entry):
              final updatedMessage = MessageAdapter.toFlutterChatMessage(
                entry,
                widget.currentUserId,
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final index = widget.chatController.messages.indexWhere(
                  (m) => m.id == widget.messageId,
                );
                if (index != -1) {
                  final oldMessage = widget.chatController.messages[index];
                  widget.chatController.updateMessage(oldMessage, updatedMessage);
                }
              });
            case _MessageDeleted():
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final index = widget.chatController.messages.indexWhere(
                  (m) => m.id == widget.messageId,
                );
                if (index != -1) {
                  final messageToRemove = widget.chatController.messages[index];
                  widget.chatController.removeMessage(messageToRemove);
                }
              });
          }
        }

        return widget.child;
      },
    );
  }
}

/// Get all messages or new messages until latestCurrentMessageLocalId. The
/// latest message is the last message.
Future<List<MessageEntry>> _getNewMessages(
  LocalMessageId? latestCurrentMessageLocalId, {
  required AccountDatabaseManager db,
  required AccountId currentUser,
  required AccountId messageReceiver,
}) async {
  final messageIterator = MessageDatabaseIterator(db);
  await messageIterator.switchConversation(currentUser, messageReceiver);

  final List<MessageEntry> newMessages = [];
  bool readMessages = true;
  while (readMessages) {
    final messages = await messageIterator.nextList();
    if (messages.isEmpty) {
      break;
    }

    for (final message in messages) {
      if (message.localId == latestCurrentMessageLocalId) {
        readMessages = false;
        break;
      } else {
        newMessages.add(message);
      }
    }
  }

  return newMessages.reversed.toList();
}
