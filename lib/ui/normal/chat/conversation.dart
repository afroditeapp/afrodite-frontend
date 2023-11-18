import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
    log.info("Opening conversation to ${widget.accountId.accountId}");
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
                    previous?.accountId != current?.accountId ||
                    previous?.isMatch != current?.isMatch ||
                    previous?.messageCount != current?.messageCount,
                  builder: (context, state) {
                    if (state == null || state.accountId != widget.accountId) {
                      return Container();
                    } else if (!state.isMatch) {
                      return const Center(
                        child: Text('Send a message to make a match!'),
                      );
                    } else {
                      log.info("Message count: ${state.messageCount}");
                      cache.setInitialMessagesIfNotSet(state.initialMessages.messages);
                      // It does not matter if this is called right after.
                      // Messages will not be fetched because size of message
                      // count is the same.
                      cache.setNewSize(
                        state.messageCount,
                        state.messageCountChangeInfo == ConversationChangeType.messageSent
                      );

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
                  log.info("Sending message to ${state.accountId.accountId}");
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
  const ChatViewWidget(
    this.accountId,
    this.cache,
    {Key? key}
  ) : super(key: key);

  @override
  ChatViewWidgetState createState() => ChatViewWidgetState();
}

class ChatViewWidgetState extends State<ChatViewWidget> {

  bool _isDisposed = false;
  final _chatScrollPhysics = ChatScrollPhysics(ChatScrollPhysicsSettings());
  final ScrollController _scrollController = ScrollController();

  MessageCache get cache => widget.cache;

  @override
  void initState() {
    super.initState();
    _chatScrollPhysics.settings.messageCache = cache;

    cache.registerCacheUpdateCallback((jumpToLatestMessage) {
      if (!_isDisposed) {
        setState(() {
          log.info("Show updated message list. jumpToLatestMessage: $jumpToLatestMessage");
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

    // _scrollController.addListener(() {
    //   log.info("test ${_scrollController.position}");
    //   log.info("min ${_scrollController.position.minScrollExtent}");
    // });
  }
  @override
  Widget build(BuildContext context) {
    return messageListView(widget.accountId);
  }


  Widget messageListView(AccountId match) {
    return messageSliverList(match);
  }

  MessageViewEntry messageEntryToViewData(MessageEntry entry) {
    return (entry.messageText, entry.localId, entry.sentMessageState != null);
  }

  MessageViewEntry emptyViewData() {
    return ("", -1, false);
  }

  Widget messageSliverList(AccountId match) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final List<Widget> content;
    final Key? centerKeyValue;
    if (_chatScrollPhysics.settings.useTwoSliverListMode) {
      content = twoSliverListMode(centerKey);
      centerKeyValue = centerKey;
    } else {
      content = singleSliverListMode(centerKey);
      centerKeyValue = centerKey;
    }
    return CustomScrollView(
        center: centerKeyValue,
        physics: _chatScrollPhysics,
        reverse: true,
        controller: _scrollController,
        slivers: content,
      );
  }

  List<Widget> singleSliverListMode(Key centerKey) {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return null;
          },
          childCount: 0,
        ),
      ),
      SliverMainAxisGroup(
          key: centerKey,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
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
                childCount: cache.getTopMessagesSize() + cache.getBottomMessagesSize(),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(),
            )
        ]
      ),
    ];
  }

  List<Widget> twoSliverListMode(Key centerKey) {
    return [
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
          childCount: cache.getBottomMessagesSize(),
        ),
      ),
      SliverMainAxisGroup(
          key: centerKey,
          slivers: [
            SliverList(
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
        ]
      ),
    ];
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
  bool useTwoSliverListMode = false;
  MessageCache? messageCache;
  double maxViewportHeightDetected = 0;
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

    // log.info("removedMessagePixels $removedMessagePixels");
    // log.info("old: ${oldPosition.minScrollExtent} new: ${newPosition.minScrollExtent}");
    // log.info("newPostion: ${newPosition}");

    if (settings.maxViewportHeightDetected < newPosition.viewportDimension) {
      settings.maxViewportHeightDetected = newPosition.viewportDimension;
      log.info("New max viewport height detected: ${settings.maxViewportHeightDetected}");
    }

    if (oldPosition.viewportDimension != newPosition.viewportDimension) {
      log.info("Viewport dimension changed");
    }

    if (
      newPosition.maxScrollExtent > 0 &&
      !settings.useTwoSliverListMode &&
      // This is like this on purpose. If virtual keyboard is opened and if
      // the change is not done when new message arives, then the list makes
      // visible jump.
      settings.maxViewportHeightDetected != newPosition.viewportDimension
    ) {
      settings.useTwoSliverListMode = true;
      if (settings.messageCache == null) {
        log.warning("Message cache is not connected");
      }
      Future<void>.delayed(Duration.zero).then((value) async {
        settings.messageCache?.moveBottomMessagesToTop();
      });

      log.info("Use two sliver list mode");
    }

    if (removedMessagePixels > 0 && settings.jumpToMin) {
      settings.jumpToMin = false;
      return getNewPosition - removedMessagePixels;
    } else {
      return getNewPosition;
    }
  }
}

class MessageCache {
  int? size;
  bool cacheUpdateNeeded = false;
  void Function(bool jumpToLatestMessage)? _onCacheUpdate;
  final AccountId _accountId;
  int? initialMsgLocalKey;
  List<MessageContainer> _topMessages = [];
  List<MessageContainer> _bottomMessages = [];

  MessageCache(this._accountId);

  void registerCacheUpdateCallback(void Function(bool) callback) {
    _onCacheUpdate = callback;
    if (cacheUpdateNeeded) {
      // Not sure if this is needed but this might be run when
      // sending the first message after match.
      _onCacheUpdate!(true);
      cacheUpdateNeeded = false;
    }
  }

  void setInitialMessagesIfNotSet(List<MessageEntry> initialMessages) {
    if (size == null) {
      log.info("Setting initial messages: ${initialMessages.length}");
      _topMessages = initialMessages.map((e) => MessageContainer()..entry = e).toList();
      size = initialMessages.length;
      initialMsgLocalKey = initialMessages.firstOrNull?.id;
    }
  }

  void setNewSize(int newSize, bool jumpToLatestMessage) {
    if (newSize != size) {
      log.info("New size: $newSize, jumpToLatestMessage: $jumpToLatestMessage");
      _updateCache(jumpToLatestMessage, size == null);
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
    _triggerUpdateCallback(jumpToLatestMessage || initialLoad);
  }

  void _triggerUpdateCallback(bool jumpToLatest) {
    final updateCallback = _onCacheUpdate;
    if (updateCallback != null) {
      updateCallback(jumpToLatest);
    } else {
      log.info("Callback not registered, so callback will run when registered.");
      // Refresh when callback is registered.
      cacheUpdateNeeded = true;
    }
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

  void moveBottomMessagesToTop() async {
    _topMessages = [..._bottomMessages, ..._topMessages];
    initialMsgLocalKey = _topMessages.firstOrNull?.entry?.id;
    _bottomMessages = [];
    _triggerUpdateCallback(false);
    log.info("Moved bottom messages to top");
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
    _onCacheUpdate!(false);
  }

  void debugRemoveFromTop() {
    if (_topMessages.isNotEmpty) {
      _topMessages.removeAt(0);
    }
    _onCacheUpdate!(false);
  }

  void debugAddToBottom(String text, bool isSent) {
    _bottomMessages.insert(0, MessageContainer()..entry = debugBuildEntry(text, isSent));
    _onCacheUpdate!(false);
  }

  void debugRemoveFromBottom() {
    if (_bottomMessages.isNotEmpty) {
      _bottomMessages.removeAt(0);
    }

    _onCacheUpdate!(false);
  }
}

class MessageContainer {
  MessageEntry? entry;
}
