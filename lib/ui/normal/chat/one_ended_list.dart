import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/conversation_page.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';
import 'package:pihka_frontend/utils.dart';

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
      customInitialOffset = 0;
    }
  }
}

class OneEndedMessageListWidgetState extends State<OneEndedMessageListWidget> {
  UniqueKey _renderingKey = UniqueKey();
  GlobalKey _test = GlobalKey();
  bool _isDisposed = false;
  final _chatScrollPhysics = SimpleChatScrollPhysics(SimpleChatScrollPhysicsSettings());
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

    cache.registerCacheUpdateCallback((jumpToLatestMessage, addedMessageSize) {
      if (!_isDisposed) {
        setState(() {
          log.info("Show updated message list. jumpToLatestMessage: $jumpToLatestMessage");
            log.info("test ${_scrollController.position} at edge ${_scrollController.position.atEdge}");
        log.info("min ${_scrollController.position.minScrollExtent}");
          _chatScrollPhysics.settings.newMessageHeight = addedMessageSize;

          if (
            jumpToLatestMessage ||
            (
              _scrollController.hasClients &&
              _scrollController.position.atEdge &&
              _scrollController.position.pixels == _scrollController.position.minScrollExtent
            )
          ) {
            //_chatScrollPhysics.settings.jumpToMin = true;
            jumpToLatestAfterBuild = true;


            if (_scrollController.hasClients) {
              // log.info("test ${_scrollController.position}");
              _scrollController.position.jumpTo(0);
              _chatScrollPhysics.settings.jumpToLatest = true;
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
        _chatScrollPhysics.settings.availableArea = constraints.maxHeight;
        return messageSliverList2(widget.accountId);
      }
    );
  }

  Widget messageSliverList2(AccountId match) {
    // if (jumpToLatestAfterBuild) {
    //   Future<void>.delayed(Duration.zero).then((value) async {
    //     if (!_isDisposed) {
    //       jumpToLatestAfterBuild = false;
    //       _chatScrollPhysics.settings.state = ScrollState.normal;
    //       //_scrollController.jumpTo(double.infinity);
    //     }
    //   });
    // }

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
          // Future.delayed(Duration.zero, () {
          //   final key = GlobalKey();
          //   final ovEntry = OverlayEntry(
          //     builder: (context) {
          //       return SingleChildScrollView(
          //         child: messageRowWidget(
          //           context,
          //           messageEntryToViewData(entry),
          //           key: key,
          //           parentTextStyle: style.style,
          //         ),
          //       );
          //       // return messageRowWidget(
          //       //   context,
          //       //   messageEntryToViewData(entry),
          //       //   key: key,
          //       //   parentTextStyle: style.style,
          //       // );
          //     }
          //   );

          //   Overlay.of(context).insert(
          //     ovEntry
          //   );

          //   SchedulerBinding.instance.addPostFrameCallback((_) {
          //     final box = key.currentContext?.findRenderObject() as RenderBox;
          //     final size = box.size;
          //     log.info("$size");
          //   });

          // });

          // final r = messageRowWidget(context, messageEntryToViewData(entry))
          //   .createRenderObject(context);
          // r.layout(const BoxConstraints());
          // log.info("${r.size}");
          // r.dispose();

          return Column(
            children: [
              // Text("$index"),
              messageRowWidget(context, messageEntryToViewData(entry), parentTextStyle: style.style),

            ],
          );

          // return messageRowWidget(context, messageEntryToViewData(entry));

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

enum ScrollState {
  normal,
  virtualKeyboardOpened,
  virtualKeyboardClosed,
}

class SimpleChatScrollPhysicsSettings {
  bool jumpToMin = false;

  MessageCache? messageCache;

  double maxViewportHeightDetected = 0;
  double minViewportHeightDetected = double.maxFinite;

  double reducedScrollArea = 0;
  double bottomExtraScrollArea = 0;

  bool jumpToLatest = false;
  double? newMessageHeight;
  double? availableArea;

  ScrollState state = ScrollState.normal;
}

class SimpleChatScrollPhysics extends ScrollPhysics {
  final SimpleChatScrollPhysicsSettings settings;
  const SimpleChatScrollPhysics(this.settings, {ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SimpleChatScrollPhysics(settings, parent: buildParent(ancestor));
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

    final addedMessageHeight = settings.newMessageHeight;
    final availableArea = settings.availableArea;
    if (addedMessageHeight != null && availableArea != null) {
      settings.newMessageHeight = null;
      log.info("New message height detected: $addedMessageHeight");
      if (settings.jumpToLatest) {
        settings.jumpToLatest = false;
        return getNewPosition;
      } else if (oldPosition.viewportDimension < availableArea &&
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

  // ScrollMetrics getModifiedPosition(ScrollMetrics position1) {
  //   return position1;
  //   final shownMsgArea = position1.viewportDimension - settings.reducedScrollArea;
  //   // log.info("shownMsgArea $shownMsgArea, bottomExtraScrollArea ${settings.bottomExtraScrollArea}");

  //   final ScrollMetrics position;
  //   if (settings.state == ScrollState.normal) {
  //     position = position1.copyWith(
  //       minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
  //       maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
  //     );
  //   } else if (settings.state == ScrollState.virtualKeyboardOpened) {
  //     position = position1.copyWith(
  //       minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
  //       maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
  //     );
  //   } else {
  //     position = position1.copyWith(
  //       minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
  //       maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
  //     );
  //   }
  //   return position;
  // }



  // // Modified from Flutter sources
  // @override
  // double applyBoundaryConditions(ScrollMetrics position1, double value) {
  //   final position = getModifiedPosition(position1);

  //   assert(() {
  //     if (value == position.pixels) {
  //       throw FlutterError.fromParts(<DiagnosticsNode>[
  //         ErrorSummary('$runtimeType.applyBoundaryConditions() was called redundantly.'),
  //         ErrorDescription(
  //           'The proposed new position, $value, is exactly equal to the current position of the '
  //           'given ${position.runtimeType}, ${position.pixels}.\n'
  //           'The applyBoundaryConditions method should only be called when the value is '
  //           'going to actually change the pixels, otherwise it is redundant.',
  //         ),
  //         DiagnosticsProperty<ScrollPhysics>('The physics object in question was', this, style: DiagnosticsTreeStyle.errorProperty),
  //         DiagnosticsProperty<ScrollMetrics>('The position object in question was', position, style: DiagnosticsTreeStyle.errorProperty),
  //       ]);
  //     }
  //     return true;
  //   }());

  //   if (value < position.pixels && position.pixels <= position.minScrollExtent) {
  //     // Underscroll.
  //     log.info("Underscroll");
  //     return value - position.pixels;
  //   }
  //   if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
  //     // Overscroll.
  //     log.info("Overscroll");
  //     return value - position.pixels;
  //   }
  //   //log.info("v; $value p; ${position.pixels} min: ${position.minScrollExtent} max: ${position.maxScrollExtent}");
  //   if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
  //   //if (value < position.minScrollExtent && position.minScrollExtent < position.pixels - 5000) {
  //     // Hit top edge.
  //     log.info("Hit top edge $value ${position.minScrollExtent} ${position.pixels}}");
  //     return value - position.minScrollExtent;
  //   }
  //   if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
  //     // Hit bottom edge.
  //     log.info("Hit bottom edge");
  //     return value - position.maxScrollExtent;
  //   }
  //   return 0.0;
  // }

  // TODO: current issue: virtual keyboard open and close not smooth if top list
  //       has more messages than bottom list.
  // Perhaps test BouncingScrollPhysics
  // This factor starts at 0.52 and progressively becomes harder to overscroll
  // as more of the area past the edge is dragged in (represented by an increasing
  // `overscrollFraction` which starts at 0 when there is no overscroll).

  // // Modified from Flutter sources
  // @override
  // Simulation? createBallisticSimulation(ScrollMetrics position1, double velocity) {
  //   final position = getModifiedPosition(position1);
  //   // final shownMsgArea = position1.viewportDimension - settings.reducedScrollArea;
  //   // final position = position1.copyWith(
  //   //   minScrollExtent: position1.minScrollExtent + settings.reducedScrollArea,
  //   //   maxScrollExtent: position1.maxScrollExtent - min(shownMsgArea, settings.bottomExtraScrollArea),
  //   // );

  //   final Tolerance tolerance = toleranceFor(position);
  //   if (position.outOfRange) {
  //     double? end;
  //     if (position.pixels > position.maxScrollExtent) {
  //       end = position.maxScrollExtent;
  //     }
  //     if (position.pixels < position.minScrollExtent) {
  //       end = position.minScrollExtent;
  //     }
  //     assert(end != null);
  //     // return ScrollSpringSimulation(
  //     //   SpringDescription.withDampingRatio(mass: 1, stiffness: 100000, ratio: 1),
  //     //   // spring,
  //     //   position.pixels,
  //     //   end!,
  //     //   min(0.0, velocity),
  //     //   tolerance: tolerance,
  //     // );
  //     // return ScrollSpringSimulation(
  //     //   SpringDescription.withDampingRatio(
  //     //     mass: 0.5,
  //     //     stiffness: 100.0,
  //     //     ratio: 2,
  //     //   ),
  //     //   position.pixels,
  //     //   end!,
  //     //   min(0.0, velocity),
  //     //   tolerance: tolerance,
  //     // );
  //     log.info("Out of range ${end} $velocity $position1");
  //     if (settings.state == ScrollState.normal) {
  //       return NoSimulation(end!);
  //     } else {
  //       // settings.state == ScrollState.normal;
  //       return NoSimulation(end!);
  //       return LinearSimulation(position.pixels, end!, velocity);
  //       return null;
  //     }
  //   }
  //   if (velocity.abs() < tolerance.velocity) {
  //     return null;
  //   }
  //   if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
  //     return null;
  //   }
  //   if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
  //     return null;
  //   }
  //   // return null;
  //   // return NoSimulation(position.pixels);
  //   return ClampingScrollSimulation(
  //     position: position.pixels,
  //     velocity: velocity,
  //     tolerance: tolerance,
  //   );
  // }
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
