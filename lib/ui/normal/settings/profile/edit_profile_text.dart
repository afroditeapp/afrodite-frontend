import 'dart:async';

import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openEditProfileText(BuildContext context, EditMyProfileBloc bloc) {
  final pageKey = PageKey();
  return MyNavigator.pushWithKey(
    context,
    MaterialPage<void>(child: EditProfileTextScreen(bloc: bloc)),
    pageKey,
  );
}

class EditProfileTextScreen extends StatefulWidget {
  final EditMyProfileBloc bloc;
  const EditProfileTextScreen({required this.bloc, super.key});

  @override
  State<EditProfileTextScreen> createState() => EditProfileTextScreenState();
}

class EditProfileTextScreenState extends State<EditProfileTextScreen> {
  final TextEditingController _profileTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _profileTextController.text = widget.bloc.state.profileText ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(
      builder: (context, state) {
        return PopScope(
          canPop: state.profileTextByteLenghtLessOrMaxValue(),
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              showSnackBar(context.strings.edit_profile_text_screen_text_lenght_too_long);
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
          context.read<EditMyProfileBloc>().add(NewProfileText(value.trim()));
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
