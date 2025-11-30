import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as chat_core;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;

/// A reusable chat message widget that displays a custom child widget
/// along with timestamp and status information.
///
/// This widget provides a consistent container style for custom message types,
/// with support for error states and proper alignment based on message direction.
class ChatMessage extends StatelessWidget {
  /// The child widget to display (e.g., a video call button).
  final Widget child;

  /// The message creation timestamp.
  final DateTime? createdAt;

  /// The message status.
  final chat_core.MessageStatus? status;

  /// Whether the message was sent by the current user.
  final bool isSentByMe;

  /// Whether the message is in an error state.
  final bool isError;

  /// Whether to show the message status indicator.
  final bool showStatus;

  const ChatMessage({
    super.key,
    required this.child,
    required this.createdAt,
    required this.status,
    required this.isSentByMe,
    this.isError = false,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isError
        ? Theme.of(context).colorScheme.errorContainer
        : Theme.of(context).colorScheme.primaryContainer;
    final foregroundColor = isError
        ? Theme.of(context).colorScheme.onErrorContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;

    final timeTextStyle = TextStyle(color: foregroundColor, fontSize: 12.0);
    final statusTextStyle = status == chat_core.MessageStatus.seen
        ? TextStyle(color: Colors.lightBlue, fontSize: 12.0)
        : timeTextStyle;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            const SizedBox(height: 4),
            Align(
              alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  chat_ui.TimeAndStatus(
                    time: createdAt,
                    status: status,
                    showTime: true,
                    showStatus: false,
                    textStyle: timeTextStyle,
                  ),
                  if (isSentByMe && showStatus) ...[
                    const SizedBox(width: 4),
                    chat_ui.TimeAndStatus(
                      time: createdAt,
                      status: status,
                      showTime: false,
                      showStatus: true,
                      textStyle: statusTextStyle,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
