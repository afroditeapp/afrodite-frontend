

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/normal/settings/admin/moderate_images.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';


class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My profile")),
      body: myProfilePage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const EditProfilePage()),),
        tooltip: 'Edit profile',
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget myProfilePage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileData>(
      builder: (context, state) {
        List<Setting> hello = [];

        return Text("Hello");
      }
    );
  }
}
