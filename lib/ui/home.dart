import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final text = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            MyTestWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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
