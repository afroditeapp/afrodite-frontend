import 'dart:async';

import 'package:app/data/chat/message_database_iterator.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/chat/chat_enabled.dart';
import 'package:app/ui/normal/chat/chat_data_outdated_widget.dart';
import 'package:app/ui/normal/chat/chat_list.dart';
import 'package:app/ui/normal/chat/utils.dart';
import 'package:app/ui/normal/report/report.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/navigation/url.dart';
import 'package:app/ui_utils/profile_thumbnail_status_indicators.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:database/database.dart';
import 'package:app/data/profile_repository.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles/view_profile.dart';
import 'package:app/ui_utils/app_bar/common_actions.dart';
import 'package:app/ui_utils/app_bar/menu_actions.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';

/// Creates a ConversationPage with initial messages loaded from the database.
///
/// Returns null if localAccountId cannot be created.
Future<ConversationPage?> createConversationPage(
  RepositoryInstances r,
  AccountId accountId,
  ProfileEntry? profile,
) async {
  final localAccountId = await r.accountDb
      .accountDataWrite((db) => db.account.createLocalAccountIdIfNeeded(accountId))
      .ok();
  if (localAccountId == null) {
    return null;
  }

  // Load initial messages for the conversation
  final messageIterator = MessageDatabaseIterator(r.accountDb);
  await messageIterator.switchConversation(r.chat.currentUser, accountId);
  final initialMessages = await messageIterator.nextList();
  initialMessages.addAll(await messageIterator.nextList());

  // Load chat privacy settings from database because PrivacySettingsBloc
  // might not be initialized yet.
  final chatPrivacySettings =
      await r.accountDb.accountData((db) => db.privacy.getChatPrivacySettings()).ok() ??
      ChatPrivacySettings(
        messageStateDelivered: false,
        messageStateSent: false,
        typingIndicator: false,
      );

  return ConversationPage(
    accountId,
    localAccountId,
    profile,
    initialMessages.reversed.toList(),
    messageIterator,
    chatPrivacySettings,
  );
}

Future<void> openConversationScreen(
  BuildContext context,
  AccountId accountId,
  ProfileEntry? profile,
) async {
  final r = context.read<RepositoryInstances>();
  final page = await createConversationPage(r, accountId, profile);

  if (page == null || !context.mounted) {
    showSnackBar(R.strings.generic_error);
    return;
  }

  await context.read<NavigatorStateBloc>().push(page);
}

class ConversationPageUrlParser extends UrlParser<ConversationPage> {
  final RepositoryInstances r;
  ConversationPageUrlParser(this.r);

  @override
  Future<Result<(ConversationPage, UrlSegments), ()>> parseFromSegments(
    UrlSegments urlSegments,
  ) async {
    final output = await urlSegments.accountId(r.accountDb).ok();
    if (output == null) {
      return Err(());
    }
    final (ids, nextSegments) = output;

    final profile = await r.accountDb
        .accountData((db) => db.profile.getProfileEntry(ids.accountId))
        .ok();

    final page = await createConversationPage(r, ids.accountId, profile);
    if (page == null) {
      return Err(());
    }

    return Ok((page, nextSegments));
  }
}

class ConversationPage extends MyScreenPage<()> {
  final AccountId accountId;
  final LocalAccountId localAccountId;
  final List<IteratorMessage> initialMessages;
  final MessageDatabaseIterator oldMessagesIterator;
  final ChatPrivacySettings chatPrivacySettings;
  ConversationPage(
    this.accountId,
    this.localAccountId,
    ProfileEntry? profile,
    this.initialMessages,
    this.oldMessagesIterator,
    this.chatPrivacySettings,
  ) : super(
        builder: (closer) {
          return BlocProvider(
            create: (context) {
              final r = context.read<RepositoryInstances>();
              return ConversationBloc(r, accountId, DefaultConversationDataProvider(r.chat));
            },
            lazy: false,
            child: ConversationScreen(
              closer,
              accountId,
              profile,
              initialMessages,
              oldMessagesIterator,
              chatPrivacySettings,
            ),
          );
        },
      );

  @override
  String get urlPath => "/$urlName/${localAccountId.id}";

  @override
  bool checkEquality(MyPageWithUrlNavigation<Object> other) =>
      other is ConversationPage && other.accountId == accountId;
}

class ConversationScreen extends StatefulWidget {
  final PageCloser<()> closer;
  final AccountId accountId;
  final ProfileEntry? profileEntry;
  final List<IteratorMessage> initialMessages;
  final MessageDatabaseIterator oldMessagesIterator;
  final ChatPrivacySettings chatPrivacySettings;
  const ConversationScreen(
    this.closer,
    this.accountId,
    this.profileEntry,
    this.initialMessages,
    this.oldMessagesIterator,
    this.chatPrivacySettings, {
    super.key,
  });

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    final profileEntry = widget.profileEntry;
    return Scaffold(
      appBar: AppBar(
        title: profileEntry != null ? appBarTitle(profileEntry) : null,
        actions: [
          if (context.read<ClientFeaturesConfigBloc>().state.config.featuresConfig().videoCalls)
            IconButton(
              onPressed: () {
                if (context.read<ChatEnabledBloc>().state.chatEnabled) {
                  sendVideoCallInviteDialog(context);
                } else {
                  showSnackBar(context.strings.generic_error);
                }
              },
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
      body: ChatViewingBlocker(child: page(context)),
    );
  }

  Widget appBarTitle(ProfileEntry profileEntry) {
    final double appBarHeight = AppBar().preferredSize.height;
    const double IMG_HEIGHT = 40;
    final r = context.read<RepositoryInstances>();
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
                  SizedBox(
                    width: IMG_HEIGHT,
                    height: IMG_HEIGHT,
                    child: UpdatingProfileThumbnailWithInfo(
                      initialData: ProfileThumbnail(entry: profileEntry, isFavorite: false),
                      db: r.accountDb,
                      maxItemWidth: IMG_HEIGHT,
                      appBarMode: true,
                    ),
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
    return BlocBuilder<ConversationBloc, ConversationData>(
      buildWhen: (previous, current) => previous.isBlocked != current.isBlocked,
      builder: (context, state) {
        if (state.isBlocked) {
          Future.delayed(Duration.zero, () {
            showSnackBar(R.strings.conversation_screen_profile_blocked);
            if (context.mounted) {
              widget.closer.close(context, ());
            }
          });
          return Container();
        } else {
          final r = context.read<RepositoryInstances>();
          final clientFeaturesChat = r.account.clientFeaturesConfigValue.chat;
          return ChatList(
            widget.profileEntry,
            widget.initialMessages,
            widget.oldMessagesIterator,
            currentUser: r.accountId,
            messageReceiver: widget.accountId,
            db: r.accountDb,
            typingIndicatorManager: r.chat.typingIndicatorManager,
            typingIndicatorEnabled:
                widget.chatPrivacySettings.typingIndicator &&
                clientFeaturesChat?.typingIndicator != null,
            messageStateDeliveredEnabled:
                widget.chatPrivacySettings.messageStateDelivered &&
                clientFeaturesChat?.messageStateDelivered == true,
            messageStateSeenEnabled:
                widget.chatPrivacySettings.messageStateSent &&
                clientFeaturesChat?.messageStateSeen == true,
          );
        }
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
      await sendMessage(context, VideoCallInvitation());
    }
  }
}

Future<bool> sendMessage(BuildContext context, Message message) {
  final bloc = context.read<ConversationBloc>();
  if (bloc.state.isMessageSendingInProgress) {
    showSnackBar(context.strings.generic_previous_action_in_progress);
    return Future.value(false);
  }
  final completer = Completer<bool>();
  bloc.add(SendMessageTo(bloc.state.accountId, message, completer));
  return completer.future;
}
