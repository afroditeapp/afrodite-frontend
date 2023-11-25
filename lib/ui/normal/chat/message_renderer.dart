



import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';



class MessageRenderer extends StatefulWidget {
  final MessageCache cache;
  const MessageRenderer(this.cache, {Key? key}) : super(key: key);

  @override
  MessageRendererState createState() => MessageRendererState();
}


class MessageRendererState extends State<MessageRenderer> {
  double totalHeight = 0;
  MessageContainer? message;

  @override
  void initState() {
    super.initState();
    widget.cache.registerMessageRenderCallback((message, totalHeight) {
      setState(() {
        this.message = message;
        this.totalHeight = totalHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageData = message;
    if (messageData == null) {
      return Container();
    }

    final style = DefaultTextStyle.of(context);

    Future.delayed(Duration.zero, () {
      final key = GlobalKey();
      final ovEntry = OverlayEntry(
        builder: (context) {
          return Offstage(
            child: SingleChildScrollView(
              child: messageRowWidget(
                context,
                messageEntryToViewData(messageData.entry),
                key: key,
                parentTextStyle: style.style,
              ),
            ),
          );
        }
      );

      Overlay.of(context).insert(
        ovEntry
      );

      SchedulerBinding.instance.addPostFrameCallback((_) {
        final box = key.currentContext?.findRenderObject() as RenderBox;
        totalHeight += box.size.height;
        log.info("Rendered height: $totalHeight");
        ovEntry.remove();
        ovEntry.dispose();
        widget.cache.completeOneRendering(messageData, totalHeight);
      });
    });

    return Container();
  }
}
