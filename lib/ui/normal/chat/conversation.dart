import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/utils.dart';

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
  final int initialMsgCount;
  const ChatViewDebuggerPage(this.accountId, {this.initialMsgCount = 0, Key? key}) : super(key: key);

  @override
  ChatViewDebuggerPageState createState() => ChatViewDebuggerPageState();
}

class ChatViewDebuggerPageState extends State<ChatViewDebuggerPage> {
  late MessageCache cache;
  int msgCount = 0;
  bool msgAutoSend = false;
  final TextEditingController _textEditingController = TextEditingController();
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.accountId);
    if (widget.initialMsgCount > 0) {
      cache.debugSetInitialMessagesIfNotSet(widget.initialMsgCount);
    }

    _subscription = Stream<void>.periodic(const Duration(seconds: 1)).listen((event) {
      if (msgAutoSend) {
        sendToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug chat view'),
        actions: [
          IconButton(
            icon: const Icon(Icons.timelapse),
            onPressed: () {
              msgAutoSend = !msgAutoSend;
            },
          ),
        ],
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
          textEditArea(context),
          newMessageArea(context),
        ],
      ),
    );
  }

   Widget textEditArea(BuildContext context) {
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
              // empty
            },
          ),
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
              sendToTop();
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
              sendToBottom();
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

  void sendToTop() {
    final count = msgCount++;
    String msg = _textEditingController.text.trim();
    if (msg.isEmpty) {
      msg = count.toString();
    }
    cache.debugAddToTop(msg, count % 4 == 0);
  }

  void sendToBottom() {
    final count = msgCount++;
    String msg = _textEditingController.text.trim();
    if (msg.isEmpty) {
      msg = count.toString();
    }
    cache.debugAddToBottom(msg, count % 4 == 0);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
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

class CustomScrollController extends ScrollController {
  double? customInitialOffset;

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics, ScrollContext context, ScrollPosition? oldPosition) {
    if (customInitialOffset == null) {
      log.warning("customInitialOffset is null");
    }
    return ScrollPositionWithSingleContext(
      physics: physics,
      context: context,
      initialPixels: customInitialOffset ?? 0,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
    );
  }

  void setCustomInitialOffsetOnce(double value) {
    // ignore: prefer_conditional_assignment
    if (customInitialOffset == null) {
      customInitialOffset = value;
    }
  }
}

class ChatViewWidgetState extends State<ChatViewWidget> {
  final centerKey = UniqueKey();

  bool _isDisposed = false;
  final _chatScrollPhysics = ChatScrollPhysics(ChatScrollPhysicsSettings());
  final CustomScrollController _scrollController = CustomScrollController(
    //initialScrollOffset: 100000
  );

  bool setInitialMsgPosition = true;
  bool jumpToLatestAfterBuild = false;

  MessageCache get cache => widget.cache;

  @override
  void initState() {
    super.initState();
    _chatScrollPhysics.settings.messageCache = cache;

    cache.registerCacheUpdateCallback((jumpToLatestMessage) {
      if (!_isDisposed) {
        setState(() {
          log.info("Show updated message list. jumpToLatestMessage: $jumpToLatestMessage");
            log.info("test ${_scrollController.position} at edge ${_scrollController.position.atEdge}");
        log.info("min ${_scrollController.position.minScrollExtent}");
          if (
            jumpToLatestMessage
            // (
            //   _scrollController.hasClients &&
            //   _scrollController.position.atEdge &&
            //   _scrollController.position.pixels == _scrollController.position.minScrollExtent
            // )
          ) {
            //_chatScrollPhysics.settings.jumpToMin = true;
            jumpToLatestAfterBuild = true;


            if (_scrollController.hasClients) {
              // log.info("test ${_scrollController.position}");

              //_scrollController.position.moveTo(1000000);
            }
          }
        });
      }
    });

    _scrollController.addListener(() {
      // log.info("test ${_scrollController.position}");
      // log.info("min ${_scrollController.position.minScrollExtent}");
      // //_scrollController.position.viewportDimension
      // if (_scrollController.offset < _scrollController.position.viewportDimension) {
      //   _scrollController.jumpTo(_scrollController.position.viewportDimension);
      // }
      if (setInitialMsgPosition) {
        setInitialMsgPosition = false;
        log.info("test ${_scrollController.position}");
        log.info("test ${_chatScrollPhysics.settings.reducedScrollArea}");

        //_scrollController.jumpTo(_chatScrollPhysics.settings.reducedScrollArea);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //return normalListViewMessages(widget.accountId);
    return LayoutBuilder(
      builder: (context, constraints) {
        log.info("maxHeight: ${constraints.maxHeight}");
        _scrollController.setCustomInitialOffsetOnce(constraints.maxHeight);
        return messageSliverList2(widget.accountId);
      }
    );
  }

  MessageViewEntry messageEntryToViewData(MessageEntry entry) {
    return (entry.messageText, entry.localId, entry.sentMessageState != null);
  }

  MessageViewEntry emptyViewData() {
    return ("", -1, false);
  }

  Widget messageSliverList2(AccountId match) {
    if (jumpToLatestAfterBuild) {
      Future<void>.delayed(Duration.zero).then((value) async {
        if (!_isDisposed) {
          jumpToLatestAfterBuild = false;
          _chatScrollPhysics.settings.state = ScrollState.normal;
          _scrollController.jumpTo(double.infinity);
        }
      });
    }

    return CustomScrollView(
        center: centerKey,
        physics: _chatScrollPhysics,
        reverse: false,
        controller: _scrollController,
        anchor: 1.0,
        slivers: [
          MySliverFillRemainingWithoutScrollable(
            _chatScrollPhysics,
            false,
            child: Container(
           //   color: Colors.green,
            ),
          ),
          SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              //log.info("top: $index");
              final entry = cache.getMessageUsingConstantIndexing(index);
              if (entry != null) {
                // return Column(
                //   children: [
                //     Text("Top: $index"),
                //     messageRowWidget(context, messageEntryToViewData(entry)),
                //   ],
                // );
                return messageRowWidget(context, messageEntryToViewData(entry));
              } else {
                return null;
              }
            },
            itemCount: cache.getTopMessagesSize(),
          ),
          SliverToBoxAdapter(
            key: centerKey,
            child: Container(),
          ),
          SliverList.builder(
            itemBuilder: (BuildContext context, int index) {
              final correctIndex = -index - 1;
              //log.info("bottom: $correctIndex");
              final entry = cache.getMessageUsingConstantIndexing(correctIndex);
              if (entry != null) {
                // return Column(
                //   children: [
                //     Text("Bottom: $correctIndex"),
                //     messageRowWidget(context, messageEntryToViewData(entry)),
                //   ],
                // );
                return messageRowWidget(context, messageEntryToViewData(entry));
              } else {
                return null;
              }
            },
            itemCount: cache.getBottomMessagesSize(),
          ),
          MySliverFillRemainingWithoutScrollable(
            _chatScrollPhysics,
            true,
            child: Container(
            //  color: Colors.red,
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

enum ScrollState {
  normal,
  virtualKeyboardOpened,
  virtualKeyboardClosed,
}

class ChatScrollPhysicsSettings {
  bool jumpToMin = false;

  MessageCache? messageCache;

  double maxViewportHeightDetected = 0;
  double minViewportHeightDetected = double.maxFinite;

  double reducedScrollArea = 0;
  double bottomExtraScrollArea = 0;

  ScrollState state = ScrollState.normal;
}

class ChatScrollPhysics extends ScrollPhysics {
  final ChatScrollPhysicsSettings settings;
  const ChatScrollPhysics(this.settings, {ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ChatScrollPhysics(settings, parent: null);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    log.info("applyPhysicsToUserOffset $offset");
    settings.state = ScrollState.normal;
    return super.applyPhysicsToUserOffset(position, offset);
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

    // log.info("removedMessagePixels $removedMessagePixels");
    // log.info("old: ${oldPosition.minScrollExtent} new: ${newPosition.minScrollExtent}");
    // log.info("newPostion: ${newPosition}");

    if (settings.maxViewportHeightDetected < newPosition.viewportDimension) {
      settings.maxViewportHeightDetected = newPosition.viewportDimension;
      log.info("New max viewport height detected: ${settings.maxViewportHeightDetected}");
    } else if (settings.minViewportHeightDetected > newPosition.viewportDimension) {
      settings.minViewportHeightDetected = newPosition.viewportDimension;
      log.info("New min viewport height detected: ${settings.minViewportHeightDetected}");
    }

    if (oldPosition.viewportDimension < newPosition.viewportDimension) {
      settings.state = ScrollState.virtualKeyboardClosed;
      log.info("Virtual keyboard closed");
      // if (settings.bottomExtraScrollArea + settings.reducedScrollArea >= 0) {
      //   final viewportDiff = newPosition.viewportDimension - oldPosition.viewportDimension;
      //   return getNewPosition + viewportDiff;
      // // }
      // return getNewPosition + 1;
    } else if (oldPosition.viewportDimension > newPosition.viewportDimension) {
      settings.state = ScrollState.virtualKeyboardOpened;
      log.info("Virtual keyboard opened");
      // if (settings.bottomExtraScrollArea + settings.reducedScrollArea >= 0) {
        // final viewportDiff = newPosition.viewportDimension + oldPosition.viewportDimension;
        // log.info("viewportDiff $viewportDiff");
        // return getNewPosition - settings.maxViewportHeightDetected;
      // }
      // return getNewPosition - 1;
    } else {
      log.info("Virtual keyboard not changed");
    }

    return getNewPosition;
  }

  ScrollMetrics getModifiedPosition(ScrollMetrics position1) {
    final shownMsgArea = position1.viewportDimension - settings.reducedScrollArea;
    // log.info("shownMsgArea $shownMsgArea, bottomExtraScrollArea ${settings.bottomExtraScrollArea}");

    final ScrollMetrics position;
    if (settings.state == ScrollState.normal) {
      position = position1.copyWith(
        minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
        maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
      );
    } else if (settings.state == ScrollState.virtualKeyboardOpened) {
      position = position1.copyWith(
        minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
        maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
      );
    } else {
      position = position1.copyWith(
        minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
        maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
      );
    }
    return position;
  }



  // Modified from Flutter sources
  @override
  double applyBoundaryConditions(ScrollMetrics position1, double value) {
    final position = getModifiedPosition(position1);

    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('$runtimeType.applyBoundaryConditions() was called redundantly.'),
          ErrorDescription(
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.',
          ),
          DiagnosticsProperty<ScrollPhysics>('The physics object in question was', this, style: DiagnosticsTreeStyle.errorProperty),
          DiagnosticsProperty<ScrollMetrics>('The position object in question was', position, style: DiagnosticsTreeStyle.errorProperty),
        ]);
      }
      return true;
    }());

    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll.
      log.info("Underscroll");
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      log.info("Overscroll");
      return value - position.pixels;
    }
    //log.info("v; $value p; ${position.pixels} min: ${position.minScrollExtent} max: ${position.maxScrollExtent}");
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
    //if (value < position.minScrollExtent && position.minScrollExtent < position.pixels - 5000) {
      // Hit top edge.
      log.info("Hit top edge $value ${position.minScrollExtent} ${position.pixels}}");
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      log.info("Hit bottom edge");
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  // TODO: current issue: virtual keyboard open and close not smooth if top list
  //       has more messages than bottom list.
  // Perhaps test BouncingScrollPhysics
  // This factor starts at 0.52 and progressively becomes harder to overscroll
  // as more of the area past the edge is dragged in (represented by an increasing
  // `overscrollFraction` which starts at 0 when there is no overscroll).

  // Modified from Flutter sources
  @override
  Simulation? createBallisticSimulation(ScrollMetrics position1, double velocity) {
    final position = getModifiedPosition(position1);
    // final shownMsgArea = position1.viewportDimension - settings.reducedScrollArea;
    // final position = position1.copyWith(
    //   minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
    //   maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
    // );

    final Tolerance tolerance = toleranceFor(position);
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) {
        end = position.maxScrollExtent;
      }
      if (position.pixels < position.minScrollExtent) {
        end = position.minScrollExtent;
      }
      assert(end != null);
      // return ScrollSpringSimulation(
      //   SpringDescription.withDampingRatio(mass: 1, stiffness: 100000, ratio: 1),
      //   // spring,
      //   position.pixels,
      //   end!,
      //   min(0.0, velocity),
      //   tolerance: tolerance,
      // );
      // return ScrollSpringSimulation(
      //   SpringDescription.withDampingRatio(
      //     mass: 0.5,
      //     stiffness: 100.0,
      //     ratio: 2,
      //   ),
      //   position.pixels,
      //   end!,
      //   min(0.0, velocity),
      //   tolerance: tolerance,
      // );
      log.info("Out of range ${end} $velocity $position1");
      if (settings.state == ScrollState.normal) {
        return NoSimulation(end!);
      } else {
        // settings.state == ScrollState.normal;
        return NoSimulation(end!);
        return LinearSimulation(position.pixels, end!, velocity);
        return null;
      }
    }
    if (velocity.abs() < tolerance.velocity) {
      return null;
    }
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      return null;
    }
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      return null;
    }
    // return null;
    // return NoSimulation(position.pixels);
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }
}

class NoSimulation extends Simulation {
  bool done = false;
  final double end;
  NoSimulation(this.end);

  @override
  double dx(double time) {
    return 1.0;
  }

  @override
  bool isDone(double time) {
    return done;
  }

  @override
  double x(double time) {
    done = true;
    return end;
  }
}

class LinearSimulation extends Simulation {
  final double start;
  final double end;
  final double velocity;
  final double speedMultiplier = 10.0;
  LinearSimulation(this.start, this.end, this.velocity);

  @override
  double dx(double time) {
    return 1.0;
  }

  @override
  bool isDone(double time) {
    return time * speedMultiplier >= 1;
  }

  @override
  double x(double time) {
    log.info("time $time");
    final timeNew = time * speedMultiplier;
    final diff = (end - start).abs() * timeNew;
    return start + diff;
  }
}


// Modified from Flutter sources
class MySliverFillRemainingWithoutScrollable extends SingleChildRenderObjectWidget {
  final ChatScrollPhysics scrollPhysics;
  final bool bottomList;
  const MySliverFillRemainingWithoutScrollable(this.scrollPhysics, this.bottomList, {super.key, super.child});

  @override
  MyRenderSliverFillRemaining createRenderObject(BuildContext context) =>
    MyRenderSliverFillRemaining(scrollPhysics, bottomList);
}

// Modified from Flutter sources
class MyRenderSliverFillRemaining extends RenderSliverSingleBoxAdapter {
  final ChatScrollPhysics scrollPhysics;
  final bool bottomList;
  /// Creates a [RenderSliver] that wraps a non-scrollable [RenderBox] which is
  /// sized to fit the remaining space in the viewport.
  MyRenderSliverFillRemaining(this.scrollPhysics, this.bottomList, { super.child });

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    // The remaining space in the viewportMainAxisExtent. Can be <= 0 if we have
    // scrolled beyond the extent of the screen.
    double extent = constraints.viewportMainAxisExtent - constraints.precedingScrollExtent;
    // The maxExtent includes any overscrolled area. Can be < 0 if we have
    // overscroll in the opposite direction, away from the end of the list.
    double maxExtent = constraints.remainingPaintExtent - min(constraints.overlap, 0.0);

    if (child != null) {
      final double childExtent;
      switch (constraints.axis) {
        case Axis.horizontal:
          childExtent = child!.getMaxIntrinsicWidth(constraints.crossAxisExtent);
        case Axis.vertical:
          childExtent = child!.getMaxIntrinsicHeight(constraints.crossAxisExtent);
      }

      // If the childExtent is greater than the computed extent, we want to use
      // that instead of potentially cutting off the child. This allows us to
      // safely specify a maxExtent.
      extent = max(extent, childExtent);
      // The extent could be larger than the maxExtent due to a larger child
      // size or overscrolling at the top of the scrollable (rather than at the
      // end where this sliver is).
      maxExtent = max(extent, maxExtent);
      if (bottomList) {
        scrollPhysics.settings.bottomExtraScrollArea = maxExtent;
      } else {
        scrollPhysics.settings.reducedScrollArea = maxExtent;
      }
      child!.layout(constraints.asBoxConstraints(minExtent: extent, maxExtent: maxExtent));
    }

    assert(extent.isFinite,
      'The calculated extent for the child of SliverFillRemaining is not finite. '
      'This can happen if the child is a scrollable, in which case, the '
      'hasScrollBody property of SliverFillRemaining should not be set to '
      'false.',
    );
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: extent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: extent,
      paintExtent: min(maxExtent, constraints.remainingPaintExtent),
      maxPaintExtent: maxExtent,
      hasVisualOverflow: extent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
    if (child != null) {
      setChildParentData(child!, constraints, geometry!);
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

  /// If null, message entry does not exists.
  /// First message in top messages list is index 0 message.
  MessageEntry? getMessageUsingConstantIndexing(int index) {
    if (index >= 0) {
      return _topMessages.elementAtOrNull(index)?.entry;
    } else {
      final bottomIndex = -index - 1;
      if (bottomIndex < 0) {
        return null;
      } else {
        return _bottomMessages.elementAtOrNull(bottomIndex)?.entry;
      }
    }
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

  void debugSetInitialMessagesIfNotSet(int debugMsgCount) {
    final List<MessageEntry> msgList = [];
    for (int i = 0; i < debugMsgCount; i++) {
      msgList.add(debugBuildEntry("$i", i % 4 == 0));
    }
    setInitialMessagesIfNotSet(msgList);
  }

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
    _topMessages.add(MessageContainer()..entry = debugBuildEntry(text, isSent));
    _onCacheUpdate!(false);
  }

  void debugRemoveFromTop() {
    if (_topMessages.isNotEmpty) {
      _topMessages.removeAt(0);
    }
    _onCacheUpdate!(false);
  }

  void debugAddToBottom(String text, bool isSent) {
    _bottomMessages.add(MessageContainer()..entry = debugBuildEntry(text, isSent));
    _onCacheUpdate!(true);
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
