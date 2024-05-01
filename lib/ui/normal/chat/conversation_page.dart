import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/data/profile_repository.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/ui/normal/chat/cache.dart';
import 'package:pihka_frontend/ui/normal/chat/message_renderer.dart';
import 'package:pihka_frontend/ui/normal/chat/one_ended_list.dart';
import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/app_bar/common_actions.dart';
import 'package:pihka_frontend/ui_utils/app_bar/menu_actions.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

var log = Logger("ConversationPage");

// TODO: What should happen when message is not sent successfully and there
// is not yet a match? Should there be an error message?

void openConversationScreen(BuildContext context, ProfileEntry profile) {
  openConversationScreenNoBuildContext(
    context.read<ConversationBloc>(),
    context.read<NavigatorStateBloc>(),
    profile,
  );
}

Future<void> openConversationScreenNoBuildContext(
  ConversationBloc conversationBloc,
  NavigatorStateBloc navigatorStateBloc,
  ProfileEntry profile,
) async {
  await navigatorStateBloc.push(
    MaterialPage<void>(child: ConversationPage(conversationBloc, profile)),
    pageInfo: ConversationPageInfo(profile.uuid),
  );
}

class ConversationPage extends StatefulWidget {
  final ConversationBloc conversationBloc;
  final ProfileEntry profileEntry;
  const ConversationPage(this.conversationBloc, this.profileEntry, {Key? key}) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
  late MessageCache cache;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.conversationBloc.add(SetConversationView(
      widget.profileEntry.uuid,
      widget.profileEntry.imageUuid,
      widget.profileEntry.name
    ));
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
                      ProfileThumbnailImage(
                        accountId: widget.profileEntry.uuid,
                        contentId: widget.profileEntry.imageUuid,
                        width: 40,
                        height: 40,
                        cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Text(widget.profileEntry.profileTitle()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          menuActions([
            commonActionBlockProfile(context, () {
              context.read<ConversationBloc>().add(BlockProfile(widget.profileEntry.uuid));
            })
          ]),
        ],
      ),
      body: page(context),
    );
  }

  Widget page(BuildContext context) {
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
                      showSnackBar(R.strings.conversation_screen_profile_blocked);
                      if (context.mounted) {
                        MyNavigator.pop(context);
                      }
                    });
                    return Container();
                  } else if (!state.isMatch) {
                    return Center(
                      child: Text(context.strings.conversation_screen_make_match_instruction),
                    );
                  } else {
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
                hintText: context.strings.conversation_screen_chat_box_placeholder_text,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final message = _textEditingController.text.trim();
              if (message.isNotEmpty) {
                final bloc = context.read<ConversationBloc>();
                final state = bloc.state;
                if (state != null) {
                  bloc.add(SendMessageTo(state.accountId, message));
                  _textEditingController.clear();
                }
              } else {
                _textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
