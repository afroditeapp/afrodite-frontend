import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:pihka_frontend/database/profile_entry.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_renderer.dart';
import 'package:pihka_frontend/ui/normal/chat/one_ended_list.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

var log = Logger("ConversationPage");


void openConversationScreen(BuildContext context, ProfileEntry profile) {
  context.read<ConversationBloc>().add(SetConversationView(profile.uuid, profile.imageUuid, profile.name));
  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ConversationPage(profile)));
}

class ConversationPage extends StatefulWidget {
  final ProfileEntry profileEntry;
  const ConversationPage(this.profileEntry, {Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
  late MessageCache cache;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cache = MessageCache(widget.profileEntry.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () {
                openProfileView(context, widget.profileEntry, noAction: true);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  height: AppBar().preferredSize.height,
                  child: Row(
                    children: [
                      accountImgWidget(
                        widget.profileEntry.uuid,
                        widget.profileEntry.imageUuid,
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
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(value: "block", child: Text("Block")),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case "block": {
                  showConfirmDialog(context, "Block profile?")
                    .then((value) {
                      if (value == true) {
                        context.read<ConversationBloc>().add(BlockProfile(widget.profileEntry.uuid));
                      }
                    });
                }
              }
            },
          ),
        ],
      ),
      body: page(),
    );
  }

  Widget page() {
    return Column(
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
                  previous?.messageCount != current?.messageCount ||
                  previous?.isBlocked != current?.isBlocked,
                builder: (context, state) {
                  if (state == null || state.accountId != widget.profileEntry.uuid) {
                    return Container();
                  } else if (state.isBlocked) {
                    Future.delayed(Duration.zero, () {
                      showSnackBar("Profile was blocked");
                      Navigator.pop(context);
                    });
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
