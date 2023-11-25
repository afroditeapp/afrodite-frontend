
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';

var log = Logger("OneEndedMessageListWidget");

/// Infinite list where adding to one end is possible.
class OneEndedMessageListWidget extends StatefulWidget {
  final AccountId accountId;
  final MessageCache cache;
  const OneEndedMessageListWidget(
    this.accountId,
    this.cache,
    {Key? key}
  ) : super(key: key);

  @override
  OneEndedMessageListWidgetState createState() => OneEndedMessageListWidgetState();
}

class OneEndedMessageListWidgetState extends State<OneEndedMessageListWidget> {
  bool _isDisposed = false;
  final _chatScrollPhysics = SimpleChatScrollPhysics(SimpleChatScrollPhysicsSettings());
  final ScrollController _scrollController = ScrollController();

  MessageCache get cache => widget.cache;

  @override
  void initState() {
    super.initState();
    _chatScrollPhysics.settings.messageCache = cache;

    cache.registerCacheUpdateCallback((jumpToLatestMessage, addedMessageSize) {
      if (!_isDisposed) {
        setState(() {
          _chatScrollPhysics.settings.newMessageHeight = addedMessageSize;

          // Reset chat position to bottom
          if (
            // I sent message or
            jumpToLatestMessage ||
            // I received message and chat is at bottom.
            (
              _scrollController.hasClients &&
              _scrollController.position.atEdge &&
              _scrollController.position.pixels == _scrollController.position.minScrollExtent
            )
          ) {
            if (_scrollController.hasClients) {
              _scrollController.position.jumpTo(0);
              _chatScrollPhysics.settings.jumpToLatest = true;
            }
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _chatScrollPhysics.settings.availableArea = constraints.maxHeight;
        return messageList(widget.accountId);
      }
    );
  }

  Widget messageList(AccountId match) {
    return ListView.builder(
      physics: _chatScrollPhysics,
      reverse: true,
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: cache.getTopMessagesSize() + cache.getBottomMessagesSize(),
      itemBuilder: (BuildContext context, int index) {
        final entry = cache.getMessageUsingLatestMessageIndexing(index);
        if (entry != null) {
          final style = DefaultTextStyle.of(context);
          return  messageRowWidget(
            context,
            messageEntryToViewData(entry),
            parentTextStyle: style.style
          );
        } else {
          return null;
        }
      },
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}

class SimpleChatScrollPhysicsSettings {
  MessageCache? messageCache;

  bool jumpToLatest = false;
  double? newMessageHeight;
  double? availableArea;
}

class SimpleChatScrollPhysics extends ScrollPhysics {
  final SimpleChatScrollPhysicsSettings settings;
  const SimpleChatScrollPhysics(this.settings, {ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SimpleChatScrollPhysics(settings, parent: buildParent(ancestor));
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

    if (settings.jumpToLatest) {
      log.info("Jump to latest message");
      settings.jumpToLatest = false;
      return getNewPosition;
    }

    final addedMessageHeight = settings.newMessageHeight;
    final availableArea = settings.availableArea;
    if (addedMessageHeight != null && availableArea != null) {
      settings.newMessageHeight = null;
      if (oldPosition.viewportDimension < availableArea &&
        newPosition.viewportDimension >= availableArea) {
        log.info("Partial scroll");
        final diff = newPosition.viewportDimension - oldPosition.viewportDimension;
        return getNewPosition + addedMessageHeight - diff;
      } else if (newPosition.viewportDimension >= availableArea) {
        log.info("Full area");
        return getNewPosition + addedMessageHeight;
      } else {
        log.info("Small area");
        return getNewPosition;
      }
    } else {
      return getNewPosition;
    }
  }
}
