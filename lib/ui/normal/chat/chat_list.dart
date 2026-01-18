import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/data/chat/typing_indicator_manager.dart';
import 'package:app/data/chat_repository.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:app/ui/normal/chat/chat_list/animated_composer.dart';
import 'package:app/ui/normal/chat/chat_list/chat_message.dart';
import 'package:app/ui/normal/chat/chat_list/lazy_quotation.dart';
import 'package:app/ui/normal/chat/chat_list/logic.dart';
import 'package:app/ui/normal/chat/chat_list/reply_target_controller.dart';
import 'package:app/ui/normal/chat/chat_list/slideable.dart';
import 'package:app/ui/normal/chat/conversation_page.dart';
import 'package:app/ui/normal/chat/chat_list/message_adapter.dart';
import 'package:app/ui/normal/chat/utils.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat_core;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
import 'dart:async';

final _log = Logger("ChatList");

/// Two pages must be queried from MessageDatabaseIterator so
/// that _reversed boolean will work correctly.
class ChatList extends StatefulWidget {
  final AccountId currentUser;
  final AccountId messageReceiver;
  final ProfileEntry? profileEntry;
  final List<IteratorMessage> initialMessages;
  final MessageDatabaseIterator oldMessagesIterator;
  final QuotationCache quotationCache;
  final AccountDatabaseManager db;
  final TypingIndicatorManager typingIndicatorManager;
  final bool typingIndicatorEnabled;
  final bool messageStateDeliveredEnabled;
  final bool messageStateSeenEnabled;

  const ChatList(
    this.profileEntry,
    this.initialMessages,
    this.oldMessagesIterator,
    this.quotationCache, {
    required this.currentUser,
    required this.messageReceiver,
    required this.db,
    required this.typingIndicatorManager,
    required this.typingIndicatorEnabled,
    required this.messageStateDeliveredEnabled,
    required this.messageStateSeenEnabled,
    super.key,
  });

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  late chat_core.InMemoryChatController _chatController;
  late TextEditingController _textEditingController;
  late FocusNode _textFieldFocusNode;
  late ChatListLogic _chatListLogic;
  late ReplyTargetController _replyTargetController;

  bool _reversed = false;
  bool _endReached = false;
  bool _showMakeMatchInstruction = false;

  @override
  void initState() {
    super.initState();
    _replyTargetController = ReplyTargetController(profileEntry: widget.profileEntry);

    _log.finest("Opening conversation for account: ${widget.messageReceiver}");

    final initialMessages = MessageAdapter.toFlutterChatMessages(
      widget.initialMessages,
      widget.currentUser.aid,
      messageStateDeliveredEnabled: widget.messageStateDeliveredEnabled,
      messageStateSeenEnabled: widget.messageStateSeenEnabled,
    );

    _chatController = chat_core.InMemoryChatController(messages: initialMessages);
    _textEditingController = TextEditingController();
    _textFieldFocusNode = FocusNode();
    _textEditingController.addListener(_onTextChanged);

    // Use reversed mode only when there is enough
    // messages as otherwise there would be empty space
    // on top. When reversed is false, loading old messages
    // is not smooth, so that is disabled as 19 messages
    // means that there is no more old messages
    // (two pages = 20 messages).
    _reversed = initialMessages.length >= 20;

    final r = context.read<RepositoryInstances>();
    _chatListLogic = ChatListLogic(
      chatController: _chatController,
      chatRepository: r.chat,
      accountRepository: r.account,
      typingIndicatorManager: widget.typingIndicatorManager,
      oldMessagesIterator: widget.oldMessagesIterator,
      currentUser: widget.currentUser,
      messageReceiver: widget.messageReceiver,
      db: widget.db,
      typingIndicatorEnabled: widget.typingIndicatorEnabled,
      messageStateDeliveredEnabled: widget.messageStateDeliveredEnabled,
      messageStateSeenEnabled: widget.messageStateSeenEnabled,
    );
  }

  void _onTextChanged() {
    if (!widget.typingIndicatorEnabled) {
      return;
    }
    final text = _textEditingController.text;
    if (text.isNotEmpty) {
      widget.typingIndicatorManager.handleTypingEvent(widget.messageReceiver, true);
    } else {
      widget.typingIndicatorManager.handleTypingEvent(widget.messageReceiver, false);
    }
  }

  Future<void> _handleSwipeToReply(String messageId) async {
    final localMessageId = LocalMessageId(int.parse(messageId));
    final r = context.read<RepositoryInstances>();
    final entry = await r.chat.getMessageWithLocalId(localMessageId).first;
    if (entry != null) {
      _replyTargetController.setReplyTarget(entry);
    }
  }

  Widget _wrapWithSwipeToReply(Widget child, String messageId) {
    return Slideable(
      onSlideComplete: () => _handleSwipeToReply(messageId),
      icon: Icons.reply,
      iconColor: Theme.of(context).colorScheme.primary,
      iconPadding: EdgeInsets.only(left: 10),
      maxSlide: 50,
      threshold: 0.7,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = chat_core.ChatTheme.fromThemeData(Theme.of(context));
    return chat_ui.Chat(
      theme: baseTheme,
      currentUserId: widget.currentUser.aid,
      chatController: _chatController,
      resolveUser: (_) => Future<chat_core.User?>.value(null),
      onMessageSend: (String text) async {
        final Message message;
        final replyTarget = _replyTargetController.replyTarget;
        if (replyTarget != null) {
          final replyToMessageId = replyTarget.messageId?.id;
          if (replyToMessageId == null) {
            showSnackBar(context.strings.generic_error);
            return;
          }
          final messageWithReference = MessageWithReference.create(text, replyToMessageId);
          if (messageWithReference == null) {
            showSnackBar(context.strings.conversation_screen_message_too_long);
            return;
          }
          message = messageWithReference;
        } else {
          final textMessage = TextMessage.create(text);
          if (textMessage == null) {
            showSnackBar(context.strings.conversation_screen_message_too_long);
            return;
          }
          message = textMessage;
        }

        if (text.characters.length > 4000) {
          showSnackBar(context.strings.conversation_screen_message_too_long);
          return;
        }

        final saved = await sendMessage(context, message);
        if (saved) {
          _textEditingController.clear();
          _replyTargetController.clearReplyTarget();
        }
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            onEndReached: !_reversed || (_reversed && _endReached)
                ? null
                : () async {
                    final endReached = await _chatListLogic.requestLoadOldMessages();
                    if (endReached && mounted) {
                      setState(() {
                        _endReached = true;
                      });
                    }
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
              final messageType = message.metadata?['type'] as String?;

              // Handle date change messages
              if (messageType == 'date_change') {
                final dateTime = message.createdAt;
                if (dateTime == null) {
                  return const SizedBox.shrink();
                }

                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final yesterday = today.subtract(const Duration(days: 1));
                final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

                final String formattedDate;
                if (messageDate.isAtSameMomentAs(today)) {
                  formattedDate = context.strings.generic_today;
                } else if (messageDate.isAtSameMomentAs(yesterday)) {
                  formattedDate = context.strings.generic_yesterday;
                } else if (messageDate.year == now.year) {
                  final locale = Localizations.localeOf(ctx).toString();
                  final formatter = DateFormat.MMMd(locale);
                  formattedDate = formatter.format(dateTime);
                } else {
                  final locale = Localizations.localeOf(ctx).toString();
                  final formatter = DateFormat.yMMMd(locale);
                  formattedDate = formatter.format(dateTime);
                }

                final color = Theme.of(context).colorScheme.onSurface.withAlpha(128);
                final textStyle = TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                );

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Center(child: Text(formattedDate, style: textStyle)),
                );
              }

              // Handle info messages
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

              if (messageType == 'typing_indicator') {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: chat_ui.IsTypingIndicator(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                );
              }

              Widget messageWidget;

              if (messageType == 'video_call_invitation') {
                messageWidget = ChatMessage(
                  createdAt: message.createdAt,
                  status: message.status,
                  isSentByMe: isSentByMe,
                  isError: message.status == chat_core.MessageStatus.error,
                  child: ElevatedButton.icon(
                    onPressed: () => joinVideoCall(ctx, widget.messageReceiver),
                    icon: const Icon(Icons.videocam),
                    label: Text(context.strings.conversation_screen_join_video_call_button),
                  ),
                );
              } else {
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

                final textStyle = TextStyle(color: Theme.of(context).colorScheme.onErrorContainer);

                messageWidget = ChatMessage(
                  createdAt: message.createdAt,
                  status: message.status,
                  isSentByMe: isSentByMe,
                  isError: true,
                  showStatus: false,
                  child: Row(
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
                );
              }

              final localMessageId = LocalMessageId(int.parse(message.id));
              final r = context.read<RepositoryInstances>();

              final wrappedWidget = _wrapWithSwipeToReply(messageWidget, message.id);

              return _MessageStateWatcher(
                localMessageId: localMessageId,
                messageId: message.id,
                chatController: _chatController,
                chatRepository: r.chat,
                currentUserId: r.chat.currentUser.aid,
                messageStateDeliveredEnabled: widget.messageStateDeliveredEnabled,
                messageStateSeenEnabled: widget.messageStateSeenEnabled,
                child: wrappedWidget,
              );
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

              final isError = message.status == chat_core.MessageStatus.error;
              final textColor = isError
                  ? Theme.of(context).colorScheme.onErrorContainer
                  : Theme.of(context).colorScheme.onPrimaryContainer;

              final Widget messageContent;
              if (message.replyToMessageId != null) {
                messageContent = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LazyQuotation(
                      replyToMessageId: message.replyToMessageId!,
                      cache: widget.quotationCache,
                      messageReceiver: widget.messageReceiver,
                      profileEntry: widget.profileEntry,
                    ),
                    const SizedBox(height: 4.0),
                    Text(message.text, style: TextStyle(color: textColor)),
                  ],
                );
              } else {
                messageContent = Text(message.text, style: TextStyle(color: textColor));
              }

              final messageWidget = ChatMessage(
                createdAt: message.createdAt,
                status: message.status,
                isSentByMe: isSentByMe,
                isError: isError,
                child: messageContent,
              );

              final wrappedWidget = _wrapWithSwipeToReply(messageWidget, message.id);

              return _MessageStateWatcher(
                localMessageId: localMessageId,
                messageId: message.id,
                chatController: _chatController,
                chatRepository: r.chat,
                currentUserId: r.chat.currentUser.aid,
                messageStateDeliveredEnabled: widget.messageStateDeliveredEnabled,
                messageStateSeenEnabled: widget.messageStateSeenEnabled,
                child: wrappedWidget,
              );
            },
        emptyChatListBuilder: (BuildContext ctx) {
          return BlocBuilder<ConversationBloc, ConversationData>(
            buildWhen: (previous, current) => previous.isMatch != current.isMatch,
            builder: (context, state) {
              if (!state.isMatch) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _showMakeMatchInstruction = true;
                    });
                  }
                });
              }
              if (_showMakeMatchInstruction || !state.isMatch) {
                return Center(
                  child: Text(context.strings.conversation_screen_make_match_instruction),
                );
              }
              return buildListReplacementMessageSimple(
                context,
                context.strings.conversation_screen_message_list_empty,
              );
            },
          );
        },
        composerBuilder: (BuildContext ctx) {
          return AnimatedComposer(
            textEditingController: _textEditingController,
            focusNode: _textFieldFocusNode,
            replyTargetController: _replyTargetController,
            hintText: ctx.strings.conversation_screen_chat_box_placeholder_text,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Send typing stop event when leaving the chat
    if (widget.typingIndicatorEnabled) {
      widget.typingIndicatorManager.handleTypingEvent(widget.messageReceiver, false);
    }

    _chatListLogic.dispose();
    _textEditingController.removeListener(_onTextChanged);
    _chatController.dispose();
    _textEditingController.dispose();
    _textFieldFocusNode.dispose();
    _replyTargetController.dispose();
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
  final bool messageStateDeliveredEnabled;
  final bool messageStateSeenEnabled;
  final Widget child;

  const _MessageStateWatcher({
    required this.localMessageId,
    required this.messageId,
    required this.chatController,
    required this.chatRepository,
    required this.currentUserId,
    required this.messageStateDeliveredEnabled,
    required this.messageStateSeenEnabled,
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
              final updatedMessage = MessageAdapter.messageEntryToFlutterChatMessage(
                entry,
                widget.currentUserId,
                messageStateDeliveredEnabled: widget.messageStateDeliveredEnabled,
                messageStateSeenEnabled: widget.messageStateSeenEnabled,
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
