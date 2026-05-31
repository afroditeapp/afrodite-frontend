import "package:app/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui/initial_setup/navigation.dart";
import "package:app/ui/normal/settings/privacy_settings.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";

class ProfilePrivacySetupPage extends InitialSetupPageBase
    with SimpleUrlParser<ProfilePrivacySetupPage> {
  ProfilePrivacySetupPage() : super(builder: (_) => const ProfilePrivacySetupScreen());

  @override
  String get nameForDb => 'profile_privacy_settings';

  @override
  ProfilePrivacySetupPage create() => ProfilePrivacySetupPage();
}

class ProfilePrivacySetupScreen extends StatelessWidget {
  const ProfilePrivacySetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialSetupLoadingGuard(child: _ProfilePrivacySetupScreenInternal());
  }
}

class _ProfilePrivacySetupScreenInternal extends StatelessWidget {
  const _ProfilePrivacySetupScreenInternal();

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        continueButtonBuilder: (context) {
          return ElevatedButton(
            onPressed: () {
              navigateToNextInitialSetupPage(context);
            },
            child: Text(context.strings.generic_continue),
          );
        },
        question: const _ProfilePrivacySettingsContent(),
        expandQuestion: true,
      ),
    );
  }
}

class _ProfilePrivacySettingsContent extends StatelessWidget {
  const _ProfilePrivacySettingsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              questionTitleText(
                context,
                context.strings.initial_setup_screen_profile_privacy_settings_title,
              ),
              const SizedBox(height: 8),
              profileVisibilitySwitchTile(
                context: context,
                value: state.profileVisibilityEnabled,
                onChanged: (value) {
                  context.read<InitialSetupBloc>().add(SetProfileVisibility(value));
                },
              ),
              lastSeenTimeSwitchTile(
                context: context,
                value: state.profileLastSeenTimeEnabled,
                onChanged: (value) {
                  context.read<InitialSetupBloc>().add(SetProfileLastSeenTime(value));
                },
              ),
              onlineStatusSwitchTile(
                context: context,
                value: state.profileOnlineStatusEnabled,
                onChanged: (value) {
                  context.read<InitialSetupBloc>().add(SetProfileOnlineStatus(value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
