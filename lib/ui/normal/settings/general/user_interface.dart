

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/settings/user_interface.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
import 'package:pihka_frontend/model/freezed/logic/settings/user_interface.dart';

Future<void> openUserInterfaceSettingsScreen(
  BuildContext context,
) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(
      child: BlocProvider(
        create: (_) => UserInterfaceSettingsBloc(),
        lazy: false,
        child: const UserInterfaceSettingsScreen(),
      ),
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
