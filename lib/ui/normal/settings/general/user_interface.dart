

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/user_interface.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/user_interface.dart';

Future<void> openUserInterfaceSettingsScreen(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    const MaterialPage<void>(
      child: UserInterfaceSettingsScreen(),
    ),
    pageKey,
  );
}


class UserInterfaceSettingsScreen extends StatefulWidget {
  const UserInterfaceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInterfaceSettingsScreen> createState() => _UserInterfaceSettingsScreenState();
}

class _UserInterfaceSettingsScreenState extends State<UserInterfaceSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.user_interface_settings_screen_title),
      ),
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return BlocBuilder<UserInterfaceSettingsBloc, UserInterfaceSettingsData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showNonAcceptedProfileNamesCheckbox(
              context,
              state.showNonAcceptedProfileNames
            ),
          ],
        );
      }
    );
  }

  Widget showNonAcceptedProfileNamesCheckbox(BuildContext context, bool value) {
    return CheckboxListTile(
      title: Text(context.strings.user_interface_settings_screen_show_non_accepted_profile_names),
      value: value,
      onChanged: (value) {
        context.read<UserInterfaceSettingsBloc>().add(
          UpdateShowNonAcceptedProfileNames(value ?? false)
        );
      },
    );
  }
}
