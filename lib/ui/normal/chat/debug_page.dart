import 'dart:async';

import 'package:app/data/chat/message_manager/utils.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/data/chat/message_manager.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat/message_renderer.dart';
import 'package:app/ui/normal/chat/one_ended_list.dart';
import 'package:app/utils/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

void openConversationDebugScreen(BuildContext context, int initialMsgCount) {
  final details = _newDebugConversationPage(
    AccountId(aid: ""),
    initialMsgCount,
  );
  context.read<NavigatorStateBloc>()
    .pushWithKey(details.page, details.pageKey!, pageInfo: details.pageInfo);
}

NewPageDetails _newDebugConversationPage(
  AccountId accountId,
  int initialMsgCount,
) {
  final dataProvider = DebugConversationDataProvider();
  dataProvider.sendInitialMessages(accountId, initialMsgCount);
  final pageKey = PageKey();
  return NewPageDetails(
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ConversationBloc(accountId, dataProvider),
        lazy: false,
        child: ChatViewDebuggerPage(initialMsgCount: initialMsgCount, dataProvider: dataProvider)
      ),
    ),
    pageKey: pageKey,
    pageInfo: ConversationPageInfo(accountId),
  );
}

class DebugConversationDataProvider extends ConversationDataProvider {
  int localIdCounter = 0;
  int msgCountPerUpdate = 1;
  bool isSent = true;
  List<MessageEntry> messages = [];

  BehaviorSubject<(int, ConversationChanged?)> chatUpdates = BehaviorSubject();

  @override
  Future<bool> isInMatches(AccountId accountId) async => false;

  @override
  Future<bool> isInSentBlocks(AccountId accountId) async => false;

  @override
  Future<bool> isInReceivedBlocks(AccountId accountId) async => false;

  @override
  Future<bool> sendBlockTo(AccountId accountId) async => false;

  @override
  Stream<MessageSendingEvent> sendMessageTo(AccountId accountId, String message) async* {
    sendMessageToSync(accountId, message);
    yield const SavedToLocalDb();
    return;
  }

  void sendMessageToSync(AccountId accountId, String message) {
    final MessageState state;
    if (isSent) {
      state = MessageState.pendingSending;
    } else {
      state = MessageState.received;
    }

    for (int i = 0; i < msgCountPerUpdate; i++) {
      var text = message;
      if (msgCountPerUpdate > 1) {
        text = "msg: $message, i: $i, msgPreUpdate: $msgCountPerUpdate";
      }

      final entryId = localIdCounter++;
      final e = MessageEntry(
        localAccountId: AccountId(aid: ""),
        remoteAccountId: AccountId(aid: ""),
        messageText: text,
        localUnixTime: UtcDateTime.now(),
        messageState: state,
        localId: LocalMessageId(entryId),
      );

      messages.add(e);
    }

    final ConversationChanged changed;
    if (isSent) {
      changed = ConversationChanged(AccountId(aid: ""), ConversationChangeType.messageSent);
    } else {
      changed = ConversationChanged(AccountId(aid: ""), ConversationChangeType.messageReceived);
    }

    chatUpdates.add((messages.length, changed));
  }

  @override
  Future<List<MessageEntry>> getAllMessages(AccountId accountId) async {
    return messages.reversed.toList();
  }

  @override
  Stream<(int, ConversationChanged?)> getMessageCountAndChanges(AccountId match) {
    return chatUpdates;
  }

  void sendInitialMessages(AccountId accountId, int initialMsgCount) async {
    for (int i = 0; i < initialMsgCount; i++) {
      sendMessageToSync(accountId, "$i");
    }
  }

  @override
  Future<List<MessageEntry>> getNewMessages(AccountId senderAccountId, LocalMessageId? latestCurrentMessageLocalId) async {
    final newMessages = <MessageEntry>[];
    for (final message in messages.reversed) {
      if (message.localId == latestCurrentMessageLocalId) {
        break;
      }
      newMessages.add(message);
    }
    return newMessages;
  }

  @override
  Stream<MessageEntry?> getMessageWithLocalId(LocalMessageId localId) async* {
    return;
  }

  @override
  Future<Result<void, DeleteSendFailedError>> deleteSendFailedMessage(AccountId receiverAccountId, LocalMessageId localId) async {
    return const Ok(null);
  }

  @override
  Future<Result<void, ResendFailedError>> resendSendFailedMessage(AccountId receiverAccountId, LocalMessageId localId) async {
    return const Ok(null);
  }

  @override
  Future<Result<void, RetryPublicKeyDownloadError>> retryPublicKeyDownload(AccountId receiverAccountId, LocalMessageId localId) async {
    return const Ok(null);
  }
}

class ChatViewDebuggerPage extends StatefulWidget {
  final int initialMsgCount;
  final DebugConversationDataProvider dataProvider;
  final AccountId accountId = AccountId(aid: "");
  ChatViewDebuggerPage({required this.initialMsgCount, required this.dataProvider, Key? key}) : super(key: key);

  @override
  ChatViewDebuggerPageState createState() => ChatViewDebuggerPageState();
}

class ChatViewDebuggerPageState extends State<ChatViewDebuggerPage> {
  int msgCount = 0;
  bool msgAutoSend = false;
  final TextEditingController _textEditingController = TextEditingController();
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();

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
                child: OneEndedMessageListWidget(context.read<ConversationBloc>()),
              ),
            )
          ),
          textEditArea(context),
          newMessageArea(context),
          const MessageRenderer(),
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
              sendToBottom();
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
              widget.dataProvider.msgCountPerUpdate++;
            },
            child: Text("msgPerUpdate++")
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.dataProvider.msgCountPerUpdate >= 1) {
                widget.dataProvider.msgCountPerUpdate--;
              }
            },
            child: Text("msgPerUpdate--")
          ),
        ],
      ),
    );
  }

  void sendToBottom() {
    final count = msgCount++;
    String msg = _textEditingController.text.trim();
    if (msg.isEmpty) {
      msg = count.toString();
    }

    widget.dataProvider.isSent = count % 4 == 0;
    widget.dataProvider.sendMessageToSync(widget.accountId, msg);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
