import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/common_update_logic.dart';
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          settingsCategoryTitle(context, context.strings.privacy_settings_screen_chat_category),
          messageStateDelivered(context, state),
          messageStateSent(context, state),
          typingIndicator(context, state),
        ],
      ),
    );
  }

  Widget messageStateDelivered(BuildContext context, PrivacySettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.privacy_settings_message_state_delivered),
      value: state.valueMessageStateDelivered(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleMessageStateDelivered());
      },
    );
  }

  Widget messageStateSent(BuildContext context, PrivacySettingsData state) {
    return SwitchListTile(
      title: Text(context.strings.privacy_settings_message_state_sent),
      value: state.valueMessageStateSent(),
      onChanged: (value) {
        context.read<PrivacySettingsBloc>().add(ToggleMessageStateSent());
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
}
