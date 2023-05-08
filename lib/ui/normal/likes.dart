import 'package:flutter/material.dart';

class LikeView extends StatefulWidget {
  const LikeView({Key? key}) : super(key: key);

  @override
  _LikeViewState createState() => _LikeViewState();
}

class _LikeViewState extends State<LikeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Likes"),
    );
  }
}
