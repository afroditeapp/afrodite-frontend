

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
  bool _tmpProfileVisiblity = false;

  @override
  void initState() {
    super.initState();
    _tmpProfileVisiblity = context.read<AccountBloc>().state.capabilities.userViewPublicProfiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile visibility")),
      body: visibilitySettingsPage(context),
    );
  }

  Widget visibilitySettingsPage(BuildContext context) {
    return BlocListener<AccountBloc, AccountBlocData>(
      listener: (context, state) {
        if (_tmpProfileVisiblity != state.capabilities.userViewPublicProfiles) {
          setState(() {
            _tmpProfileVisiblity = state.capabilities.userViewPublicProfiles;
          });
        }
      },
      child: SwitchListTile(
        title: Text("Public profile"),
        value: _tmpProfileVisiblity,
        onChanged: (bool value) {
          context.read<AccountBloc>().add(DoProfileVisiblityChange(value));
          setState(() {
            _tmpProfileVisiblity = value;
          });
        },
        secondary: const Icon(Icons.public),
      ),
    );
  }
}
