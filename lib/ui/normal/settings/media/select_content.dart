

import 'package:flutter/material.dart';

/// Returns [AccountImageId?]
class SelectContentPage extends StatefulWidget {
  const SelectContentPage({Key? key}) : super(key: key);

  @override
  State<SelectContentPage> createState() => _SelectContentPageState();
}

class _SelectContentPageState extends State<SelectContentPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select content')),
      body: selectContentPage(context),
    );
  }

  Widget selectContentPage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Select content'),
        ],
      ),
    );
  }
}
