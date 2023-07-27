import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils.dart';

class ChatView extends BottomNavigationView {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).pageChatListTitle;
  }
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Chat"),
    );
  }
}
