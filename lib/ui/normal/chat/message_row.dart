


import 'package:flutter/material.dart';
import 'package:database/database.dart';


typedef MessageViewEntry = (String message, LocalMessageId localId, bool isSent);

MessageViewEntry messageEntryToViewData(MessageEntry entry) {
  return (entry.messageText, entry.localId, entry.sentMessageState != null);
}

Align messageRowWidget(BuildContext context, MessageViewEntry entry, {Key? key, required TextStyle parentTextStyle}) {
  final (message, _, isSent) = entry;
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
              child: messageWidget(context, message, isSent, key: key, parentTextStyle: parentTextStyle),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget messageWidget(BuildContext context, String message, bool isSent, {Key? key, required TextStyle parentTextStyle}) {
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
