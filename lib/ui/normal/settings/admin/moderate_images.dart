

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


class ModerateImagesPage extends StatefulWidget {
  const ModerateImagesPage({Key? key}) : super(key: key);

  @override
  _ModerateImagesPageState createState() => _ModerateImagesPageState();
}

class _ModerateImagesPageState extends State<ModerateImagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moderate images")),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          onLongPress: () {
            showSnackBar(context, "List test $index");
          },
          title: Row( children: [
            Text("Hello $index"),
            ElevatedButton(child: Text("test"), onPressed: () {
              showSnackBar(context, "Button test $index");
            },)
          ]),
        );
      },
    );
  }
}
