

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/data/notification_manager.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/app/notification_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/notification_settings.dart';
import 'package:pihka_frontend/ui_utils/padding.dart';

void openNotificationSettings(BuildContext context) {
  if (NotificationManager.getInstance().osProvidesNotificationSettingsUi) {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  } else {
    final notificationSettingsBloc = context.read<NotificationSettingsBloc>();
    MyNavigator.push(context, MaterialPage<void>(child:
      NotificationSettingsScreen(notificationSettingsBloc: notificationSettingsBloc)
    ));
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  final NotificationSettingsBloc notificationSettingsBloc;
  const NotificationSettingsScreen({
    required this.notificationSettingsBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}


class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  late final AppLifecycleListener listener;

  @override
  void initState() {
    super.initState();
    widget.notificationSettingsBloc.add(ReloadNotificationsEnabledStatus());
    listener = AppLifecycleListener(
      onShow: () {
        widget.notificationSettingsBloc.add(ReloadNotificationsEnabledStatus());
      },
    );
  }

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
        final List<Widget> settingsList;
        if (state.areNotificationsEnabled) {
          settingsList = [
            messagesSlider(context, state),
            likesSlider(context, state),
            moderationRequestStateSlider(context, state),
          ];
        } else {
          settingsList = [
            const Padding(padding: EdgeInsets.all(4)),
            hPad(Text(context.strings.notification_settings_screen_notifications_disabled_from_system_settings_text)),
            const Padding(padding: EdgeInsets.all(4)),
          ];
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...settingsList,
            actionOpenSystemNotificationSettings(),
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

  Widget actionOpenSystemNotificationSettings() {
    return ListTile(
      title: Text(context.strings.notification_settings_screen_open_system_notification_settings),
      onTap: () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      },
      leading: const Icon(Icons.settings),
    );
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }
}
