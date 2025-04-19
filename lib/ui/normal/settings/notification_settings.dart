

import 'dart:io';

import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/data/notification_manager.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/notification_settings.dart';
import 'package:app/model/freezed/logic/settings/notification_settings.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:openapi/api.dart';

// TODO(prod): Consider removing initial image moderation status cagetory
//             and adding categories for profile name, text and image
//             moderations.
// TODO(prod): Introduce notification categories Chat, General, Other

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
    super.key,
  });

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
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfig>(
      builder: (context, features) {
        return BlocBuilder<NotificationSettingsBloc, NotificationSettingsData>(
          builder: (context, state) {
            return contentWidget(context, features, state);
          }
        );
      }
    );
  }

  Widget contentWidget(
    BuildContext context,
    ClientFeaturesConfig features,
    NotificationSettingsData state,
  ) {
    final List<Widget> settingsList;
    if (state.areNotificationsEnabled) {
      final settings = [
        messagesSlider(context, state),
        likesSlider(context, state),
        mediaContentModerationCompletedSlider(context, state),
        profileTextModerationCompletedSlider(context, state),
        if (features.features.news) newsSlider(context, state),
      ];
      if (Platform.isAndroid) {
        // Use same order as in system notification settings
        settings.sortBy<String>((v) => v.$1.id);
      } else {
        settings.sortBy<String>((v) => v.$1.title);
      }
      settingsList = settings.map((v) => v.$2).toList();
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

  (NotificationCategory, Widget) messagesSlider(BuildContext context, NotificationSettingsData state) {
    const category = NotificationCategoryMessages();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.categoryEnabledMessages,
      isEnabledFromSystemSettings: state.categorySystemEnabledMessages,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleMessages());
      },
    );
    return (category, widget);
  }

  (NotificationCategory, Widget) likesSlider(BuildContext context, NotificationSettingsData state) {
    const category = NotificationCategoryLikes();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.categoryEnabledLikes,
      isEnabledFromSystemSettings: state.categorySystemEnabledLikes,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleLikes());
      },
    );
    return (category, widget);
  }

  (NotificationCategory, Widget) mediaContentModerationCompletedSlider(BuildContext context, NotificationSettingsData state) {
    const category = NotificationCategoryMediaContentModerationCompleted();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.categoryEnabledMediaContentModerationCompleted,
      isEnabledFromSystemSettings: state.categorySystemEnabledMediaContentModerationCompleted,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleMediaContentModerationCompleted());
      },
    );
    return (category, widget);
  }

  (NotificationCategory, Widget) profileTextModerationCompletedSlider(BuildContext context, NotificationSettingsData state) {
    const category = NotificationCategoryProfileTextModerationCompleted();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.categoryEnabledProfileTextModerationCompleted,
      isEnabledFromSystemSettings: state.categorySystemEnabledProfileTextModerationCompleted,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleProfileTextModerationCompleted());
      },
    );
    return (category, widget);
  }

  (NotificationCategory, Widget) newsSlider(BuildContext context, NotificationSettingsData state) {
    const category = NotificationCategoryNewsItemAvailable();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.categoryEnabledNews,
      isEnabledFromSystemSettings: state.categorySystemEnabledNews,
      onChanged: (value) {
        context.read<NotificationSettingsBloc>().add(ToggleNews());
      },
    );
    return (category, widget);
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
