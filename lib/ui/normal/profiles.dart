
import 'package:app/logic/media/content.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/initial_setup.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/api.dart';
import 'package:app/utils/list.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/account/account.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/profile/profile_filtering_settings.dart';
import 'package:app/model/freezed/logic/account/account.dart';
import 'package:app/model/freezed/logic/profile/profile_filtering_settings.dart';
import 'package:app/ui/normal/profiles/filter_profiles.dart';
import 'package:app/ui/normal/profiles/profile_grid.dart';
import 'package:app/ui_utils/bottom_navigation.dart';

import 'package:app/localizations.dart';
import 'package:app/ui_utils/list.dart';

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
          builder: (_, state) => Icon(state.icon()),
        ),
        onPressed: () => openProfileFilteringSettings(context),
      )
    ];
  }
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountBlocData>(
      builder: (context, data) {
        if (data.accountState == AccountState.initialSetup) {
          return startInitialSetupButton(context);
        } else if (data.visibility == ProfileVisibility.public) {
          return BlocBuilder<ContentBloc, ContentData>(
            builder: (context, contentState) {
              if (contentState.isLoadingSecurityContent || contentState.isLoadingPrimaryContent) {
                return const SizedBox.shrink();
              }

              final securityContent = contentState.securityContent;
              if (securityContent?.accepted == true && securityContent?.faceDetected == true) {
                return BlocBuilder<MyProfileBloc, MyProfileData>(
                  builder: (context, myProfileState) {
                    final primaryContent = myProfileState.profile?.myContent.getAtOrNull(0);
                    if (primaryContent?.accepted == true) {
                      return ProfileGrid(
                        filteringSettingsBloc: context.read<ProfileFilteringSettingsBloc>(),
                      );
                    } else {
                      return primaryProfileContentIsNotAccepted(context, primaryContent);
                    }
                  },
                );
              } else {
                return securityContentIsNotAccepted(context, securityContent);
              }
            },
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

  Widget primaryProfileContentIsNotAccepted(BuildContext context, MyContent? content) {
    String message;
    if (content == null) {
      message = context.strings.profile_grid_screen_primary_profile_content_does_not_exist;
    } else if (!content.faceDetected) {
      message = context.strings.profile_grid_screen_primary_profile_content_face_not_detected;
    } else if (!content.accepted) {
      String infoText = context.strings.profile_grid_screen_primary_profile_content_is_not_accepted;
      infoText = addModerationStateRow(context, infoText, content.state.toUiString(context));
      infoText = addRejectedCategoryRow(context, infoText, content.rejectedCategory?.value);
      infoText = addRejectedDetailsRow(context, infoText, content.rejectedDetails?.value);
      message = infoText;
    } else {
      message = context.strings.generic_error;
    }

    return buildListReplacementMessageSimple(context, message);
  }

  Widget securityContentIsNotAccepted(BuildContext context, MyContent? content) {
    String message;
    if (content == null) {
      message = context.strings.profile_grid_screen_security_content_does_not_exist;
    } else if (!content.accepted) {
      String infoText = context.strings.profile_grid_screen_security_content_is_not_accepted;
      infoText = addModerationStateRow(context, infoText, content.state.toUiString(context));
      infoText = addRejectedCategoryRow(context, infoText, content.rejectedCategory?.value);
      infoText = addRejectedDetailsRow(context, infoText, content.rejectedDetails?.value);
      message = infoText;
    } else {
      message = context.strings.generic_error;
    }

    return buildListReplacementMessageSimple(context, message);
  }

  Widget startInitialSetupButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
           MyNavigator.push(
            context,
            const MaterialPage<void>(
              child: InitialSetupScreen(),
            ),
          );
        },
        child: Text(context.strings.profile_grid_screen_start_initial_setup_button),
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
