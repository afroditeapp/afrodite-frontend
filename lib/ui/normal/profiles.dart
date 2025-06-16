
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/logic/media/content.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/media/content.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/initial_setup.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/snack_bar.dart';
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
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();

  @override
  String title(BuildContext context) {
    return context.strings.profile_grid_screen_title;
  }

  @override
  List<Widget>? actions(BuildContext context) {
    return [
      BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
        builder: (context, state) {
          if (!state.dailyLikesLimitEnabled()) {
            return const SizedBox.shrink();
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(padding: EdgeInsets.only(left: 8)),
              Text(
                state.valueDailyLikesLeft().toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: Icon(state.valueDailyLikesLeft() == 0 ? Icons.waving_hand_outlined : Icons.waving_hand),
                onPressed: () {
                  showInfoDialog(context, context.strings.profile_grid_screen_daily_likes_dialog_text(
                    state.valueDailyLikesLeft().toString(),
                    state.dailyLikesResetTime()?.uiString() ?? context.strings.generic_error,
                  ));
                }
              )
            ],
          );
        },
      ),
      BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
        builder: (context, state) {
          return IconButton(
            icon: Icon(state.showOnlyFavorites ? Icons.star_rounded : Icons.star_border_rounded),
            tooltip: state.showOnlyFavorites ?
              context.strings.profile_grid_screen_show_all_profiles_action :
              context.strings.profile_grid_screen_show_favorite_profiles_action,
            onPressed: () => context.read<ProfileFilteringSettingsBloc>().add(SetFavoriteProfilesFilter(!state.showOnlyFavorites)),
          );
        },
      ),
      BlocBuilder<ProfileFilteringSettingsBloc, ProfileFilteringSettingsData>(
        builder: (context, state) {
          final Icon icon;
          if (state.showOnlyFavorites) {
            icon = Icon(
              Icons.filter_alt_outlined,
              color: Theme.of(context).disabledColor,
            );
          } else {
            icon = Icon(state.icon());
          }
          return IconButton(
            icon: icon,
            onPressed: state.showOnlyFavorites ?
              () => showSnackBar(context.strings.profile_grid_screen_filtering_favorite_profiles_is_not_supported) :
              () => openProfileFilteringSettings(context),
          );
        },
      ),
    ];
  }
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return PublicProfileViewingBlocker(
      child: ProfileGrid(
        filteringSettingsBloc: context.read<ProfileFilteringSettingsBloc>(),
      ),
    );
  }
}

class PublicProfileViewingBlocker extends StatelessWidget {
  final Widget child;
  const PublicProfileViewingBlocker({required this.child, super.key});

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
                      return child;
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
