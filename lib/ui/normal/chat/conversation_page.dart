import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/data/general/notification/state/message_received.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
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
  final details = newConversationPage(
    profile,
  );
  context.read<NavigatorStateBloc>()
    .pushWithKey(details.page, details.pageKey!, pageInfo: details.pageInfo);
}

NewPageDetails newConversationPage(
  ProfileEntry profile,
) {
  final pageKey = PageKey();
  return NewPageDetails(
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => ConversationBloc(profile.uuid, DefaultConversationDataProvider()),
        lazy: false,
        child: ConversationPage(pageKey, profile)
      ),
    ),
    pageKey: pageKey,
    pageInfo: ConversationPageInfo(profile.uuid),
  );
}

class ConversationPage extends StatefulWidget {
  final PageKey pageKey;
  final ProfileEntry profileEntry;
  const ConversationPage(
    this.pageKey,
    this.profileEntry,
    {Key? key}
  ) : super(key: key);

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Hide notification
    // TODO(prod): Perhaps this can be done in repository code once
    // count of not read messages is implemented.
    NotificationMessageReceived.getInstance().updateMessageReceivedCount(widget.profileEntry.uuid, 0);
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
                      ProfileThumbnailImage.fromProfileEntry(
                        entry: widget.profileEntry,
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
              child: BlocBuilder<ConversationBloc, ConversationData>(
                buildWhen: (previous, current) =>
                  previous.isMatch != current.isMatch ||
                  previous.isBlocked != current.isBlocked,
                builder: (context, state) {
                  if (state.isBlocked) {
                    Future.delayed(Duration.zero, () {
                      showSnackBar(R.strings.conversation_screen_profile_blocked);
                      if (context.mounted) {
                        MyNavigator.removePage(context, widget.pageKey);
                      }
                    });
                    return Container();
                  } else if (!state.isMatch) {
                    return Center(
                      child: Text(context.strings.conversation_screen_make_match_instruction),
                    );
                  } else {
                    return OneEndedMessageListWidget(context.read<ConversationBloc>());
                  }
                },
              ),
            ),
          )
        ),
        SafeArea(child: newMessageArea(context)),
        const MessageRenderer(),
      ],
    );
  }

  Widget newMessageArea(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationData>(
      buildWhen: (previous, current) => previous.resetMessageInputField != current.resetMessageInputField,
      builder: (context, state) {
        if (state.resetMessageInputField) {
          _textEditingController.clear();
          context.read<ConversationBloc>().add(NotifyMessageInputFieldCleared());
        }

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
                    if (message.characters.length > 4000) {
                      showSnackBar(context.strings.conversation_screen_message_too_long);
                      return;
                    }

                    final bloc = context.read<ConversationBloc>();
                    if (bloc.state.isMessageSendingInProgress) {
                      showSnackBar(context.strings.generic_previous_action_in_progress);
                      return;
                    }
                    bloc.add(SendMessageTo(bloc.state.accountId, message));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
