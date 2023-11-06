import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

// typedef MessageViewEntry = (String message, bool isSent);

class ConversationPageState extends State<ConversationPage> {
  // PagingController<int, MessageViewEntry>? _pagingController =
  //   PagingController(firstPageKey: 0);

  final List<Map<String, dynamic>> _messages = [
    {'message': 'Hi there!', 'isSent': false},
    {'message': 'Hello!', 'isSent': true},
    {'message': 'How are you?', 'isSent': true},
    {'message': 'I am doing well, thanks. How about you?', 'isSent': false},
    {'message': 'I am good too, thanks for asking!', 'isSent': true},
    {'message': 'Bye!', 'isSent': false},
  ];

  bool viewingMessages = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  //   _pagingController?.addPageRequestListener((pageKey) {
  //     _fetchPage(pageKey);
  //   });
  // }

  // Future<void> _fetchPage(int pageKey) async {
  //   if (pageKey == 0) {
  //     ChatRepository.getInstance().messageIteratorReset();
  //   }

  //   final profileList = await ProfileRepository.getInstance().nextList();

  //   final newList = List<MessageViewEntry>.empty(growable: true);
  //   for (final profile in profileList) {
  //     final accountId = AccountId(accountId: profile.uuid);
  //     final contentId = ContentId(contentId: profile.imageUuid);
  //     final file = await ImageCacheData.getInstance().getImage(accountId, contentId);
  //     if (file == null) {
  //       log.warning("Skipping one profile because image loading failed");
  //       continue;
  //     }
  //     newList.add((profile, file, _heroUniqueIdCounter));
  //     _heroUniqueIdCounter++;
  //   }

  //   if (profileList.isEmpty) {
  //     _pagingController?.appendLastPage([]);
  //   } else {
  //     _pagingController?.appendPage(newList, pageKey + 1);
  //   }
  // }

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
                    previous?.messageCount != current?.messageCount,
                  builder: (context, state) {
                    if (state == null) {
                      viewingMessages = false;
                      return Container();
                    } else if (state.isMatch) {
                      viewingMessages = true;
                      return messageListView(state.accountId, state.messageCount);
                    } else {
                      viewingMessages = false;
                      return const Center(
                        child: Text('Send a message to make a match!'),
                      );
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

  Widget messageListView(AccountId match, int messagesLenght) {
    return ListView.builder(
      physics: const ChatScrollPhysics(),
      controller: _scrollController,
      reverse: true,
      shrinkWrap: true,
      itemCount: messagesLenght,
      itemBuilder: (context, index) {
        return StreamBuilder(
          stream: ChatRepository.getInstance().getMessage(match, index),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data != null) {
              final message = data.messageText;
              final isSent = data.sentMessageState != null;
              return messageRowWidget(context, message, isSent);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  Widget messageRowWidget(BuildContext context, String message, bool isSent) {
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
                  bloc.add(SendMessageTo(state.accountId, message));
                  _textEditingController.clear();
                  if (viewingMessages) {
                    _scrollController.position.jumpTo(0);
                  }
                }
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
