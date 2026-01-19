import 'dart:async';

import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openEditProfileText(BuildContext context, MyProfileBloc bloc) {
  return MyNavigator.pushLimited(context, EditProfileTextPage(bloc));
}

class EditProfileTextPage extends MyScreenPageLimited<()> {
  EditProfileTextPage(MyProfileBloc bloc)
    : super(builder: (_) => EditProfileTextScreen(bloc: bloc));
}

class EditProfileTextScreen extends StatefulWidget {
  final MyProfileBloc bloc;
  const EditProfileTextScreen({required this.bloc, super.key});

  @override
  State<EditProfileTextScreen> createState() => EditProfileTextScreenState();
}

class EditProfileTextScreenState extends State<EditProfileTextScreen> {
  final TextEditingController _profileTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileTextController.text = widget.bloc.state.valueProfileText() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, state) {
        final profileText = state.valueProfileText() ?? "";
        final byteLengthOk = profileText.length <= 2000;
        return PopScope(
          canPop: byteLengthOk,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              showSnackBar(context.strings.edit_profile_text_screen_text_length_too_long);
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(title: Text(context.strings.edit_profile_screen_profile_text)),
              body: content(context),
            ),
          ),
        );
      },
    );
  }

  Widget content(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(8.0), child: editProfileText(context)),
    );
  }

  Widget editProfileText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _profileTextController,
        minLines: 3,
        maxLines: null,
        maxLength: 400,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: context.strings.edit_profile_screen_profile_text,
        ),
        onChanged: (value) {
          context.read<MyProfileBloc>().add(NewProfileText(value.trim()));
        },
      ),
    );
  }

  @override
  void dispose() {
    _profileTextController.dispose();
    super.dispose();
  }
}
