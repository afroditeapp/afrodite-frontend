import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';

var log = Logger("ConversationPage");

class ConversationPage extends StatefulWidget {
  final AccountId accountId;
  const ConversationPage(this.accountId, {Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

typedef MessageViewEntry = (String message, int? localId, bool isSent);

class ConversationPageState extends State<ConversationPage> {
  late MessageCache cache;

  bool _isDisposed = false;
  final _chatScrollPhysics = ChatScrollPhysics(ChatScrollPhysicsSettings());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.accountId);
    _isDisposed = false;

    cache.registerCacheUpdateCallback((jumpToLatestMessage) {
       if (!_isDisposed) {
        setState(() {
          if (
            jumpToLatestMessage ||
            (
              _scrollController.hasClients &&
              _scrollController.position.atEdge &&
              _scrollController.position.pixels == 0
            )
          ) {
            _chatScrollPhysics.settings.disableKeepScrollPositionOnce = true;
            if (_scrollController.hasClients) {
              _scrollController.position.jumpTo(0);
            }
          }
        });
      }
    });
  }

  MessageViewEntry messageEntryToViewData(MessageEntry entry) {
    return (entry.messageText, entry.localId, entry.sentMessageState != null);
  }

  MessageViewEntry emptyViewData() {
    return ("", -1, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Conversation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<ConversationBloc, ConversationData?>(
                  buildWhen: (previous, current) =>
                    previous?.isMatch != current?.isMatch ||
                      previous?.messageCount != current?.messageCount,
                  builder: (context, state) {
                    if (state == null) {
                      return Container();
                    } else if (!state.isMatch) {
                      return const Center(
                        child: Text('Send a message to make a match!'),
                      );
                    } else {
                      log.info("Message count: ${state.messageCount}");
                      cache.setNewSize(state.messageCount, state.messageCountChangeInfo == ConversationChangeType.messageSent);
                      return messageListView(state.accountId);
                    }
                  },
                ),
              ),
            )
          ),
          newMessageArea(context),
        ],
      ),
    );
  }

  Widget messageListView(AccountId match) {
    return ListView.builder(
      physics: _chatScrollPhysics,
      controller: _scrollController,
      reverse: true,
      shrinkWrap: true,
      itemCount: cache.getSize(),
      itemBuilder: (context, index) {
        final entry = cache.indexToEntry(index);
        if (entry != null) {
          return messageRowWidget(context, messageEntryToViewData(entry));
        } else {
          return null;
        }
      },
    );
  }

  Widget messageRowWidget(BuildContext context, MessageViewEntry entry) {
    final (message, _, isSent) = entry;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                child: messageWidget(context, message, isSent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageWidget(BuildContext context, String message, bool isSent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: isSent ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSent ? Colors.white : Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget newMessageArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final message = _textEditingController.text;
              if (message.trim().isNotEmpty) {
                final bloc = context.read<ConversationBloc>();
                final state = bloc.state;
                if (state != null) {
                  bloc.add(SendMessageTo(state.accountId, message));
                  _textEditingController.clear();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class ChatScrollPhysicsSettings {
  bool disableKeepScrollPositionOnce = false;
}

class ChatScrollPhysics extends ScrollPhysics {
  final ChatScrollPhysicsSettings settings;
  const ChatScrollPhysics(this.settings, {ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ChatScrollPhysics(settings, parent: buildParent(ancestor));
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity
  }) {

    final getNewPosition = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity
    );

    final double addedMessagePixels = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

    // TODO: The message list still jumps if the user is scrolling when message
    // is received.
    if (getNewPosition > 0 && addedMessagePixels > 0 && !settings.disableKeepScrollPositionOnce && !isScrolling) {
      return getNewPosition + addedMessagePixels;
    } else {
      settings.disableKeepScrollPositionOnce = false;
      return getNewPosition;
    }
  }
}

class MessageCache {
  int size = 0;
  void Function(bool jumpToLatestMessage) _onCacheUpdate = (_) {};
  final AccountId _accountId;
  Queue<MessageContainer> _visibleMessages = Queue();
  Queue<MessageContainer> _tmpMessages = Queue();

  MessageCache(this._accountId);

  void registerCacheUpdateCallback(void Function(bool) callback) {
    _onCacheUpdate = callback;
  }

  void setNewSize(int newSize, bool jumpToLatestMessage) {
    if (newSize != size) {
      size = newSize;
      // TODO: Prevent multiple updates or only commit the latest update
      _updateCache(jumpToLatestMessage);
    }
  }

  Future<void> _updateCache(bool jumpToLatestMessage) async {
    _tmpMessages.clear();

    await ChatRepository.getInstance().messageIteratorReset(_accountId);
    while (true) {
      final messages = await ChatRepository.getInstance().messageIteratorNext();
      if (messages.isEmpty) {
        break;
      }
      for (final message in messages) {
        _tmpMessages.add(MessageContainer()..entry = message);
      }
    }

    final isFirstUpdate = _visibleMessages.isEmpty;

    final currentMessages = _visibleMessages;
    _visibleMessages = _tmpMessages;
    _tmpMessages = currentMessages;

    _onCacheUpdate(jumpToLatestMessage || isFirstUpdate);
  }

  int getSize() {
    return _visibleMessages.length;
  }

  /// If null, message entry does not exists
  MessageEntry? indexToEntry(int index) {
    return _visibleMessages.elementAtOrNull(index)?.entry;
  }
}

class MessageContainer {
  MessageEntry? entry;
}
