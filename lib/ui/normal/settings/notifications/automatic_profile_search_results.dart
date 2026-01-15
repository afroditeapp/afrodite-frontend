import 'dart:async';

import 'package:app/data/profile/automatic_profile_search/automatic_profile_search_iterator_manager.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/profile/automatic_profile_search_badge.dart';
import 'package:app/ui/normal/profiles.dart';
import 'package:app/ui_utils/profile_grid.dart';
import 'package:flutter/material.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> openAutomaticProfileSearchResultsScreen(BuildContext context) {
  return MyNavigator.push(context, AutomaticProfileSearchResultsPage());
}

class AutomaticProfileSearchResultsPage extends MyScreenPage<()>
    with SimpleUrlParser<AutomaticProfileSearchResultsPage> {
  AutomaticProfileSearchResultsPage()
    : super(builder: (_) => AutomaticProfileSearchResultsScreen());

  @override
  AutomaticProfileSearchResultsPage create() => AutomaticProfileSearchResultsPage();
}

class AutomaticProfileSearchResultsScreen extends StatefulWidget {
  const AutomaticProfileSearchResultsScreen({super.key});

  @override
  State<AutomaticProfileSearchResultsScreen> createState() =>
      AutomaticProfileSearchResultsScreenState();
}

class AutomaticProfileSearchResultsScreenState extends State<AutomaticProfileSearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final r = context.read<RepositoryInstances>();

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.automatic_profile_search_results_screen_title)),
      body: PublicProfileViewingBlocker(child: _buildProfileGrid(context, r)),
    );
  }

  Widget _buildProfileGrid(BuildContext context, RepositoryInstances r) {
    return Column(
      children: [
        BlocBuilder<AutomaticProfileSearchBadgeBloc, AutomaticProfileSearchBadgeData>(
          builder: (context, badgeState) {
            if (badgeState.badgeState.showBadge) {
              context.read<AutomaticProfileSearchBadgeBloc>().add(HideBadge());
            }
            return const SizedBox.shrink();
          },
        ),
        Expanded(
          child: GenericProfileGrid(
            r,
            buildIteratorManager: () {
              return AutomaticProfileSearchIteratorManager(
                r.chat,
                r.media,
                r.accountBackgroundDb,
                r.accountDb,
                r.connectionManager,
                r.chat.currentUser,
              );
            },
            noProfilesText:
                context.strings.automatic_profile_search_results_screen_no_profiles_found_title,
            noProfilesTextDescription: context
                .strings
                .automatic_profile_search_results_screen_no_profiles_found_description,
          ),
        ),
      ],
    );
  }
}
