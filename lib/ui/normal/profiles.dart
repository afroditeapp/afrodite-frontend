
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/profile_database.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/current_moderation_request.dart';
import 'package:pihka_frontend/logic/profile/profile_filtering_settings/profile_filtering_settings.dart';
import 'package:pihka_frontend/ui/normal/profiles/filter_profiles.dart';
import 'package:pihka_frontend/ui/normal/profiles/profile_grid.dart';
import 'package:pihka_frontend/ui_utils/bottom_navigation.dart';

import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';

var log = Logger("ProfileView");

class ProfileView extends BottomNavigationScreen {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();

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
            if (state == ProfileFilteringSettingsData()) {
              return const Icon(Icons.filter_alt_outlined);
            } else {
              return const Icon(Icons.filter_alt_rounded);
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

typedef ProfileViewEntry = (ProfileEntry profile, XFile img, int heroNumber);

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
  }

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
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: profileIsInModerationInfo(context),
                  ),
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
    return Align(
      alignment: FractionalOffset(0.0, 0.25),
      child: Padding(
        padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.all(16)),
            Icon(Icons.public_off_rounded, size: 48),
            Padding(padding: EdgeInsets.all(16)),
            Text(context.strings.profile_grid_screen_profile_is_private_info),
          ],
        ),
      ),
    );
  }

  Widget profileIsInModerationInfo(BuildContext context) {
    return Align(
      alignment: FractionalOffset(0.0, 0.25),
      child: Padding(
        padding: const EdgeInsets.all(COMMON_SCREEN_EDGE_PADDING),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: EdgeInsets.all(16)),
            Icon(Icons.hourglass_top_rounded, size: 48),
            Padding(padding: EdgeInsets.all(16)),
            Text(context.strings.profile_grid_screen_initial_moderation_ongoing),
            Padding(padding: EdgeInsets.all(16)),
            ShowModerationQueueProgress(),
          ],
        ),
      ),
    );
  }
}


class ShowModerationQueueProgress extends StatefulWidget {
  const ShowModerationQueueProgress({super.key});

  @override
  State<ShowModerationQueueProgress> createState() => _ShowModerationQueueProgressState();
}

class _ShowModerationQueueProgressState extends State<ShowModerationQueueProgress> {
  @override
  Widget build(BuildContext context) {
    return blocWidgetForProcessingState();
  }

  Widget blocWidgetForProcessingState() {
    return BlocBuilder<CurrentModerationRequestBloc, CurrentModerationRequestData>(
      builder: (context, state) {
        final s = state.moderationRequest;
        if (s == null) {
          return const SizedBox.shrink();
        } else {
          return widgetForProcessingState(context, s);
        }
      },
    );
  }

  Widget widgetForProcessingState(BuildContext context, ModerationRequest request) {
    if (request.state == ModerationRequestState.waiting) {
      // TODO: moderation queue number
      return Text(context.strings.profile_grid_screen_initial_moderation_waiting("0"));
    } else if (request.state == ModerationRequestState.inProgress) {
      return Text(context.strings.profile_grid_screen_initial_moderation_in_progress);
    } else if (request.state == ModerationRequestState.denied) {
      return Text(context.strings.profile_grid_screen_initial_moderation_denied);
    } else {
      return const SizedBox.shrink();
    }
  }
}
