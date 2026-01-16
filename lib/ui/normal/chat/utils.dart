import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/ui/normal/settings/debug.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/utils/result.dart';
import 'package:app/utils/version.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:database/database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/conversation_bloc.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:openapi/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String messageWidgetText(
  BuildContext context,
  Message? message,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
) {
  if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
    return context.strings.conversation_screen_message_state_decrypting_failed;
  } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
    return context.strings.conversation_screen_message_state_public_key_download_failed;
  } else {
    if (message == null) {
      return context.strings.generic_error;
    } else {
      return messageToText(context, message);
    }
  }
}

String messageToText(BuildContext context, Message message) {
  return switch (message) {
    TextMessage() => message.text,
    MessageWithReference() => message.text,
    VideoCallInvitation() => context.strings.conversation_screen_join_video_call_button,
    UnsupportedMessage() => context.strings.conversation_screen_message_unsupported,
  };
}

class MessageActionsDialog extends MyDialogPage<()> {
  MessageActionsDialog({required super.builder});
}

void openMessageMenu(BuildContext screenContext, MessageEntry entry) {
  if (!screenContext.mounted) {
    return;
  }
  FocusScope.of(screenContext).unfocus();

  final message = entry.message;

  Widget builder(BuildContext context, PageCloser<()> closer) {
    return SimpleDialog(
      children: [
        ListTile(
          title: Text(context.strings.generic_details),
          subtitle: Text(context.strings.conversation_screen_open_details_action_subtitle),
          onTap: () async {
            closeActionsAndOpenDetails(screenContext, entry, closer.key);
          },
        ),
        if (message is TextMessage)
          ListTile(
            title: Text(context.strings.generic_copy),
            onTap: () {
              Clipboard.setData(ClipboardData(text: message.text));
              closer.close(context, ());
            },
          ),
        if (entry.messageState.toSentState() == SentMessageState.sendingError)
          ListTile(
            title: Text(context.strings.generic_delete),
            onTap: () async {
              final bloc = screenContext.read<ConversationBloc>();
              if (bloc.state.isActionsInProgress()) {
                showSnackBar(context.strings.generic_previous_action_in_progress);
              } else {
                bloc.add(RemoveSendFailedMessage(entry.localId));
              }
              closer.close(context, ());
            },
          ),
        if (entry.messageState.toSentState() == SentMessageState.sendingError)
          ListTile(
            title: Text(context.strings.generic_resend),
            onTap: () async {
              final bloc = screenContext.read<ConversationBloc>();
              if (bloc.state.isActionsInProgress()) {
                showSnackBar(context.strings.generic_previous_action_in_progress);
              } else {
                bloc.add(ResendSendFailedMessage(entry.localId));
              }
              closer.close(context, ());
            },
          ),
        if (entry.messageState.toReceivedState() == ReceivedMessageState.publicKeyDownloadFailed)
          ListTile(
            title: Text(context.strings.generic_retry),
            onTap: () async {
              final bloc = screenContext.read<ConversationBloc>();
              if (bloc.state.isActionsInProgress()) {
                showSnackBar(context.strings.generic_previous_action_in_progress);
              } else {
                bloc.add(RetryPublicKeyDownload(entry.localId));
              }
              closer.close(context, ());
            },
          ),
      ],
    );
  }

  MyNavigator.showDialog(
    context: screenContext,
    page: MessageActionsDialog(builder: builder),
  );
}

void closeActionsAndOpenDetails(
  BuildContext screenContext,
  MessageEntry entry,
  PageKey existingPageKey,
) {
  if (!screenContext.mounted) {
    return;
  }

  final String stateText;
  final sentMessageState = entry.messageState.toSentState();
  final receivedMessageState = entry.messageState.toReceivedState();
  if (sentMessageState == SentMessageState.pending) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_in_progress;
  } else if (sentMessageState == SentMessageState.sendingError) {
    stateText = screenContext.strings.conversation_screen_message_state_sending_failed;
  } else if (sentMessageState == SentMessageState.sent) {
    stateText = screenContext.strings.conversation_screen_message_state_sent_successfully;
  } else if (sentMessageState == SentMessageState.delivered) {
    stateText = screenContext.strings.conversation_screen_message_state_delivered;
  } else if (sentMessageState == SentMessageState.seen) {
    stateText = screenContext.strings.conversation_screen_message_state_seen;
  } else if (receivedMessageState == ReceivedMessageState.received) {
    stateText = screenContext.strings.conversation_screen_message_state_received_successfully;
  } else if (receivedMessageState == ReceivedMessageState.receivedAndSeenLocally) {
    stateText = screenContext.strings.conversation_screen_message_state_received_and_seen_locally;
  } else if (receivedMessageState == ReceivedMessageState.receivedAndSeen) {
    stateText = screenContext.strings.conversation_screen_message_state_received_and_seen;
  } else if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_decrypting_failed;
  } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_public_key_download_failed;
  } else {
    stateText = "";
  }

  final time = entry.userVisibleTime();
  final messageText = messageWidgetText(
    screenContext,
    entry.message,
    sentMessageState,
    receivedMessageState,
  );
  final localAccountId = screenContext.read<RepositoryInstances>().accountId;
  final sender = receivedMessageState != null ? entry.remoteAccountId : localAccountId;

  final infoText =
      """
${screenContext.strings.generic_message}: $messageText
${screenContext.strings.generic_account_id_text_with_value(sender.shortAccountIdString())}
${screenContext.strings.conversation_screen_message_details_message_id}: ${entry.messageId?.id}
${screenContext.strings.generic_time}: ${time.dateTime.toIso8601String()}
${screenContext.strings.generic_state}: $stateText""";

  showInfoDialog(screenContext, infoText, existingPageToBeRemoved: existingPageKey);
}

void joinVideoCall(BuildContext context, AccountId callee) async {
  final api = context.read<RepositoryInstances>().api;

  final videoCallingUrl = await api.chat((api) => api.postCreateVideoCallUrl(callee.aid)).ok();

  if (!context.mounted) {
    return;
  }

  if (videoCallingUrl == null) {
    showSnackBar(context.strings.generic_error_occurred);
    return;
  }

  final jitsiMeetUrl = videoCallingUrl.jitsiMeet;
  if (jitsiMeetUrl == null) {
    showSnackBar(context.strings.generic_this_feature_is_disabled);
    return;
  }

  if (kIsWeb) {
    // This dialog is required to make sure that launchUrlString works
    final r = await showConfirmDialog(
      context,
      context.strings.conversation_screen_join_video_call_dialog_title,
      yesNoActions: true,
    );
    if (r == true && context.mounted) {
      await _openJitsiMeetToWebBrowser(context, jitsiMeetUrl);
    }
  } else {
    await _openJitsiMeetOnAndroidOrIos(context, jitsiMeetUrl);
  }
}

Future<void> _openJitsiMeetOnAndroidOrIos(BuildContext context, JitsiMeetUrl jitsiMeetUrl) async {
  if (!(Platform.isAndroid || Platform.isIOS)) {
    showSnackBar(context.strings.generic_error);
    return;
  }

  final Uri url;
  try {
    url = Uri.parse(jitsiMeetUrl.url);
  } catch (_) {
    showSnackBar(context.strings.generic_error_occurred);
    return;
  }

  try {
    final jitsMeetAppLaunchSuccessful = await launchUrl(url.replace(scheme: "org.jitsi.meet"));
    if (jitsMeetAppLaunchSuccessful) {
      return;
    }
  } catch (_) {}

  // Jitsi Meet app is not installed

  if (!context.mounted) {
    return;
  }

  if (await isInstallingJitsiMeetAppPossible()) {
    if (!context.mounted) {
      return;
    }
    // The web app was disabled completely because hardware
    // volume buttons don't change meeting audio volume when
    // the meeting is opened in Android Chrome browser and
    // the browser is running on a Samsung Android device.
    //
    // https://github.com/jitsi/jitsi-meet/issues/16020
    //
    // If the web app is allowed at some point on other devices
    // and customUrl opens a web page which closes itself with
    // window.close(), disable the customUrl on iOS because iOS
    // in-app browser screen does not close with that method.
    openJitsiMeetAppInstallDialogOnAndroidOrIos(context);
  } else {
    if (!context.mounted) {
      return;
    }
    await _openJitsiMeetToWebBrowser(context, jitsiMeetUrl);
  }
}

Future<void> _openJitsiMeetToWebBrowser(BuildContext context, JitsiMeetUrl jitsiMeetUrl) async {
  final customUrl = jitsiMeetUrl.customUrl;
  if (customUrl != null) {
    await launchUrlStringAndShowError(context, customUrl);
  } else {
    await launchUrlStringAndShowError(context, jitsiMeetUrl.url);
  }
}

Future<bool> isInstallingJitsiMeetAppPossible() async {
  if (kIsWeb || getDebugLogic().openVideoCallsToBrowser) {
    return false;
  }

  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final version = IosVersion.parse(iosInfo);
    if (version != null) {
      return version.major >= 16 || (version.major == 15 && version.minor >= 1);
    } else {
      return false;
    }
  } else if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt >= ANDROID_8_API_LEVEL;
  } else {
    return false;
  }
}

Future<bool> isJitsiMeetAppInstalled() {
  return canLaunchUrlString("org.jitsi.meet://test");
}

/// The app offers better user experience
void openJitsiMeetAppInstallDialogOnAndroidOrIos(BuildContext context) {
  if (Platform.isAndroid) {
    openJitsiMeetAppInstallDialog(
      context,
      context.strings.conversation_screen_install_jitsi_meet_dialog_description_android,
      (context) async {
        const intent = AndroidIntent(
          action: "action_view",
          data: "https://play.google.com/store/apps/details?id=org.jitsi.meet",
          package: "com.android.vending",
        );
        try {
          await intent.launch();
        } catch (_) {
          if (context.mounted) {
            showSnackBar(context.strings.generic_error_occurred);
          }
        }
      },
    );
  } else if (Platform.isIOS) {
    openJitsiMeetAppInstallDialog(
      context,
      context.strings.conversation_screen_install_jitsi_meet_dialog_description_ios,
      (context) => launchUrlStringAndShowError(context, "https://apps.apple.com/app/id1165103905"),
    );
  }
}

void openJitsiMeetAppInstallDialog(
  BuildContext context,
  String dialogText,
  void Function(BuildContext) action,
) async {
  final r = await showConfirmDialog(
    context,
    context.strings.conversation_screen_install_jitsi_meet_dialog_title,
    details: dialogText,
    yesNoActions: true,
  );

  if (r == true && context.mounted) {
    action(context);
  }
}

Future<void> launchUrlStringAndShowError(BuildContext context, String url) async {
  final launchSuccessful = await launchUrlString(url);
  if (!launchSuccessful && context.mounted) {
    showSnackBar(context.strings.generic_error_occurred);
  }
}
