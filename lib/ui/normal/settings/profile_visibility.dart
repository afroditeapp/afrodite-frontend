

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/api/api_manager.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfileVisibilityPage extends StatefulWidget {
  const ProfileVisibilityPage({super.key});

  @override
  _ProfileVisibilityPageState createState() => _ProfileVisibilityPageState();
}

class _ProfileVisibilityPageState extends State<ProfileVisibilityPage> {
  ProfileVisibility _tmpProfileVisiblity = ProfileVisibility.pendingPrivate;

  @override
  void initState() {
    super.initState();
    _tmpProfileVisiblity = context.read<AccountBloc>().state.visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile visibility")),
      body: visibilitySettingsPage(context),
    );
  }

  Widget visibilitySettingsPage(BuildContext context) {
    final bool visibilityEnabled = _tmpProfileVisiblity == ProfileVisibility.pendingPublic || _tmpProfileVisiblity == ProfileVisibility.public;
    final String descriptionForVisibility = switch (_tmpProfileVisiblity) {
      ProfileVisibility.pendingPrivate || ProfileVisibility.private =>
        "Your profile is currently private. No one can see it.",
      ProfileVisibility.pendingPublic =>
        "Your profile will be set to public after your images are moderated as accepted.",
      ProfileVisibility.public =>
        "Your profile is public. Everyone can see it.",
      _ => "",
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
        title: Text("Public profile"),
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
