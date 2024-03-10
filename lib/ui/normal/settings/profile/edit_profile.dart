

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/utils.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _profileTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // TODO: Update ProfileUpdate to have proper values
        context.read<ProfileBloc>().add(SetProfile(ProfileUpdate(
          profileText: _profileTextController.text,
          age: 18,
          name: "name",
        )));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit proifle")),
        body: BlocBuilder<ProfileBloc, ProfileData>(
          builder: (context, state) {
            _profileTextController.text = state.profile?.profileText ?? "";

            return edit(context);
          },
        ),
      ),
    );
  }

  Widget edit(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _profileTextController,
            maxLines: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Profile text",
            ),
          ),
        ),
      ],
    );
  }
}
