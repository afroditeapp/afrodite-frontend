import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/chat_repository.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/chat/message_database.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_renderer.dart';
import 'package:pihka_frontend/ui/normal/chat/two_ended_list.dart';
import 'package:pihka_frontend/ui/normal/chat/one_ended_list.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/utils.dart';

var log = Logger("ConversationPage");

class ConversationPage extends StatefulWidget {
  final AccountId accountId;
  final ProfileEntry profileEntry;
  final File img;
  const ConversationPage(this.accountId, this.profileEntry, this.img, {Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
  late MessageCache cache;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.accountId);
    log.info("Opening conversation to ${widget.accountId.accountId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () {
                openProfileView(context, widget.accountId, widget.profileEntry, widget.img, null, noAction: true);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  height: AppBar().preferredSize.height,
                  child: Row(
                    children: [
                      Image.file(
                        widget.img,
                        width: 40,
                        height: 40,
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Text(widget.profileEntry.name),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    previous?.accountId != current?.accountId ||
                    previous?.isMatch != current?.isMatch ||
                    previous?.messageCount != current?.messageCount,
                  builder: (context, state) {
                    if (state == null || state.accountId != widget.accountId) {
                      return Container();
                    } else if (!state.isMatch) {
                      return const Center(
                        child: Text('Send a message to make a match!'),
                      );
                    } else {
                      log.info("Message count: ${state.messageCount}");
                      cache.setInitialMessagesIfNotSet(state.initialMessages.messages);
                      // It does not matter if this is called right after.
                      // Messages will not be fetched because size of message
                      // count is the same.
                      cache.setNewSize(
                        state.messageCount,
                        state.messageCountChangeInfo == ConversationChangeType.messageSent
                      );

                      return OneEndedMessageListWidget(state.accountId, cache);
                    }
                  },
                ),
              ),
            )
          ),
          newMessageArea(context),
          MessageRenderer(cache),
        ],
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
                  log.info("Sending message to ${state.accountId.accountId}");
                  bloc.add(SendMessageTo(state.accountId, message));
                  _textEditingController.clear();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
