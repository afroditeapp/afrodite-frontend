

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/notification_settings.dart';

void openNotificationSettings(BuildContext context) {
  if (NotificationManager.getInstance().osProvidesNotificationSettingsUi) {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  } else {
    MyNavigator.push(context, const MaterialPage<void>(child:
      NotificationSettingsScreen()
    ));
  }
}


class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}


class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.notification_settings_screen_title),
      ),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return BlocBuilder<NotificationSettingsBloc, NotificationSettingsData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            messagesSlider(context, state),
            likesSlider(context, state),
            moderationRequestStateSlider(context, state),
          ],
        );
      }
    );
  }

  Widget messagesSlider(BuildContext context, NotificationSettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.notification_category_messages),
      value: state.categoryEnabledMessages,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleMessages());
      },
    );
  }

  Widget likesSlider(BuildContext context, NotificationSettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.notification_category_likes),
      value: state.categoryEnabledLikes,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleLikes());
      },
    );
  }

  Widget moderationRequestStateSlider(BuildContext context, NotificationSettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.notification_category_moderation_request_status),
      value: state.categoryEnabledModerationRequestStatus,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleModerationRequestStatus());
      },
    );
  }
}
