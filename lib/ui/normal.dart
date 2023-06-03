import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/account.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/normal/chat.dart";
import "package:pihka_frontend/ui/normal/likes.dart";
import "package:pihka_frontend/ui/normal/profiles.dart";
import "package:pihka_frontend/ui/normal/settings.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";

class NormalStatePage extends RootPage {
  const NormalStatePage({Key? key}) : super(MainState.initialSetupComplete, key: key);

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
    var widgets = const [
      ProfileView(),
      LikeView(),
      ChatView(),
      SettingsView(),
    ];
    var titles = const [
      "Profiles",
      "Likes",
      "Chats",
      "Settings"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedView]),
      ),
      body: widgets[selectedView],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Profiles"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Likes"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AccountBloc>().add(DoLogout()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
