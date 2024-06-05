
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/logic/chat/message_renderer_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/message_renderer_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/message_row.dart';

var log = Logger("MessageRenderer");

class MessageRenderer extends StatefulWidget {
  const MessageRenderer({Key? key}) : super(key: key);

  @override
  MessageRendererState createState() => MessageRendererState();
}

class MessageRendererState extends State<MessageRenderer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageRendererBloc, MessageRendererData>(
      buildWhen: (previous, current) {
        return previous.currentlyRendering != current.currentlyRendering;
      },
      builder: (_, data) {
        if (!context.mounted) {
          return const SizedBox.shrink();
        }

        final messageRendererBloc = context.read<MessageRendererBloc>();
        final style = DefaultTextStyle.of(context);
        final message = data.currentlyRendering;

        if (message == null) {
          return const SizedBox.shrink();
        }

        Future.delayed(Duration.zero, () {
          if (!context.mounted) {
            return;
          }

          final key = GlobalKey();
          final ovEntry = OverlayEntry(
            builder: (context) {
              return Offstage(
                child: SingleChildScrollView(
                  child: messageRowWidget(
                    context,
                    messageEntryToViewData(message),
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
            final height = box.size.height;
            log.info("Rendered height: $height");
            ovEntry.remove();
            ovEntry.dispose();
            if (!context.mounted) {
              return;
            }
            messageRendererBloc.add(RenderingCompleted(height));
          });
        });

        return const SizedBox.shrink();
      }
    );
  }
}
