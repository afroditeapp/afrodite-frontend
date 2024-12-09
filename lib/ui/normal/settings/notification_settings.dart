

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_settings.dart';
import 'package:app/model/freezed/logic/settings/notification_settings.dart';
import 'package:app/ui_utils/padding.dart';

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
            initialContentModerationSlider(context, state),
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
    return categorySwitch(
      title: context.strings.notification_category_messages,
      isEnabled: state.categoryEnabledMessages,
      isEnabledFromSystemSettings: state.categorySystemEnabledMessages,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleMessages());
      },
    );
  }

  Widget likesSlider(BuildContext context, NotificationSettingsData state) {
    return categorySwitch(
      title: context.strings.notification_category_likes,
      isEnabled: state.categoryEnabledLikes,
      isEnabledFromSystemSettings: state.categorySystemEnabledLikes,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleLikes());
      },
    );
  }

  Widget initialContentModerationSlider(BuildContext context, NotificationSettingsData state) {
    return categorySwitch(
      title: context.strings.notification_category_initial_content_moderation,
      isEnabled: state.categoryEnabledInitialContentModeration,
      isEnabledFromSystemSettings: state.categorySystemEnabledInitialContentModeration,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleInitialContentModeration());
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

  Widget categorySwitch(
    {
      required String title,
      required bool isEnabled,
      required bool isEnabledFromSystemSettings,
      required void Function(bool) onChanged,
    }
  ) {
    final bool isEnabledValue;
    final void Function(bool)? onChangedValue;
    final Widget? subtitle;
    if (isEnabledFromSystemSettings) {
      isEnabledValue = isEnabled;
      onChangedValue = onChanged;
      subtitle = null;
    } else {
      isEnabledValue = false;
      onChangedValue = null;
      subtitle = Text(context.strings.notification_settings_screen_notification_category_disabled_from_system_settings_text);
    }

    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle,
      value: isEnabledValue,
      onChanged: onChangedValue,
    );
  }

  @override
  void dispose() {
    listener.dispose();
    super.dispose();
  }
}
