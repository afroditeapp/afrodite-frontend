import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
final List<Map<String, dynamic>> _messages = [
    {'message': 'Hi there!', 'isSent': false},
    {'message': 'Hello!', 'isSent': true},
    {'message': 'How are you?', 'isSent': true},
    {'message': 'I am doing well, thanks. How about you?', 'isSent': false},
    {'message': 'I am good too, thanks for asking!', 'isSent': true},
    {'message': 'Bye!', 'isSent': false},

  ];

  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

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
                child: messageListView(),
              ),
            )
          ),
          newMessageArea(context),
        ],
      ),
    );
  }

  Widget messageListView() {
    return ListView.builder(
      physics: const ChatScrollPhysics(),
      controller: _scrollController,
      reverse: true,
      shrinkWrap: true,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[_messages.length - 1 - index];
        return messageRowWidget(context, message);
      },
    );
  }

  Widget messageRowWidget(BuildContext context, Map<String, dynamic> message) {
    return Align(
      alignment: message['isSent'] as bool ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: message['isSent'] as bool ? Alignment.centerRight : Alignment.centerLeft,
                child: messageWidget(context, message),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messageWidget(BuildContext context, Map<String, dynamic> message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: message['isSent'] as bool ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        message['message'] as String,
        style: TextStyle(
          color: message['isSent'] as bool ? Colors.white : Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget newMessageArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            icon: Icon(Icons.send),
            onPressed: () {
              final message = _textEditingController.text;
              if (message.isNotEmpty) {
                setState(() {
                  _messages.add({'message': message, 'isSent': true});
                  _scrollController.position.moveTo(0);
                });
                _textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatScrollPhysics extends ScrollPhysics {
  const ChatScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ChatScrollPhysics(parent: buildParent(ancestor));
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

    final double addedMessagePixels = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;
    if (getNewPosition != 0 && addedMessagePixels > 0.0) {
      return getNewPosition + addedMessagePixels;
    } else {
      return getNewPosition;
    }
  }
}
