

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/privacy_settings.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/blocked_profiles.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/utils/api.dart';

class PrivacySettingsScreen extends StatefulWidget {
  final PageKey pageKey;
  final PrivacySettingsBloc privacySettingsBloc;
  final AccountBloc accountBloc;
  const PrivacySettingsScreen({
    required this.pageKey,
    required this.privacySettingsBloc,
    required this.accountBloc,
    super.key
  });

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {

  @override
  void initState() {
    super.initState();
    widget.privacySettingsBloc.add(
      ResetEditablePrivacySettings(widget.accountBloc.state.visibility),
    );
  }

  void validateAndSaveData(BuildContext context) {
    final state = widget.privacySettingsBloc.state;
    if (state.currentVisibility == state.initialVisibility) {
      MyNavigator.pop(context);
      return;
    }
    widget.privacySettingsBloc.add(SaveSettings(state.currentVisibility));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        validateAndSaveData(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.privacy_settings_screen_title)),
        body: updateStateHandler<PrivacySettingsBloc, PrivacySettingsData>(
          context: context,
          pageKey: widget.pageKey,
          child: content(context),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
          builder: (context, state) {
            return profileVisibilitySetting(context, state.currentVisibility);
          }
        ),
        blockedProfiles(),
      ],
    );
  }

  Widget blockedProfiles() {
    return Setting.createSetting(Icons.block, context.strings.blocked_profiles_screen_title, () =>
      MyNavigator.push(context, MaterialPage<void>(child: const BlockedProfilesScreen()))
    ).toListTile();
  }

  Widget profileVisibilitySetting(BuildContext context, ProfileVisibility visibility) {
    final String descriptionForVisibility = switch (visibility) {
      ProfileVisibility.pendingPrivate || ProfileVisibility.private =>
        context.strings.privacy_settings_screen_profile_visiblity_private_description,
      ProfileVisibility.pendingPublic =>
        context.strings.privacy_settings_screen_profile_visiblity_pending_public_description,
      ProfileVisibility.public =>
        context.strings.privacy_settings_screen_profile_visiblity_public_description,
      _ => context.strings.generic_error,
    };

    return SwitchListTile(
      title: Text(context.strings.privacy_settings_screen_profile_visiblity_setting),
      value: visibility.isPublic(),
      subtitle: Text(descriptionForVisibility),
      onChanged: (bool value) {
        context.read<PrivacySettingsBloc>().add(ToggleVisibility());
      },
      secondary: const Icon(Icons.public),
    );
  }
}
