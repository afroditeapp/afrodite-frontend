import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
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
import 'package:app/utils/time.dart';
import 'package:openapi/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

const int _OPACITY_FOR_ON_SURFACE_CONTENT = 128;

class MessageListItem extends StatelessWidget {
  final MessageEntry entry;
  final Key? keyFromMessageRenderer;
  final TextStyle parentTextStyle;
  const MessageListItem({
    required this.entry,
    this.keyFromMessageRenderer,
    required this.parentTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sentMessageState = entry.messageState.toSentState();
    final infoState = entry.messageState.toInfoState();
    final isSent = sentMessageState != null;

    Widget rowContent;
    if (infoState == null) {
      rowContent = FractionallySizedBox(
        widthFactor: 0.8,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                child: GestureDetector(
                  onLongPress: () => openMessageMenu(context, entry),
                  child: _messageWidget(
                    context,
                    entry,
                    sentMessageState,
                    entry.messageState.toReceivedState(),
                    parentTextStyle: parentTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Info message
      rowContent = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: infoMessage(context, infoState, parentTextStyle: parentTextStyle),
        ),
      );
    }

    return Align(
      key: keyFromMessageRenderer,
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: rowContent,
    );
  }
}

List<Widget> infoMessage(
  BuildContext context,
  InfoMessageState infoState, {
  required TextStyle parentTextStyle,
}) {
  final String text;
  final IconData iconData;
  switch (infoState) {
    case InfoMessageState.infoMatchFirstPublicKeyReceived:
      text = context.strings.conversation_screen_message_info_encryption_started;
      iconData = Icons.lock;
    case InfoMessageState.infoMatchPublicKeyChanged:
      text = context.strings.conversation_screen_message_info_encryption_key_changed;
      iconData = Icons.key;
  }
  final color = Theme.of(context).colorScheme.onSurface.withAlpha(_OPACITY_FOR_ON_SURFACE_CONTENT);
  final textStyle = parentTextStyle.merge(TextStyle(color: color, fontSize: 13.0));
  return [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(iconData, color: color, size: 20),
    ),
    Text(text, style: textStyle),
  ];
}

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
    VideoCallInvitation() => context.strings.conversation_screen_join_video_call_button,
    UnsupportedMessage() => context.strings.conversation_screen_message_unsupported,
  };
}

Widget _messageWidget(
  BuildContext context,
  MessageEntry entry,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState, {
  required TextStyle parentTextStyle,
}) {
  final showErrorColor =
      (sentMessageState?.isError() ?? false) ||
      (receivedMessageState?.isError() ?? false) ||
      (entry.message?.isError() ?? false);

  final messageTimeTextStyle = parentTextStyle.merge(
    TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withAlpha(_OPACITY_FOR_ON_SURFACE_CONTENT),
      fontSize: 12.0,
    ),
  );

  final mainContent = _messageWidgetMainContent(
    context,
    entry,
    sentMessageState,
    receivedMessageState,
    showErrorColor,
    parentTextStyle: parentTextStyle,
  );

  final Icon? icon;
  if (showErrorColor) {
    icon = Icon(Icons.error, color: Theme.of(context).colorScheme.error);
  } else {
    icon = null;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    child: Column(
      mainAxisAlignment: receivedMessageState != null
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: receivedMessageState != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        showIconIfNeeded(context, mainContent, sentMessageState, receivedMessageState, icon),
        Align(
          alignment: receivedMessageState != null ? Alignment.centerLeft : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
            child: Text(_timeStringFromMessage(entry), style: messageTimeTextStyle),
          ),
        ),
      ],
    ),
  );
}

Widget _messageWidgetMainContent(
  BuildContext context,
  MessageEntry entry,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
  bool showErrorColor, {
  required TextStyle parentTextStyle,
}) {
  final String text = messageWidgetText(
    context,
    entry.message,
    sentMessageState,
    receivedMessageState,
  );
  final textColor = showErrorColor
      ? Theme.of(context).colorScheme.onErrorContainer
      : Theme.of(context).colorScheme.onPrimaryContainer;
  final messageTextStyle = parentTextStyle.merge(TextStyle(color: textColor, fontSize: 16.0));

  Widget messageContent;
  if (entry.message is VideoCallInvitation) {
    messageContent = ElevatedButton.icon(
      onPressed: () => _joinVideoCall(context, entry.remoteAccountId),
      label: Text(text, style: messageTextStyle),
      icon: const Icon(Icons.videocam),
    );
  } else {
    messageContent = Text(text, style: messageTextStyle);
  }

  final widget = Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    decoration: BoxDecoration(
      color: showErrorColor
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: messageContent,
  );

  return widget;
}

Widget showIconIfNeeded(
  BuildContext context,
  Widget messageWidget,
  SentMessageState? sentMessageState,
  ReceivedMessageState? receivedMessageState,
  Icon? icon,
) {
  if (sentMessageState != null) {
    // Sent message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          // Visibility is here to avoid text area size changes
          child: Visibility(
            visible: icon != null,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(padding: const EdgeInsets.only(right: 8.0), child: icon),
          ),
        ),
        Flexible(flex: 10, child: messageWidget),
      ],
    );
  } else if (receivedMessageState != null) {
    // Received message
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Flexible(
            flex: 1,
            child: Padding(padding: const EdgeInsets.only(right: 8.0), child: icon),
          ),
        Flexible(flex: 10, child: messageWidget),
      ],
    );
  } else {
    return const SizedBox.shrink();
  }
}

String _timeStringFromMessage(MessageEntry entry) {
  final messageTime = entry.unixTime ?? entry.localUnixTime;
  return timeString(messageTime);
}

void openMessageMenu(BuildContext screenContext, MessageEntry entry) {
  if (!screenContext.mounted) {
    return;
  }
  FocusScope.of(screenContext).unfocus();

  final message = entry.message;

  final pageKey = PageKey();
  MyNavigator.showDialog<void>(
    context: screenContext,
    pageKey: pageKey,
    builder: (context) => SimpleDialog(
      children: [
        ListTile(
          title: Text(context.strings.generic_details),
          subtitle: Text(context.strings.conversation_screen_open_details_action_subtitle),
          onTap: () async {
            closeActionsAndOpenDetails(screenContext, entry, pageKey);
          },
        ),
        if (message is TextMessage)
          ListTile(
            title: Text(context.strings.generic_copy),
            onTap: () {
              Clipboard.setData(ClipboardData(text: message.text));
              MyNavigator.removePage(context, pageKey, null);
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
              MyNavigator.removePage(context, pageKey, null);
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
              MyNavigator.removePage(context, pageKey, null);
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
              MyNavigator.removePage(context, pageKey, null);
            },
          ),
      ],
    ),
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
  } else if (receivedMessageState == ReceivedMessageState.received) {
    stateText = screenContext.strings.conversation_screen_message_state_received_successfully;
  } else if (receivedMessageState == ReceivedMessageState.decryptingFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_decrypting_failed;
  } else if (receivedMessageState == ReceivedMessageState.publicKeyDownloadFailed) {
    stateText = screenContext.strings.conversation_screen_message_state_public_key_download_failed;
  } else {
    stateText = "";
  }

  final time = entry.unixTime ?? entry.localUnixTime;
  final messageText = messageWidgetText(
    screenContext,
    entry.message,
    sentMessageState,
    receivedMessageState,
  );

  final infoText =
      """
${screenContext.strings.generic_message}: $messageText
${screenContext.strings.conversation_screen_message_details_message_id}: ${entry.messageId?.id}
${screenContext.strings.generic_time}: ${time.dateTime.toIso8601String()}
${screenContext.strings.generic_state}: $stateText""";

  showInfoDialog(screenContext, infoText, existingPageToBeRemoved: existingPageKey);
}

void _joinVideoCall(BuildContext context, AccountId callee) async {
  final api = context.read<RepositoryInstances>().api;

  final videoCallingUrls = await api.chat((api) => api.getVideoCallUrls(callee.aid)).ok();

  if (!context.mounted) {
    return;
  }

  if (videoCallingUrls == null) {
    showSnackBar(context.strings.generic_error_occurred);
    return;
  }

  final jitsiMeetUrls = videoCallingUrls.jitsiMeet;
  if (jitsiMeetUrls == null) {
    showSnackBar(context.strings.generic_this_feature_is_disabled);
    return;
  }

  final Uri url;
  try {
    url = Uri.parse(jitsiMeetUrls.url);
  } catch (_) {
    showSnackBar(context.strings.generic_error_occurred);
    return;
  }

  if (!kIsWeb) {
    try {
      final jitsMeetAppLaunchSuccessful = await launchUrl(url.replace(scheme: "org.jitsi.meet"));
      if (jitsMeetAppLaunchSuccessful) {
        return;
      }
    } catch (_) {}
  }

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
    final customUrl = jitsiMeetUrls.customUrl;
    if (customUrl != null) {
      await launchUrlStringAndShowError(context, customUrl);
    } else {
      await launchUrlAndShowError(context, url);
    }
  }
}

Future<bool> isInstallingJitsiMeetAppPossible() async {
  if (kIsWeb) {
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

Future<void> launchUrlAndShowError(BuildContext context, Uri url) async {
  final launchSuccessful = await launchUrl(url);
  if (!launchSuccessful && context.mounted) {
    showSnackBar(context.strings.generic_error_occurred);
  }
}
