import 'dart:async';

import 'package:app/data/profile/automatic_profile_search/automatic_profile_search_iterator_manager.dart';
import 'package:app/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/profiles.dart';
import 'package:app/ui_utils/profile_grid.dart';
import 'package:flutter/material.dart';
import 'package:app/data/login_repository.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openAutomaticProfileSearchResultsScreen(BuildContext context) {
  return MyNavigator.push(
    context,
    const MaterialPage<void>(child: AutomaticProfileSearchResultsScreen()),
    pageInfo: const AutomaticProfileSearchResultsPageInfo(),
  );
}

NewPageDetails newAutomaticProfileSearchResultsScreen() {
  return NewPageDetails(
    const MaterialPage<void>(child: AutomaticProfileSearchResultsScreen()),
    pageInfo: const AutomaticProfileSearchResultsPageInfo(),
  );
}

class AutomaticProfileSearchResultsScreen extends StatefulWidget {
  const AutomaticProfileSearchResultsScreen({super.key});

  @override
  State<AutomaticProfileSearchResultsScreen> createState() =>
      AutomaticProfileSearchResultsScreenState();
}

class AutomaticProfileSearchResultsScreenState extends State<AutomaticProfileSearchResultsScreen> {
  bool hideBadgeEventSent = false;

  @override
  Widget build(BuildContext context) {
    if (!hideBadgeEventSent) {
      hideBadgeEventSent = true;
      context.read<AutomaticProfileSearchBadgeBloc>().add(HideBadge());
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.automatic_profile_search_results_screen_title)),
      body: PublicProfileViewingBlocker(
        child: GenericProfileGrid(
          buildIteratorManager: () {
            return AutomaticProfileSearchIteratorManager(
              LoginRepository.getInstance().repositories.chat,
              LoginRepository.getInstance().repositories.media,
              LoginRepository.getInstance().repositories.accountBackgroundDb,
              LoginRepository.getInstance().repositories.accountDb,
              LoginRepository.getInstance().repositories.connectionManager,
              LoginRepository.getInstance().repositories.chat.currentUser,
            );
          },
          noProfilesText: context.strings.automatic_profile_search_results_screen_no_profiles_found,
        ),
      ),
    );
  }
}
