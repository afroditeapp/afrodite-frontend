import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/chat.dart';
import 'package:app/localizations.dart';
import 'package:app/ui/normal/chat/chat_data_outdated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationListPage extends MyScreenPage<()> with SimpleUrlParser<ConversationListPage> {
  ConversationListPage() : super(builder: (_) => ConversationListPageScreen());

  @override
  ConversationListPage create() => ConversationListPage();
}

class ConversationListPageScreen extends StatelessWidget {
  const ConversationListPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.chat_list_screen_title)),
      body: ChatViewingBlocker(
        child: ConversationList(profile: r.profile, chat: r.chat),
      ),
    );
  }
}
