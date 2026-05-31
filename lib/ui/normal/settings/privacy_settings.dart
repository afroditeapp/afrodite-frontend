import 'package:app/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/model/freezed/logic/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings.dart';

void openPrivacySettings(BuildContext context) {
  MyNavigator.push(context, PrivacySettingsPage());
}

class PrivacySettingsPage extends MyScreenPage<()> with SimpleUrlParser<PrivacySettingsPage> {
  PrivacySettingsPage() : super(builder: (closer) => PrivacySettingsScreenOpener(closer: closer));

  @override
  PrivacySettingsPage create() => PrivacySettingsPage();
}

class PrivacySettingsScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  const PrivacySettingsScreenOpener({required this.closer, super.key});

  @override
  Widget build(BuildContext context) {
    return PrivacySettingsScreen(
      privacySettingsBloc: context.read<PrivacySettingsBloc>(),
      closer: closer,
    );
  }
}

class PrivacySettingsScreen extends StatefulWidget {
  final PrivacySettingsBloc privacySettingsBloc;
  final PageCloser<()> closer;
  const PrivacySettingsScreen({required this.privacySettingsBloc, required this.closer, super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.privacySettingsBloc.add(ResetEdited());
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<PrivacySettingsBloc, PrivacySettingsData>(
      context: context,
      pageKey: widget.closer.key,
      child: BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
        builder: (context, data) {
          final dataEditingDetected = data.unsavedChanges();

          return PopScope(
            canPop: !dataEditingDetected,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop) {
                return;
              }
              showConfirmDialog(
                context,
                context.strings.generic_save_confirmation_title,
                yesNoActions: true,
              ).then((value) {
                if (value == true && context.mounted) {
                  widget.privacySettingsBloc.add(SavePrivacySettings());
                  // updateStateHandler closes PrivacySettingsScreen
                } else if (value == false && context.mounted) {
                  widget.closer.close(context, ());
                  widget.privacySettingsBloc.add(ResetEdited());
                }
              });
            },
            child: Scaffold(
              appBar: AppBar(title: Text(context.strings.privacy_settings_screen_title)),
              body: content(context, data),
              floatingActionButton: dataEditingDetected
                  ? FloatingActionButton(
                      onPressed: () => widget.privacySettingsBloc.add(SavePrivacySettings()),
                      child: const Icon(Icons.check),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget content(BuildContext context, PrivacySettingsData state) {
    if (state.profilePrivacyLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.profilePrivacyLoadError) {
      return Center(
        child: Text(
          context.strings.generic_error_occurred,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, configData) {
        final chatConfig = configData.config.chat;
        final showMessageStateSeen = chatConfig?.messageStateSeen ?? false;
        final showTypingIndicator = chatConfig?.typingIndicator != null;
        final chatSettingsHidden = !showMessageStateSeen && !showTypingIndicator;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!chatSettingsHidden)
                settingsCategoryTitle(
                  context,
                  context.strings.privacy_settings_screen_chat_category,
                ),
              if (showMessageStateSeen) messageStateSeen(context, state),
              if (showTypingIndicator) typingIndicator(context, state),
              settingsCategoryTitle(
                context,
                context.strings.privacy_settings_screen_profile_category,
              ),
              lastSeenTime(context, state),
              onlineStatus(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget messageStateSeen(BuildContext context, PrivacySettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.privacy_settings_message_state_seen),
      value: state.valueMessageStateSeen(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleMessageStateSeen());
      },
    );
  }

  Widget typingIndicator(BuildContext context, PrivacySettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.privacy_settings_typing_indicator),
      value: state.valueTypingIndicator(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleTypingIndicator());
      },
    );
  }

  Widget lastSeenTime(BuildContext context, PrivacySettingsData state) {
    return lastSeenTimeSwitchTile(
      context: context,
      value: state.valueLastSeenTime(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleLastSeenTime());
      },
    );
  }

  Widget onlineStatus(BuildContext context, PrivacySettingsData state) {
    return onlineStatusSwitchTile(
      context: context,
      value: state.valueOnlineStatus(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleOnlineStatus());
      },
    );
  }
}

Widget profileVisibilitySwitchTile({
  required BuildContext context,
  required bool value,
  required ValueChanged<bool> onChanged,
  String? subtitle,
}) {
  return SwitchListTile(
    title: Text(context.strings.settings_screen_profile_visiblity_setting),
    subtitle: Text(
      subtitle ??
          (value
              ? context.strings.settings_screen_profile_visiblity_public_description
              : context.strings.settings_screen_profile_visiblity_private_description),
    ),
    value: value,
    secondary: const Icon(Icons.public),
    onChanged: onChanged,
  );
}

Widget lastSeenTimeSwitchTile({
  required BuildContext context,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return SwitchListTile(
    title: Text(context.strings.privacy_settings_last_seen_time),
    subtitle: Text(
      value
          ? context.strings.privacy_settings_last_seen_time_enabled_description
          : context.strings.privacy_settings_last_seen_time_disabled_description,
    ),
    value: value,
    secondary: const Icon(Icons.access_time),
    onChanged: onChanged,
  );
}

Widget onlineStatusSwitchTile({
  required BuildContext context,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return SwitchListTile(
    title: Text(context.strings.privacy_settings_online_status),
    subtitle: Text(
      value
          ? context.strings.privacy_settings_online_status_enabled_description
          : context.strings.privacy_settings_online_status_disabled_description,
    ),
    value: value,
    secondary: SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: Container(
          width: PROFILE_CURRENTLY_ONLINE_SIZE,
          height: PROFILE_CURRENTLY_ONLINE_SIZE,
          decoration: BoxDecoration(
            color: PROFILE_CURRENTLY_ONLINE_COLOR,
            borderRadius: BorderRadius.circular(PROFILE_CURRENTLY_ONLINE_RADIUS),
          ),
        ),
      ),
    ),
    onChanged: onChanged,
  );
}
