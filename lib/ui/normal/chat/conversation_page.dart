import 'dart:async';

import 'package:app/ui/normal/report/report.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/logic/settings/user_interface.dart';
import 'package:app/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat/message_renderer.dart';
import 'package:app/ui/normal/chat/one_ended_list.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';

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
        create: (_) => ConversationBloc(
          profile.uuid,
          DefaultConversationDataProvider(LoginRepository.getInstance().repositories.chat)
        ),
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
    log.finest("Opening conversation for account: ${widget.profileEntry.uuid}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: AppBar().preferredSize.height,
                maxHeight: AppBar().preferredSize.height,
              ),
              child: InkWell(
                onTap: () {
                  openProfileView(context, widget.profileEntry, null, ProfileRefreshPriority.high, noAction: true);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileThumbnailImageOrError.fromProfileEntry(
                        entry: widget.profileEntry,
                        width: 40,
                        height: 40,
                        cacheSize: ImageCacheSize.sizeForAppBarThumbnail(),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Flexible(
                        child: Text(
                          widget.profileEntry.profileTitle(
                            context.read<UserInterfaceSettingsBloc>().state.showNonAcceptedProfileNames,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
        actions: [
          menuActions([
            commonActionBlockProfile(context, () {
              context.read<ConversationBloc>().add(BlockProfile(widget.profileEntry.uuid));
            }),
            showReportAction(context, widget.profileEntry),
          ]),
        ],
      ),
      body: page(context),
    );
  }

  Widget page(BuildContext context) {
    if (kIsWeb) {
      return buildListReplacementMessage(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.strings.generic_not_supported_on_web,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    } else {
      return pageSupported(context);
    }
  }

  Widget pageSupported(BuildContext context) {
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
                    final textMessage = TextMessage.create(message);
                    if (message.characters.length > 4000 || textMessage == null) {
                      showSnackBar(context.strings.conversation_screen_message_too_long);
                      return;
                    }

                    final bloc = context.read<ConversationBloc>();
                    if (bloc.state.isMessageSendingInProgress) {
                      showSnackBar(context.strings.generic_previous_action_in_progress);
                      return;
                    }
                    bloc.add(SendMessageTo(bloc.state.accountId, textMessage));
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
