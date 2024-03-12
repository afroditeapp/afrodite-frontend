import 'package:flutter/material.dart';

import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/normal/chat.dart";
import "package:pihka_frontend/ui/normal/likes.dart";
import "package:pihka_frontend/ui/normal/profiles.dart";
import "package:pihka_frontend/ui/normal/settings.dart";
import "package:pihka_frontend/ui_utils/root_screen.dart";

class NormalStateScreen extends RootScreen {
  const NormalStateScreen({Key? key}) : super(key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return const NormalStateContent();
  }
}

class NormalStateContent extends StatefulWidget {
  const NormalStateContent({Key? key}) : super(key: key);

  @override
  State<NormalStateContent> createState() => _NormalStateContentState();
}

class _NormalStateContentState extends State<NormalStateContent> {
  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    var views = const [
      ProfileView(),
      LikeView(),
      ChatView(),
      SettingsView(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(views[selectedView].title(context)),
        actions: views[selectedView].actions(context),
      ),
      body: views[selectedView],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.account_box), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.favorite), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.message), label: views[selectedView].title(context)),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: views[selectedView].title(context)),
        ],
        selectedItemColor: Colors.lightBlue[900],
        unselectedItemColor: Colors.black54,
        currentIndex: selectedView,
        onTap: (value) {
          setState(() {
            selectedView = value;
          });
        },
      ),
    );
  }
}
