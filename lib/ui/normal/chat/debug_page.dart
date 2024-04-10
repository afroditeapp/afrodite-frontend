import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_renderer.dart';
import 'package:pihka_frontend/ui/normal/chat/one_ended_list.dart';



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
                child: OneEndedMessageListWidget(widget.accountId, cache),
              ),
            )
          ),
          textEditArea(context),
          newMessageArea(context),
          MessageRenderer(cache),
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Wrap(
        direction: Axis.horizontal,
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
