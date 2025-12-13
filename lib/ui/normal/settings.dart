import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/profile/profile_filters.dart';
import 'package:app/model/freezed/logic/profile/profile_filters.dart';
import 'package:app/ui/normal/profiles/profile_filters.dart';
import 'package:app/ui/normal/settings/blocked_profiles.dart';
import 'package:app/ui/normal/settings/general/profile_grid_settings.dart';
import 'package:app/ui/normal/settings/location.dart';
import 'package:app/ui/normal/settings/media/current_security_selfie.dart';
import 'package:app/ui/utils/web_notifications/web_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/profile_visibility.dart';
import 'package:app/logic/settings/search_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings/account_settings.dart';
import 'package:app/ui/normal/settings/chat/chat_data.dart';
import 'package:app/ui/normal/settings/data_export.dart';
import 'package:app/ui/normal/settings/media/content_management.dart';
import 'package:app/ui/normal/settings/email_notification_settings.dart';
import 'package:app/ui/normal/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings/notification_settings.dart';
import 'package:app/ui/normal/settings/profile/search_settings.dart';
import 'package:app/localizations.dart';
import 'package:app/model/freezed/logic/settings/profile_visibility.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/api.dart';
import 'package:openapi/api.dart';

void openSettingsScreen(BuildContext context) {
  MyNavigator.push(context, SettingsPage());
}

class SettingsPage extends MyScreenPage<()> with SimpleUrlParser<SettingsPage> {
  SettingsPage() : super(builder: (_) => SettingsScreenOpener());

  @override
  SettingsPage create() => SettingsPage();
}

class SettingsScreenOpener extends StatelessWidget {
  const SettingsScreenOpener({super.key});

  @override
  Widget build(BuildContext context) {
    // Settings screen is open some seconds before user
    // opens another screen, so this is good location
    // to init some blocs which load data from DB.
    context.read<SearchSettingsBloc>();
    return SettingsScreen(profileVisibilityBloc: context.read<ProfileVisibilityBloc>());
  }
}

class SettingsScreen extends StatefulWidget {
  final ProfileVisibilityBloc profileVisibilityBloc;
  const SettingsScreen({required this.profileVisibilityBloc, super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.profileVisibilityBloc.add(ResetEdited());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.settings_screen_title)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Setting.createSetting(Icons.person, context.strings.account_settings_screen_title, () {
            openAccountSettings(context);
          }).toListTile(),
          settingsCategoryTitle(context, context.strings.settings_screen_profile_category),
          ...profileSettings(context),
          settingsCategoryTitle(
            context,
            context.strings.settings_screen_privacy_and_security_category,
          ),
          ...securityAndPrivacySettings(context),
          settingsCategoryTitle(context, context.strings.settings_screen_data_category),
          ...dataSettings(context),
          settingsCategoryTitle(context, context.strings.settings_screen_general_category),
          ...generalSettings(context),
        ],
      ),
    );
  }

  Widget blockedProfiles(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Setting.createSetting(
      Icons.block,
      context.strings.blocked_profiles_screen_title,
      () => MyNavigator.push(context, BlockedProfilesPage(r)),
    ).toListTile();
  }

  Widget securitySelfie(BuildContext context) {
    return Setting.createSetting(
      Icons.image_rounded,
      context.strings.current_security_selfie_screen_title,
      () {
        MyNavigator.push(context, CurrentSecuritySelfiePage());
      },
    ).toListTile();
  }

  List<Widget> profileSettings(BuildContext context) {
    return [
      Setting.createSetting(Icons.search, context.strings.search_settings_screen_title, () {
        MyNavigator.push(context, SearchSettingsPage());
      }).toListTile(),
      Setting.createSettingWithCustomIcon(
        BlocBuilder<ProfileFiltersBloc, ProfileFiltersData>(
          builder: (_, state) => Icon(state.icon()),
        ),
        context.strings.profile_filters_screen_title,
        () => openProfileFilters(context),
      ).toListTile(),
      Setting.createSetting(Icons.location_on, context.strings.profile_location_screen_title, () {
        MyNavigator.push(context, LocationPage());
      }).toListTile(),
    ];
  }

  Widget profileVisibilitySetting(BuildContext context, ProfileVisibilityData state) {
    final ProfileVisibility visibility = state.valueVisibility();
    final String descriptionForVisibility = switch (visibility) {
      ProfileVisibility.pendingPrivate || ProfileVisibility.private =>
        context.strings.settings_screen_profile_visiblity_private_description,
      ProfileVisibility.pendingPublic =>
        context.strings.settings_screen_profile_visiblity_pending_public_description,
      ProfileVisibility.public =>
        context.strings.settings_screen_profile_visiblity_public_description,
      _ => context.strings.generic_error,
    };

    return SwitchListTile(
      title: Text(context.strings.settings_screen_profile_visiblity_setting),
      value: visibility.isPublic(),
      subtitle: Text(descriptionForVisibility),
      onChanged: (bool value) {
        if (state.updateState is! UpdateIdle) {
          showSnackBar(context.strings.generic_previous_action_in_progress);
        } else {
          context.read<ProfileVisibilityBloc>().add(ToggleVisibilityAndSaveSettings());
        }
      },
      secondary: const Icon(Icons.public),
    );
  }

  List<Widget> securityAndPrivacySettings(BuildContext context) {
    return [
      BlocBuilder<ProfileVisibilityBloc, ProfileVisibilityData>(
        builder: (context, state) {
          return profileVisibilitySetting(context, state);
        },
      ),
      Setting.createSetting(Icons.lock, context.strings.privacy_settings_screen_title, () {
        openPrivacySettings(context);
      }).toListTile(),
      blockedProfiles(context),
      securitySelfie(context),
    ];
  }

  List<Widget> dataSettings(BuildContext context) {
    return [
      Setting.createSetting(
        Icons.image_rounded,
        context.strings.content_management_screen_title,
        () {
          openContentManagementScreen(context);
        },
      ).toListTile(),
      Setting.createSetting(Icons.chat, context.strings.chat_data_screen_title, () {
        openChatDataScreen(context);
      }).toListTile(),
      Setting.createSetting(
        Icons.cloud_download,
        context.strings.data_export_screen_title_export_type_user,
        () {
          openDataExportScreenMyData(context);
        },
      ).toListTile(),
    ];
  }

  List<Widget> generalSettings(BuildContext context) {
    return [
      if (!kIsWeb || (kIsWeb && webNotificationsSupported()))
        Setting.createSetting(
          Icons.notifications,
          context.strings.notification_settings_screen_title,
          () {
            openNotificationSettings(context);
          },
        ).toListTile(),
      Setting.createSetting(
        Icons.email,
        context.strings.email_notification_settings_screen_title,
        () {
          openEmailNotificationSettings(context);
        },
      ).toListTile(),
      Setting.createSetting(
        Icons.grid_view_rounded,
        context.strings.profile_grid_settings_screen_title,
        () {
          openProfileGridSettingsScreen(context);
        },
      ).toListTile(),
    ];
  }
}

class Setting {
  final Widget _iconWidget;
  final Widget _widget;
  final void Function() action;
  Setting(this._iconWidget, this._widget, this.action);

  factory Setting.createSetting(IconData icon, String text, void Function() action) {
    return Setting(Icon(icon), Text(text), action);
  }

  factory Setting.createSettingWithCustomIcon(Widget icon, String text, void Function() action) {
    return Setting(icon, Text(text), action);
  }

  Widget toListTile() {
    return ListTile(
      onTap: () {
        action();
      },
      title: _widget,
      leading: _iconWidget,
    );
  }
}

Widget settingsCategoryTitle(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
    ),
  );
}
