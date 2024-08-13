


import 'package:flutter/material.dart';
import 'package:database/database.dart';


typedef MessageViewEntry = (String message, LocalMessageId localId, SentMessageState? sentMessageState);

MessageViewEntry messageEntryToViewData(MessageEntry entry) {
  return (entry.messageText, entry.localId, entry.sentMessageState);
}

Align messageRowWidget(BuildContext context, MessageViewEntry entry, {Key? key, required TextStyle parentTextStyle}) {
  final (message, _, sentMessageState) = entry;
  final isSent = sentMessageState != null;
  return Align(
    //key: key,
    alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
    child: FractionallySizedBox(
      widthFactor: 0.8,
      child: Row(
        children: [
          Expanded(
            child: Align(
              key: key,
              alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
              child: _messageAndErrorWidget(context, message, sentMessageState, parentTextStyle: parentTextStyle),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _messageAndErrorWidget(BuildContext context, String message, SentMessageState? sentMessageState, {required TextStyle parentTextStyle}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        flex: 1,
        child: Visibility(
          visible: sentMessageState == SentMessageState.sendingError,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Icon(Icons.error, color: Theme.of(context).colorScheme.error),
        ),
      ),
      Flexible(
        flex: 10,
        child: _messageWidget(context, message, sentMessageState, parentTextStyle: parentTextStyle),
      ),
    ],
  );
}

Widget _messageWidget(BuildContext context, String message, SentMessageState? sentMessageState, {required TextStyle parentTextStyle}) {
  final styleChanges = TextStyle(
    // color: Theme.of(context).colorScheme.onPrimary,
    color: Theme.of(context).colorScheme.onPrimaryContainer,
    fontSize: 16.0,
  );
  final style = parentTextStyle.merge(
    styleChanges,
  );
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      // color: Theme.of(context).colorScheme.primary,
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      message,
      style: style,
    ),
  );
}
