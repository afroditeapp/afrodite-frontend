import 'package:flutter/material.dart';
import 'package:pihka_frontend/ui/utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends BottomNavigationView {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageProfileGridTitle;
  }
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello world',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      );
  }
}
