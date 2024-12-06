
import 'package:app/logic/media/content.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/initial_content_moderation.dart';
import 'package:app/logic/profile/edit_profile_filtering_settings.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/initial_content_moderation.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/filter_profiles.dart';
import 'package:app/ui/normal/profiles/profile_grid.dart';
import 'package:app/ui/normal/settings/media/current_moderation_request.dart';
import 'package:app/ui_utils/bottom_navigation.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/list.dart';
import 'package:app/ui_utils/snack_bar.dart';

var log = Logger("ProfileView");

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
          final filteringSettingsBloc = context.read<ProfileFilteringSettingsBloc>();
          if (filteringSettingsBloc.state.updateState is! UpdateIdle) {
            showSnackBar(context.strings.profile_grid_screen_profile_filter_settings_update_ongoing);
            return;
          }

          final editFilteringSettingsBloc = context.read<EditProfileFilteringSettingsBloc>();
          final pageKey = PageKey();
          MyNavigator.pushWithKey(
            context,
            MaterialPage<void>(child: ProfileFilteringSettingsPage(
              pageKey: pageKey,
              profileFilteringSettingsBloc: filteringSettingsBloc,
              editProfileFilteringSettingsBloc: editFilteringSettingsBloc,
            )),
            pageKey,
          );
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
          return ProfileGrid(
            filteringSettingsBloc: context.read<ProfileFilteringSettingsBloc>(),
          );
        } else if (data.visibility == ProfileVisibility.pendingPublic) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: profileIsInModerationInfo(context),
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
          const ShowModerationQueueProgress(),
        ],
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
    return BlocBuilder<ContentBloc, ContentData>(
      builder: (context, state) {
        // TODO(prod): List all rejected images
        // TODO(prod): Show button to take new security selfie if needed
        // TODO(prod): Show button to edit profile pictures if needed
        return const Text("");
      },
    );
  }

  Widget widgetForAcceptedValue(BuildContext context, bool accepted) {
    if (accepted) {
      return Text(context.strings.profile_grid_screen_initial_moderation_in_progress);
    } else {
      return const SizedBox.shrink();
    }

    // TODO: Remove?
    // } else if (request.state == ModerationRequestState.rejected) {
    //   return Column(
    //     children: [
    //       Text(context.strings.profile_grid_screen_initial_moderation_rejected),
    //       const Padding(padding: EdgeInsets.all(8)),
    //       retryModerationRequestButton(context),
    //     ],
    //   );
    // } else {
  }
}
