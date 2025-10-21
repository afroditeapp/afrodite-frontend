import 'package:app/data/general/notification/utils/notification_category.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/app/email_notification_settings.dart';
import 'package:app/model/freezed/logic/settings/email_notification_settings.dart';

void openEmailNotificationSettings(BuildContext context) {
  MyNavigator.push(context, EmailNotificationSettingsPage());
}

class EmailNotificationSettingsPage extends MyScreenPage<()>
    with SimpleUrlParser<EmailNotificationSettingsPage> {
  EmailNotificationSettingsPage()
    : super(builder: (closer) => EmailNotificationSettingsScreenOpener(closer: closer));

  @override
  EmailNotificationSettingsPage create() => EmailNotificationSettingsPage();
}

class EmailNotificationSettingsScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  const EmailNotificationSettingsScreenOpener({required this.closer, super.key});

  @override
  Widget build(BuildContext context) {
    return EmailNotificationSettingsScreen(
      emailNotificationSettingsBloc: context.read<EmailNotificationSettingsBloc>(),
      closer: closer,
    );
  }
}

class EmailNotificationSettingsScreen extends StatefulWidget {
  final EmailNotificationSettingsBloc emailNotificationSettingsBloc;
  final PageCloser<()> closer;
  const EmailNotificationSettingsScreen({
    required this.emailNotificationSettingsBloc,
    required this.closer,
    super.key,
  });

  @override
  State<EmailNotificationSettingsScreen> createState() => _EmailNotificationSettingsScreenState();
}

class _EmailNotificationSettingsScreenState extends State<EmailNotificationSettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.emailNotificationSettingsBloc.add(ReloadEmailNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<EmailNotificationSettingsBloc, EmailNotificationSettingsData>(
      context: context,
      pageKey: widget.closer.key,
      child: BlocBuilder<EmailNotificationSettingsBloc, EmailNotificationSettingsData>(
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
                  widget.emailNotificationSettingsBloc.add(SaveEmailSettings());
                  // updateStateHandler closes EmailNotificationSettingsScreen
                } else if (value == false && context.mounted) {
                  widget.closer.close(context, ());
                  widget.emailNotificationSettingsBloc.add(ResetEditedEmailValues());
                }
              });
            },
            child: Scaffold(
              appBar: AppBar(title: Text(context.strings.email_notification_settings_screen_title)),
              body: content(context, data),
              floatingActionButton: dataEditingDetected
                  ? FloatingActionButton(
                      onPressed: () =>
                          widget.emailNotificationSettingsBloc.add(SaveEmailSettings()),
                      child: const Icon(Icons.check),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget content(BuildContext context, EmailNotificationSettingsData state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...settingsWhenEnabled(context, state)],
    );
  }

  List<Widget> settingsWhenEnabled(BuildContext context, EmailNotificationSettingsData state) {
    final List<Widget> settingsList;

    final settings = [
      [messages(context, state), likes(context, state)],
    ];

    settingsList = [];
    for (final group in settings) {
      settingsList.add(settingsCategoryTitle(context, group.first.$1.group.title));
      settingsList.addAll(group.map((v) => v.$2));
    }
    return settingsList;
  }

  (NotificationCategory, Widget) messages(
    BuildContext context,
    EmailNotificationSettingsData state,
  ) {
    const category = NotificationCategoryMessages();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.valueMessages(),
      onChanged: (value) {
        context.read<EmailNotificationSettingsBloc>().add(ToggleEmailMessages());
      },
    );
    return (category, widget);
  }

  (NotificationCategory, Widget) likes(BuildContext context, EmailNotificationSettingsData state) {
    const category = NotificationCategoryLikes();
    final widget = categorySwitch(
      title: category.title,
      isEnabled: state.valueLikes(),
      onChanged: (value) {
        context.read<EmailNotificationSettingsBloc>().add(ToggleEmailLikes());
      },
    );
    return (category, widget);
  }

  Widget categorySwitch({
    required String title,
    required bool isEnabled,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(title: Text(title), value: isEnabled, onChanged: onChanged);
  }
}
