import 'dart:async';

import 'package:app/ui_utils/profile_grid.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:app/data/chat/matches_iterator_manager.dart';
import 'package:app/data/login_repository.dart';
import 'package:database/database.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/localizations.dart';

final log = Logger("SelectMatchScreen");

Future<ProfileEntry?> openSelectMatchView(BuildContext context) {
  return MyNavigator.push(context, const MaterialPage<ProfileEntry>(child: SelectMatchScreen()));
}

class SelectMatchScreen extends StatelessWidget {
  const SelectMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.select_match_screen_title)),
      body: GenericProfileGrid(
        buildIteratorManager: () {
          return MatchesIteratorManager(
            LoginRepository.getInstance().repositories.chat,
            LoginRepository.getInstance().repositories.media,
            LoginRepository.getInstance().repositories.accountBackgroundDb,
            LoginRepository.getInstance().repositories.accountDb,
            LoginRepository.getInstance().repositories.connectionManager,
            LoginRepository.getInstance().repositories.chat.currentUser,
          );
        },
        noProfilesText: context.strings.chat_list_screen_no_matches_found,
      ),
    );
  }
}
