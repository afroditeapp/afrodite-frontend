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

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.accountId);
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
                      return ChatViewWidget(state.accountId, cache);
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
}


class ChatViewDebuggerPage extends StatefulWidget {
  final AccountId accountId;
  const ChatViewDebuggerPage(this.accountId, {Key? key}) : super(key: key);

  @override
  ChatViewDebuggerPageState createState() => ChatViewDebuggerPageState();
}

class ChatViewDebuggerPageState extends State<ChatViewDebuggerPage> {
  late MessageCache cache;
  int msgCount = 0;

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug chat view'),
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
                child: ChatViewWidget(widget.accountId, cache),
              ),
            )
          ),
          newMessageArea(context),
        ],
      ),
    );
  }

  Widget newMessageArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              final count = msgCount++;
              cache.debugAddToTop(count.toString(), count % 4 == 0);
            },
            child: Text("Top add")
          ),
          ElevatedButton(
            onPressed: () {
              cache.debugRemoveFromTop();
            },
            child: Text("Top rem")
          ),
          ElevatedButton(
            onPressed: () {
              final count = msgCount++;
              cache.debugAddToBottom(count.toString(), count % 4 == 0);
            },
            child: Text("Bottom add")
          ),
          ElevatedButton(
            onPressed: () {
              cache.debugRemoveFromBottom();
            },
            child: Text("Bottom rem")
          ),
        ],
      ),
    );
  }
}


class ChatViewWidget extends StatefulWidget {
  final AccountId accountId;
  final MessageCache cache;
  const ChatViewWidget(this.accountId, this.cache, {Key? key}) : super(key: key);

  @override
  ChatViewWidgetState createState() => ChatViewWidgetState();
}

// class Relayout extends SingleChildLayoutDelegate {
//   void Function() messagesFillTheViewportCallback = () {};
//   Relayout();

//   void registerCallback(void Function() callback) {
//     messagesFillTheViewportCallback = callback;
//   }

//   @override
//   BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
//     return BoxConstraints(
//       minWidth: constraints.maxWidth,
//       maxWidth: constraints.maxWidth,
//       minHeight: constraints.maxHeight,
//       maxHeight: constraints.maxHeight,
//     );
//   }

//   @override
//   Offset getPositionForChild(Size size, Size childSize) {
//     if (size.height == childSize.height && size.width == childSize.width) {
//       // log.info("Messages fill the viewport");
//       log.info("size: $size childSize: $childSize");
//       messagesFillTheViewportCallback();
//     }
//     return Offset.zero;
//   }

//   @override
//   bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
//     return true;
//   }
// }

class ChatViewWidgetState extends State<ChatViewWidget> {

  bool _isDisposed = false;
  bool _enableSliverMode = false;
  final _chatScrollPhysics = ChatScrollPhysics(ChatScrollPhysicsSettings());
  final ScrollController _scrollController = ScrollController();

  // final chatLayoutDelegate = Relayout();

  MessageCache get cache => widget.cache;

  @override
  void initState() {
    super.initState();

    // chatLayoutDelegate.registerCallback(() {
    //   if (!_enableSliverMode) {
    //     // setState(() {
    //     //   _enableSliverMode = true;
    //     // });
    //   }
    // });

    cache.registerCacheUpdateCallback((jumpToLatestMessage) {
      if (!_isDisposed) {
        setState(() {
          if (
            jumpToLatestMessage ||
            (
              _scrollController.hasClients &&
              _scrollController.position.atEdge &&
              _scrollController.position.pixels == _scrollController.position.minScrollExtent
            )
          ) {
            _chatScrollPhysics.settings.jumpToMin = true;
            if (_scrollController.hasClients) {
              // log.info("test ${_scrollController.position}");
              _scrollController.position.jumpTo(_scrollController.position.minScrollExtent);
            }
          }
        });
      }
    });

    _scrollController.addListener(() {
      log.info("test ${_scrollController.position}");
      log.info("min ${_scrollController.position.minScrollExtent}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return messageListView(widget.accountId);
  }


  Widget messageListView(AccountId match) {
    if (_enableSliverMode) {
      return messageSliverList(match);
    } else {
      return ClipRect(child: normalScrollViewDetections());
    }
  }

  Widget normalScrollViewDetections() {
    return LayoutBuilder(
      builder: (c, constraints) => Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight - 1,
              maxWidth: constraints.maxWidth,
            ),
            child: normalScrollView(),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                log.info("constraints: $constraints");
                if (constraints.maxHeight <= 1) {
                    Future.delayed(Duration.zero, () {
                      if (!_isDisposed) {
                        setState(() {
                          log.info("sliver mode enabled");
                          _enableSliverMode = true;
                        });
                      }
                    });
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget normalScrollView() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      shrinkWrap: true,
      itemCount: cache.getTopMessagesSize() + cache.getBottomMessagesSize(),
      itemBuilder: (context, index) {
        final MessageEntry? entry;
        if (index >= cache.getBottomMessagesSize()) {
          entry = cache.topMessagesindexToEntry(index - cache.getBottomMessagesSize());
        } else {
          entry = cache.bottomMessagesindexToEntry(index);
        }
        if (entry != null) {
          return messageRowWidget(context, messageEntryToViewData(entry));
        } else {
          return null;
        }
      },
    );
  }

  MessageViewEntry messageEntryToViewData(MessageEntry entry) {
    return (entry.messageText, entry.localId, entry.sentMessageState != null);
  }

  MessageViewEntry emptyViewData() {
    return ("", -1, false);
  }

  Widget messageSliverList(AccountId match) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return CustomScrollView(
        center: centerKey,
        physics: _chatScrollPhysics,
        reverse: true,
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final reversedIndex = cache.getBottomMessagesSize() - index - 1;
                final entry = cache.bottomMessagesindexToEntry(reversedIndex);
                if (entry != null) {
                  return messageRowWidget(context, messageEntryToViewData(entry));
                } else {
                  return null;
                }
              },
              childCount: cache._bottomMessages.length,
            ),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final entry = cache.topMessagesindexToEntry(index);
                if (entry != null) {
                  return messageRowWidget(context, messageEntryToViewData(entry));
                } else {
                  return null;
                }
              },
              childCount: cache._topMessages.length,
            ),
          ),
        ],
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

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class ChatScrollPhysicsSettings {
  bool jumpToMin = false;
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

    final double removedMessagePixels = oldPosition.minScrollExtent - newPosition.minScrollExtent;

    log.info("removedMessagePixels $removedMessagePixels");
    log.info("old: ${oldPosition.minScrollExtent} new: ${newPosition.minScrollExtent}");

    if (removedMessagePixels > 0 && settings.jumpToMin) {
      settings.jumpToMin = false;
      return getNewPosition - removedMessagePixels;
    } else {
      return getNewPosition;
    }
  }
}

class MessageCache {
  int size = 0;
  void Function(bool jumpToLatestMessage) _onCacheUpdate = (_) {};
  final AccountId _accountId;
  int? initialMsgLocalKey;
  List<MessageContainer> _topMessages = [];
  List<MessageContainer> _bottomMessages = [];

  MessageCache(this._accountId);

  void registerCacheUpdateCallback(void Function(bool) callback) {
    _onCacheUpdate = callback;
  }

  void setNewSize(int newSize, bool jumpToLatestMessage) {
    if (newSize != size) {
      _updateCache(jumpToLatestMessage, size == 0);
      size = newSize;
    }
  }

  Future<void> _updateCache(bool jumpToLatestMessage, bool initialLoad) async {
    await ChatRepository.getInstance().messageIteratorReset(_accountId);
    bool useBottom = true;
    List<MessageContainer> newBottomMessages = [];
    List<MessageContainer> newTopMessages = [];
    while (true) {
      final messages = await ChatRepository.getInstance().messageIteratorNext();
      if (messages.isEmpty) {
        break;
      }

      // ignore: prefer_conditional_assignment
      if (initialMsgLocalKey == null) {
        initialMsgLocalKey = messages.first.id;
      }

      if (initialLoad) {
        for (final message in messages) {
          newTopMessages.add(MessageContainer()..entry = message);
        }
      } else {
        for (final message in messages) {
          if (message.id == initialMsgLocalKey) {
            useBottom = false;
          }
          if (useBottom) {
            newBottomMessages.add(MessageContainer()..entry = message);
          } else {
            newTopMessages.add(MessageContainer()..entry = message);
          }
        }
      }
    }
    _topMessages = newTopMessages;
    _bottomMessages = newBottomMessages;
    _onCacheUpdate(jumpToLatestMessage || initialLoad);
  }

  int getTopMessagesSize() {
    return _topMessages.length;
  }

  int getBottomMessagesSize() {
    return _bottomMessages.length;
  }

  /// If null, message entry does not exists
  MessageEntry? topMessagesindexToEntry(int index) {
    return _topMessages.elementAtOrNull(index)?.entry;
  }

  /// If null, message entry does not exists
  MessageEntry? bottomMessagesindexToEntry(int index) {
    return _bottomMessages.elementAtOrNull(index)?.entry;
  }

  // Debugging

  int counter = 0;
  MessageEntry debugBuildEntry(String text, bool isSent) {
    final SentMessageState? state;
    if (isSent) {
      state = SentMessageState.pending;
    } else {
      state = null;
    }
    return MessageEntry(
      AccountId(accountId: ""),
      AccountId(accountId: ""),
      text,
      sentMessageState: state,
      id: counter++,
    );
  }

  void debugAddToTop(String text, bool isSent) {
    _topMessages.insert(0, MessageContainer()..entry = debugBuildEntry(text, isSent));
    _onCacheUpdate(false);
  }

  void debugRemoveFromTop() {
    if (_topMessages.isNotEmpty) {
      _topMessages.removeAt(0);
    }
    _onCacheUpdate(false);
  }

  void debugAddToBottom(String text, bool isSent) {
    _bottomMessages.insert(0, MessageContainer()..entry = debugBuildEntry(text, isSent));
    _onCacheUpdate(false);
  }

  void debugRemoveFromBottom() {
    if (_bottomMessages.isNotEmpty) {
      _bottomMessages.removeAt(0);
    }

    _onCacheUpdate(false);
  }
}

class MessageContainer {
  MessageEntry? entry;
}
