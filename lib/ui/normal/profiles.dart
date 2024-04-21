
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/model/freezed/logic/account/account.dart';
import 'package:pihka_frontend/model/freezed/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/profile_grid.dart';
import 'package:pihka_frontend/ui/normal/settings/media/current_moderation_request.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/list.dart';

var log = Logger("ProfileView");

// TODO(prod): Make sure that after initial moderation the profile grid
// is refreshed automatically.

class ProfileView extends BottomNavigationScreen {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return context.strings.profile_grid_screen_title;
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      IconButton(
        icon: BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
          builder: (context, state) {
            if (state.isSomeFilterEnabled()) {
              return const Icon(Icons.filter_alt_rounded);
            } else {
              return const Icon(Icons.filter_alt_outlined);
            }
          },
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ProfileFilteringSettingsPage()));
        },
      )
    ];
  }
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, data) {
        if (data.visibility == ProfileVisibility.public) {
          return const ProfileGrid();
        } else if (data.visibility == ProfileVisibility.pendingPublic) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<CurrentModerationRequestBloc>().add(Reload());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: profileIsInModerationInfo(context),
                ),
              );
            }
          );
        } else {
          return profileIsSetToPrivateInfo(context);
        }
      }
    );
  }

  Widget profileIsSetToPrivateInfo(BuildContext context) {
    return buildListReplacementMessage(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Icon(Icons.public_off_rounded, size: 48),
          const Padding(padding: EdgeInsets.all(16)),
          Text(context.strings.profile_grid_screen_profile_is_private_info),
        ],
      )
    );
  }

  Widget profileIsInModerationInfo(BuildContext context) {
    return buildListReplacementMessage(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(padding: EdgeInsets.all(16)),
          const Icon(Icons.hourglass_top_rounded, size: 48),
          const Padding(padding: EdgeInsets.all(16)),
          Text(context.strings.profile_grid_screen_initial_moderation_ongoing),
          const Padding(padding: EdgeInsets.all(16)),
          ShowModerationQueueProgress(bloc: context.read<CurrentModerationRequestBloc>()),
        ],
      ),
    );
  }
}


class ShowModerationQueueProgress extends StatefulWidget {
  final CurrentModerationRequestBloc bloc;
  const ShowModerationQueueProgress({required this.bloc, super.key});

  @override
  State<ShowModerationQueueProgress> createState() => _ShowModerationQueueProgressState();
}

class _ShowModerationQueueProgressState extends State<ShowModerationQueueProgress> {

  ModerationRequest? cachedCurrentRequest;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(ReloadOnceConnected());
  }

  @override
  Widget build(BuildContext context) {
    return blocWidgetForProcessingState();
  }

  Widget blocWidgetForProcessingState() {
    return BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
      builder: (context, state) {
        final newRequest = state.moderationRequest;
        final previousRequest = cachedCurrentRequest;
        if (newRequest == null) {
          if (state.isError) {
            return Text(context.strings.generic_error);
          } else if (state.isLoading && previousRequest != null) {
            return widgetForProcessingState(context, previousRequest);
          } else {
            return const Text("");
          }
        } else {
          cachedCurrentRequest = newRequest;
          return widgetForProcessingState(context, newRequest);
        }
      },
    );
  }

  Widget widgetForProcessingState(BuildContext context, ModerationRequest request) {
    if (request.state == ModerationRequestState.waiting) {
      final number = request.waitingPosition ?? 0;
      return Text(context.strings.profile_grid_screen_initial_moderation_waiting(number.toString()));
    } else if (request.state == ModerationRequestState.inProgress) {
      return Text(context.strings.profile_grid_screen_initial_moderation_in_progress);
    } else if (request.state == ModerationRequestState.rejected) {
      return Column(
        children: [
          Text(context.strings.profile_grid_screen_initial_moderation_rejected),
          const Padding(padding: EdgeInsets.all(8)),
          retryModerationRequestButton(context),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
