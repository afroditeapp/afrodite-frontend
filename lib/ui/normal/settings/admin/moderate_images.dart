

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


// Plan: Infinite list of rows of two images, first is security selfie, the
// other is to be moderated image. First image is empty if moderating security
// selfie.
//
// Long pressing the row opens option to discard the request. Maeby there should
// be space in the right side for status color.
//
// If trying to display previous rows, maeby just display empty rows? After it
// is not possible to load more entries then empty rows untill all moderated.
// Change entry to contain message all moderated.
//
// Taping image should open it to another view.


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
      itemCount: null,
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
