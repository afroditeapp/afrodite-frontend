

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/blocked_profiles.dart';
import 'package:app/ui/normal/settings/media/current_security_selfie.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/utils/api.dart';

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

  void saveData(BuildContext context) {
    final state = widget.privacySettingsBloc.state;
    if (state.currentVisibility == state.initialVisibility) {
      MyNavigator.pop(context);
      return;
    }
    widget.privacySettingsBloc.add(SaveSettings(state.currentVisibility));
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<PrivacySettingsBloc, PrivacySettingsData>(
      context: context,
      pageKey: widget.pageKey,
      child: BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
        builder: (context, state) {
          final settingsChanged = state.currentVisibility != state.initialVisibility;

          return PopScope(
            canPop: !settingsChanged,
            onPopInvoked: (didPop) {
              if (didPop) {
                return;
              }
              showConfirmDialog(context, context.strings.generic_save_confirmation_title, yesNoActions: true)
                .then((value) {
                  if (value == true) {
                    saveData(context);
                  } else if (value == false) {
                    MyNavigator.pop(context);
                  }
                });
            },
            child: Scaffold(
              appBar: AppBar(title: Text(context.strings.privacy_settings_screen_title)),
              body: content(context, settingsChanged),
              floatingActionButton: settingsChanged ? FloatingActionButton(
                onPressed: () => saveData(context),
                child: const Icon(Icons.check),
              ) : null
            ),
          );
        },
      ),
    );
  }

  Widget content(BuildContext context, bool settingsChanged) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
            builder: (context, state) {
              return profileVisibilitySetting(context, state.currentVisibility);
            }
          ),
          blockedProfiles(),
          securitySelfie(),
          if (settingsChanged) const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget blockedProfiles() {
    return Setting.createSetting(Icons.block, context.strings.blocked_profiles_screen_title, () =>
      MyNavigator.push(context, const MaterialPage<void>(child: BlockedProfilesScreen()))
    ).toListTile();
  }

  Widget securitySelfie() {
    return Setting.createSetting(Icons.image_rounded, context.strings.current_security_selfie_screen_title, () =>
      MyNavigator.push(context, const MaterialPage<void>(child: CurrentSecuritySelfie()))
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
