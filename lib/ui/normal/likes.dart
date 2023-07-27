import 'package:flutter/material.dart';
import 'package:pihka_frontend/ui/utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LikeView extends BottomNavigationView {
  const LikeView({Key? key}) : super(key: key);

  @override
  _LikeViewState createState() => _LikeViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageLikesTitle;
  }
}

class _LikeViewState extends State<LikeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Likes"),
    );
  }
}
