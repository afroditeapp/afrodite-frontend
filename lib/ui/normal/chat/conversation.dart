import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';

class ConversationPage extends StatefulWidget {
  final AccountId accountId;
  const ConversationPage(this.accountId, {Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

typedef MessageViewEntry = (String message, int localId, bool isSent);

class ConversationPageState extends State<ConversationPage> {
  PagingController<int, MessageViewEntry>? _pagingController =
    PagingController(firstPageKey: 0);

  bool viewingMessages = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _pagingController?.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    if (pageKey == 0) {
      await ChatRepository.getInstance().messageIteratorReset(widget.accountId);
    }

    final list = await ChatRepository.getInstance().messageIteratorNext();
    final newList = List<MessageViewEntry>.empty(growable: true);
    for (final entry in list) {
      newList.add(messageEntryToViewData(entry));
    }

    if (list.isEmpty) {
      _pagingController?.appendLastPage(newList);
    } else {
      _pagingController?.appendPage(newList, pageKey + 1);
    }
  }

  MessageViewEntry messageEntryToViewData(MessageEntry entry) {
    return (entry.messageText, entry.localId, entry.sentMessageState != null);
  }

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
                    previous?.isMatch != current?.isMatch,
                  builder: (context, state) {
                    if (state == null) {
                      viewingMessages = false;
                      return Container();
                    } else if (state.isMatch) {
                      viewingMessages = true;
                      return BlocListener<ConversationBloc, ConversationData?>(
                        listenWhen: (previous, current) =>
                          previous?.messageCount != current?.messageCount,
                        listener: (context, data) {
                          _pagingController?.refresh();
                        },
                        child: messageListView(state.accountId, state.messageCount),
                      );
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
    return PagedListView(
      // physics: const ChatScrollPhysics(),
      pagingController: _pagingController!,
      scrollController: _scrollController,
      reverse: true,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<MessageViewEntry>(
        animateTransitions: false,
        itemBuilder: (context, viewEntry, _) {
          final (_, localId, isSent) = viewEntry;
          if (isSent) {
            return StreamBuilder(
              initialData: viewEntry,
              stream: ChatRepository.getInstance()
                .getMessage(match, localId)
                .map((event) {
                  if (event != null) {
                    return messageEntryToViewData(event);
                  } else {
                    return viewEntry;
                  }
                }),
              builder: (context, snapshot) {
                final newViewEntry = snapshot.data;
                if (newViewEntry != null) {
                  return messageRowWidget(context, newViewEntry);
                } else {
                  return messageRowWidget(context, viewEntry);
                }
              },
            );
          } else {
            return messageRowWidget(context, viewEntry);
          }
        },
      ),
    );
  }

  Widget messageRowWidget(BuildContext context, MessageViewEntry entry) {
    final (message, _, isSent) = entry;
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

  @override
  void dispose() {
    _pagingController?.dispose();
    _pagingController = null;
    super.dispose();
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
