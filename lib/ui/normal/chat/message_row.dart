


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pihka_frontend/database/message_entry.dart';


typedef MessageViewEntry = (String message, int? localId, bool isSent);

MessageViewEntry messageEntryToViewData(MessageEntry entry) {
  return (entry.messageText, entry.localId, entry.sentMessageState != null);
}

MessageViewEntry emptyViewData() {
  return ("", -1, false);
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
    color: isSent ? Colors.white : Colors.black,
    fontSize: 16.0,
  );

  final style = parentTextStyle.merge(
    styleChanges,
  );

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: isSent ? Colors.blue : Colors.grey[300],
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      message,
      style: style,
    ),
  );
}
