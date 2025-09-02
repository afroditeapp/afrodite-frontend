import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/ui/normal/chat/message_row.dart';
import 'package:app/ui/normal/report/report.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/profile_thumbnail_image_or_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:app/data/image_cache.dart';
import 'package:database/database.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat/message_renderer.dart';
import 'package:app/ui/normal/chat/one_ended_list.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';

final _log = Logger("ConversationPage");

void openConversationScreen(BuildContext context, AccountId accountId, ProfileEntry? profile) {
  final details = newConversationPage(accountId, profile);
  context.read<NavigatorStateBloc>().pushWithKey(
    details.page,
    details.pageKey!,
    pageInfo: details.pageInfo,
  );
}

NewPageDetails newConversationPage(AccountId accountId, ProfileEntry? profile) {
  final pageKey = PageKey();
  return NewPageDetails(
    MaterialPage<void>(
      child: BlocProvider(
        create: (context) {
          final r = context.read<RepositoryInstances>();
          return ConversationBloc(r, accountId, DefaultConversationDataProvider(r.chat));
        },
        lazy: false,
        child: ConversationPage(pageKey, accountId, profile),
      ),
    ),
    pageKey: pageKey,
    pageInfo: ConversationPageInfo(accountId),
  );
}

class ConversationPage extends StatefulWidget {
  final PageKey pageKey;
  final AccountId accountId;
  final ProfileEntry? profileEntry;
  const ConversationPage(this.pageKey, this.accountId, this.profileEntry, {super.key});

  @override
  ConversationPageState createState() => ConversationPageState();
}

class ConversationPageState extends State<ConversationPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _log.finest("Opening conversation for account: ${widget.accountId}");
  }

  @override
  Widget build(BuildContext context) {
    final profileEntry = widget.profileEntry;
    return Scaffold(
      appBar: AppBar(
        title: profileEntry != null ? appBarTitle(profileEntry) : null,
        actions: [
          if (context.read<ClientFeaturesConfigBloc>().state.config.features.videoCalls)
            IconButton(
              onPressed: () => sendVideoCallInviteDialog(context),
              icon: const Icon(Icons.videocam),
              tooltip: context.strings.conversation_screen_send_video_call_invitation_action,
            ),
          menuActions([
            commonActionBlockProfile(context, () {
              context.read<ConversationBloc>().add(BlockProfile(widget.accountId));
            }),
            showReportAction(context, widget.accountId, profileEntry),
          ]),
        ],
      ),
      body: page(context),
    );
  }

  Widget appBarTitle(ProfileEntry profileEntry) {
    final double appBarHeight = AppBar().preferredSize.height;
    const double IMG_HEIGHT = 40;
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: constraints.copyWith(minHeight: appBarHeight, maxHeight: appBarHeight),
          child: InkWell(
            onTap: () {
              openProfileView(
                context,
                profileEntry,
                null,
                ProfileRefreshPriority.high,
                noAction: true,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileThumbnailImageOrError.fromProfileEntry(
                    entry: profileEntry,
                    width: IMG_HEIGHT,
                    height: IMG_HEIGHT,
                    cacheSize: ImageCacheSize.squareImageForAppBarThumbnail(context, IMG_HEIGHT),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Flexible(
                    child: Text(profileEntry.profileTitle(), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                    previous.isMatch != current.isMatch || previous.isBlocked != current.isBlocked,
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
          ),
        ),
        SafeArea(child: newMessageArea(context)),
        const MessageRenderer(),
      ],
    );
  }

  Widget newMessageArea(BuildContext context) {
    return BlocBuilder<ConversationBloc, ConversationData>(
      buildWhen: (previous, current) =>
          previous.resetMessageInputField != current.resetMessageInputField,
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
                    sendMessage(context, textMessage);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void sendVideoCallInviteDialog(BuildContext context) async {
    if (await isInstallingJitsiMeetAppPossible() && !await isJitsiMeetAppInstalled()) {
      if (context.mounted) {
        openJitsiMeetAppInstallDialogOnAndroidOrIos(context);
      }
      return;
    }

    if (!context.mounted) {
      return;
    }

    final r = await showConfirmDialog(
      context,
      context.strings.conversation_screen_send_video_call_invitation_dialog_title,
      yesNoActions: true,
    );
    if (r == true && context.mounted) {
      sendMessage(context, VideoCallInvitation());
    }
  }

  void sendMessage(BuildContext context, Message message) {
    final bloc = context.read<ConversationBloc>();
    if (bloc.state.isMessageSendingInProgress) {
      showSnackBar(context.strings.generic_previous_action_in_progress);
      return;
    }
    bloc.add(SendMessageTo(bloc.state.accountId, message));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
