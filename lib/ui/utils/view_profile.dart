


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/profile/profile.dart';

Widget viewProifle(BuildContext context, AccountIdLight account, Profile profile) {

  final Widget imageWidget = FutureBuilder(
    future: context.read<ProfileBloc>().getProfileImage(account),
    builder: (context, snapshot) {
      final data = snapshot.data;
      if (data != null) {
        return Image.memory(data, height: 300,);
      } else if (snapshot.error != null) {
        return Text("Loading error");
      } else if (data == null) {
        return Text("No profile image or loading errror");
      } else {
        return SizedBox(width: 50, height: 50, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ));
      }
    },
  );

  return Column(
    children: [
      imageWidget,
      Text("Hello")
      ]
    );
}