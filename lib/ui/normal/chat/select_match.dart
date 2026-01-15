import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/profile_grid.dart';
import 'package:flutter/material.dart';
import 'package:app/data/chat/matches_iterator_manager.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openSelectMatchView(BuildContext context) {
  return MyNavigator.push(context, SelectMatchPage());
}

class SelectMatchPage extends MyScreenPage<()> with SimpleUrlParser<SelectMatchPage> {
  SelectMatchPage() : super(builder: (_) => SelectMatchScreen());

  @override
  SelectMatchPage create() => SelectMatchPage();
}

class SelectMatchScreen extends StatelessWidget {
  const SelectMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.read<RepositoryInstances>();
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.select_match_screen_title)),
      body: GenericProfileGrid(
        r,
        buildIteratorManager: () {
          return MatchesIteratorManager(
            r.chat,
            r.media,
            r.accountDb,
            r.connectionManager,
            r.chat.currentUser,
          );
        },
        noProfilesText: context.strings.chat_list_screen_no_matches_found,
      ),
    );
  }
}
