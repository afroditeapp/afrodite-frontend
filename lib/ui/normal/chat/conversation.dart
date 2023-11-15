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
  MessageIndexCache cache = MessageIndexCache();

  bool _isDisposed = false;
  bool _viewingMessages = false;
  bool _jumpToLatest = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cache = MessageIndexCache();
    _isDisposed = false;

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          // Latest message reached
          if (cache.commitNeeded()) {
            log.info("Cache Update requested without jump to latest message");
            cacheUpdate(false);
          }
        }
      }
    });
  }

  Future<void> cacheUpdate(bool jumpToLatestMessage) async {
    log.info("Cache update. jumpToLatestMessage: $jumpToLatestMessage");
    await ChatRepository.getInstance().messageIteratorReset(widget.accountId);
    final messages1 = await ChatRepository.getInstance().messageIteratorNext();
    final messages2 = await ChatRepository.getInstance().messageIteratorNext();
    if (!_isDisposed) {
      setState(() {
        cache.commit();
        final messageIterator = messages1.followedBy(messages2).indexed;
        for (final (i, message) in messageIterator) {
          cache.insertEntry(i, message);
        }
        if (jumpToLatestMessage) {
          _scrollController.position.jumpTo(0);
        }
      });
    }
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
                      _viewingMessages = false;
                      return Container();
                    } else if (state.isMatch) {
                      _viewingMessages = true;
                      log.info("Message count: ${state.messageCount}");
                      cache.setNewSize(state.messageCount);
                      if (cache.getSize() == 0 || _jumpToLatest
                        // (cache.commitNeeded() &&
                        // _scrollController.hasClients &&
                        // _scrollController.position.pixels == 0)
                        ) {
                        log.info("Cache Update requested. commit needed ${cache.commitNeeded()}");
                        _jumpToLatest = false;
                        Future.delayed(Duration.zero, () async {
                          await cacheUpdate(true);
                        });
                      }
                      return messageListView(state.accountId);
                    } else {
                      _viewingMessages = false;
                      return const Center(
                        child: Text('Send a message to make a match!'),
                      );
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
      physics: const ChatScrollPhysics(),
      controller: _scrollController,
      reverse: true,
      shrinkWrap: true,
      itemCount: cache.getSize(),
      itemBuilder: (context, index) {
        final entry = cache.indexToEntry(index);
        if (entry == null) {
          return StreamBuilder(
            stream: ChatRepository.getInstance()
              .getMessageWithIndex(match, index)
              .map((event) {
                if (event != null) {
                  cache.insertEntry(index, event);
                  return event;
                } else {
                  return null;
                }
              }),
            builder: (context, snapshot) {
              final newEntry = snapshot.data;
              if (newEntry != null) {
                return messageRowWidget(context, messageEntryToViewData(newEntry));
              } else {
                return messageRowWidget(context, emptyViewData());
              }
            },
          );
        } else {
          return StreamBuilder<MessageEntry?>(
            stream: ChatRepository.getInstance()
              .getMessageWithLocalId(match, entry.localId)
              .map((event) {
                if (event != null) {
                  cache.insertEntry(index, event);
                  return event;
                } else {
                  return null;
                }
              }),
            builder: (context, snapshot) {
              final updatedEntry = snapshot.data;
              if (updatedEntry != null) {
                return messageRowWidget(context, messageEntryToViewData(updatedEntry));
              } else {
                return messageRowWidget(context, messageEntryToViewData(entry));
              }
            },
          );
        }
      }
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
                  if (_viewingMessages) {
                    _jumpToLatest = true;
                  }
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

class ChatScrollPhysics extends ScrollPhysics {
  const ChatScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ChatScrollPhysics(parent: buildParent(ancestor));
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

    print("oldPosition: $oldPosition, newPosition: $newPosition");
    print("getNewPosition: $getNewPosition, addedMessagePixels: $addedMessagePixels");

    if (getNewPosition == 0 && addedMessagePixels > 0 && isScrolling) {
      return getNewPosition + addedMessagePixels;
    } else {
      return getNewPosition;
    }
  }
}

/// Map from index to local message ID
class MessageIndexCache {
  int _size = 0;
  final Queue<MessageContainer> _newLocalIds = Queue();
  final Queue<MessageContainer> _currentLocalIds = Queue();

  MessageIndexCache();

  void setNewSize(int newSize) {
    final difference = newSize - _size;
    for (int i = 0; i < difference; i++) {
      _newLocalIds.addLast(MessageContainer());
    }
    _size = newSize;
  }

  bool commitNeeded() {
    return _newLocalIds.isNotEmpty;
  }

  void commit() {
    // Reset to avoid possible race conditions where the local ID
    // is loading when new message is added to database.
    if (_newLocalIds.isNotEmpty) {
      for (final container in _currentLocalIds) {
        container.entry = null;
      }
    }

    while (_newLocalIds.isNotEmpty) {
      _currentLocalIds.addFirst(_newLocalIds.removeFirst());
    }
  }

  int getSize() {
    return _currentLocalIds.length;
  }

  /// If null, message entry is not yet loaded
  MessageEntry? indexToEntry(int index) {
    return _currentLocalIds.elementAtOrNull(index)?.entry;
  }


  void insertEntry(int index, MessageEntry entry) {
    _currentLocalIds.elementAtOrNull(index)?.entry = entry;
  }
}

class MessageContainer {
  MessageEntry? entry;
}
