

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/blocked_profiles.dart';


class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  ProfileVisibility _tmpProfileVisiblity = ProfileVisibility.pendingPrivate;

  @override
  void initState() {
    super.initState();
    _tmpProfileVisiblity = context.read<AccountBloc>().state.visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.privacy_settings_screen_title)),
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        profileVisibilitySetting(context),
        blockedProfiles(),
      ],
    );
  }

  Widget blockedProfiles() {
    return Setting.createSetting(Icons.block, context.strings.blocked_profiles_screen_title, () =>
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const BlockedProfilesScreen()))
    ).toListTile();
  }

  Widget profileVisibilitySetting(BuildContext context) {
    final bool visibilityEnabled = _tmpProfileVisiblity == ProfileVisibility.pendingPublic || _tmpProfileVisiblity == ProfileVisibility.public;
    final String descriptionForVisibility = switch (_tmpProfileVisiblity) {
      ProfileVisibility.pendingPrivate || ProfileVisibility.private =>
        context.strings.privacy_settings_screen_profile_visiblity_private_description,
      ProfileVisibility.pendingPublic =>
        context.strings.privacy_settings_screen_profile_visiblity_pending_public_description,
      ProfileVisibility.public =>
        context.strings.privacy_settings_screen_profile_visiblity_public_description,
      _ => context.strings.generic_error,
    };

    return BlocListener<AccountBloc, AccountBlocData>(
      listener: (context, state) {
        if (_tmpProfileVisiblity != state.visibility) {
          setState(() {
            _tmpProfileVisiblity = state.visibility;
          });
        }
      },
      child: SwitchListTile(
        title: Text(context.strings.privacy_settings_screen_profile_visiblity_setting),
        value: visibilityEnabled,
        subtitle: Text(descriptionForVisibility),
        onChanged: (bool value) {
          context.read<AccountBloc>().add(DoProfileVisiblityChange(value));
          setState(() {
            _updateTmpVisibilityToMakeUiLookResponsive(value);
          });
        },
        secondary: const Icon(Icons.public),
      ),
    );
  }

  void _updateTmpVisibilityToMakeUiLookResponsive(bool value) {
    // Update from server will override this update.

    if (value) {
      if (_tmpProfileVisiblity == ProfileVisibility.pendingPrivate) {
        _tmpProfileVisiblity = ProfileVisibility.pendingPublic;
      } else if (_tmpProfileVisiblity == ProfileVisibility.private) {
        _tmpProfileVisiblity = ProfileVisibility.public;
      }
    } else {
      if (_tmpProfileVisiblity == ProfileVisibility.pendingPublic) {
        _tmpProfileVisiblity = ProfileVisibility.pendingPrivate;
      } else if (_tmpProfileVisiblity == ProfileVisibility.public) {
        _tmpProfileVisiblity = ProfileVisibility.private;
      }
    }
  }
}
