import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/utils/root_page.dart";


class HomePageOld extends StatefulWidget {
  const HomePageOld({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePageOld> createState() => _HomePageOldState();
}

class _HomePageOldState extends State<HomePageOld> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      Navigator.of(context).pushNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}


class MyTestWidget extends StatefulWidget {
  const MyTestWidget({Key? key}) : super(key: key);

  @override
  _MyTestWidgetState createState() => _MyTestWidgetState();
}

class _MyTestWidgetState extends State<MyTestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Hellow"),
    );
  }
}

class HomePage extends RootPage {
  const HomePage({Key? key}) : super(MainState.loggedIn, key: key);

  void _incrementCounter() {

  }

  @override
  Widget buildRootWidget(BuildContext context) {
    final text = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              'You have pushed the hello world this many times: $text',
            ),
            Text(
              'Hello',
              style: Theme.of(context).textTheme.headline4,
            ),
            MyTestWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<MainStateBloc>().add(ToLoginRequiredScreen()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
