
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("OneEndedMessageListWidget");

/// Infinite list where adding to one end is possible.
class OneEndedMessageListWidget extends StatefulWidget {
  final ConversationBloc conversationBloc;
  const OneEndedMessageListWidget(
    this.conversationBloc,
    {Key? key}
  ) : super(key: key);

  @override
  OneEndedMessageListWidgetState createState() => OneEndedMessageListWidgetState();
}

class OneEndedMessageListWidgetState extends State<OneEndedMessageListWidget> {
  final _chatScrollPhysics = SimpleChatScrollPhysics(SimpleChatScrollPhysicsSettings());
  final ScrollController _scrollController = ScrollController();

  List<MessageEntry> visibleMessages = [];
  ReadyVisibleMessageListUpdate? pendingUpdate;

  @override
  void initState() {
    visibleMessages = widget.conversationBloc.state.visibleMessages?.messages.messages ?? [];
    super.initState();
  }

  void updateVisibleMessages(ReadyVisibleMessageListUpdate update) {
    Future.delayed(Duration.zero, () {
      setState(() {
        visibleMessages = update.messages.messages;
        _chatScrollPhysics.settings.newMessageHeight = update.addedHeight;
        // Reset chat position to bottom
        if (
          // I sent message or
          update.jumpToLatestMessage ||
          // I received message and chat is at bottom.
          (
            _scrollController.hasClients &&
            _scrollController.position.atEdge &&
            _scrollController.position.pixels == _scrollController.position.minScrollExtent
          )
        ) {
          if (_scrollController.hasClients) {
            _chatScrollPhysics.settings.jumpToLatest = true;
            _scrollController.position.jumpTo(0);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return msgListUpdater();
  }

  Widget msgListUpdater() {
    return BlocBuilder<ConversationBloc, ConversationData>(
      buildWhen: (previous, current) => previous.visibleMessages != current.visibleMessages,
      builder: (context, state) {
        final update = state.visibleMessages;
        if (update != null && update != pendingUpdate) {
          pendingUpdate = update;
          updateVisibleMessages(update);
        }

        return msgListBuilder(visibleMessages);
      },
    );
  }

  Widget msgListBuilder(List<MessageEntry> visibleMessages) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _chatScrollPhysics.settings.availableArea = constraints.maxHeight;
        return messageList(visibleMessages);
      }
    );
  }

  Widget messageList(List<MessageEntry> visibleMessages) {
    return ListView.builder(
      physics: _chatScrollPhysics,
      reverse: true,
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: visibleMessages.length,
      itemBuilder: (BuildContext context, int index) {
        final invertedIndex = visibleMessages.length - 1 - index;
        final entry = visibleMessages[invertedIndex];
        final style = DefaultTextStyle.of(context);
        final sentMessageState = entry.messageState.toSentState();
        if (sentMessageState != null && sentMessageState != SentMessageState.sent) {
          return StreamBuilder<MessageEntry?>(
            stream: widget.conversationBloc.dataProvider.getMessageWithLocalId(entry.localId).whereNotNull(),
            builder: (context, snapshot) {
              return messageRowWidget(
                context,
                snapshot.data ?? entry,
                parentTextStyle: style.style
              );
            },
          );
        } else {
          return messageRowWidget(
            context,
            entry,
            parentTextStyle: style.style
          );
        }
      },
    );
  }
}

class SimpleChatScrollPhysicsSettings {
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
      settings.newMessageHeight = null;
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
