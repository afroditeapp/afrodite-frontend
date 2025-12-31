import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/receive_chat_backup.dart';
import 'package:app/logic/settings/chat_backup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/chat_backup.dart';
import 'package:app/ui/normal/settings.dart';
import 'package:app/ui/normal/settings/chat/receive_chat_backup.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/ui_utils/slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_selector/file_selector.dart';

void openChatBackupScreen(BuildContext context) {
  MyNavigator.push(context, ChatBackupPage());
}

class ChatBackupPage extends MyScreenPage<()> with SimpleUrlParser<ChatBackupPage> {
  ChatBackupPage() : super(builder: (_) => ChatBackupScreen());

  @override
  ChatBackupPage create() => ChatBackupPage();
}

class ChatBackupScreen extends StatefulWidget {
  const ChatBackupScreen({super.key});

  @override
  State<ChatBackupScreen> createState() => _ChatBackupScreenState();
}

class _ChatBackupScreenState extends State<ChatBackupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.chat_backup_screen_title)),
      body: screenContent(context),
    );
  }

  Widget screenContent(BuildContext context) {
    return BlocBuilder<ChatBackupBloc, ChatBackupData>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              settingsCategoryTitle(context, context.strings.generic_create),
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              hPad(
                Row(
                  spacing: 16,
                  children: [
                    createAndSaveBackupButton(context, state),
                    shareBackupButton(context, state),
                    if (state.isLoading) CircularProgressIndicator(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.only(top: 24)),
              settingsCategoryTitle(context, context.strings.generic_restore),
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              hPad(
                Row(
                  spacing: 16,
                  children: [importButton(context, state), receiveBackupButton(context, state)],
                ),
              ),
              Padding(padding: EdgeInsetsGeometry.only(top: 24)),
              settingsCategoryTitle(context, context.strings.generic_remind),
              Padding(padding: EdgeInsetsGeometry.only(top: 8)),
              backupReminderSlider(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget createAndSaveBackupButton(BuildContext context, ChatBackupData state) {
    return ElevatedButton.icon(
      onPressed: !state.isLoading
          ? () async {
              final r = await showConfirmDialog(
                context,
                context.strings.chat_backup_screen_create_backup_question,
                details: context.strings.chat_backup_screen_create_backup_question_details,
                yesNoActions: true,
              );
              if (r == true && context.mounted) {
                context.read<ChatBackupBloc>().add(CreateAndSaveChatBackup());
              }
            }
          : null,
      icon: const Icon(Icons.save),
      label: Text(context.strings.generic_save),
    );
  }

  Widget shareBackupButton(BuildContext context, ChatBackupData state) {
    return ElevatedButton.icon(
      onPressed: !state.isLoading
          ? () async {
              final r = await showConfirmDialog(
                context,
                context.strings.chat_backup_screen_create_backup_question,
                details: context.strings.chat_backup_screen_create_backup_question_details,
                yesNoActions: true,
              );
              if (r == true && context.mounted) {
                context.read<ChatBackupBloc>().add(ShareChatBackup());
              }
            }
          : null,
      icon: Icon(defaultTargetPlatform == TargetPlatform.iOS ? Icons.ios_share : Icons.share),
      label: Text(context.strings.generic_share),
    );
  }

  Widget importButton(BuildContext context, ChatBackupData state) {
    return ElevatedButton.icon(
      onPressed: !state.isLoading
          ? () async {
              const XTypeGroup typeGroup = XTypeGroup(
                label: 'backup',
                extensions: <String>['backup'],
              );
              final XFile? file = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
              if (file != null && context.mounted) {
                final fileName = file.name;
                final details = context.strings.chat_backup_screen_import_backup_question_details(
                  fileName,
                );
                final confirm = await showConfirmDialog(
                  context,
                  context.strings.chat_backup_screen_import_backup_question,
                  details: details,
                  yesNoActions: true,
                  scrollable: true,
                );
                if (confirm == true && context.mounted) {
                  context.read<ChatBackupBloc>().add(ImportChatBackup(file.path));
                }
              }
            }
          : null,
      icon: const Icon(Icons.file_open),
      label: Text(context.strings.generic_import),
    );
  }

  Widget receiveBackupButton(BuildContext context, ChatBackupData state) {
    // Bloc might not be available as this screen can be opened
    // when account is banned or pending deletion.
    if (context.read<ReceiveChatBackupBloc?>() == null) {
      return SizedBox.shrink();
    }

    return ElevatedButton.icon(
      onPressed: () {
        openReceiveChatBackupScreen(context);
      },
      icon: const Icon(Icons.download),
      label: Text(context.strings.generic_receive),
    );
  }

  Widget backupReminderSlider(BuildContext context, ChatBackupData state) {
    const intervals = [0, 1, 2, 3, 4, 5, 6, 7, 14, 30, 60, 90, 180, 365];
    final currentDays = state.valueReminderIntervalDays();
    final currentIndex = intervals
        .indexOf(currentDays)
        .toDouble()
        .clamp(0.0, (intervals.length - 1).toDouble());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hPad(
          Text(
            _getReminderLabel(context, currentDays),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        SliderWithPadding(
          value: currentIndex,
          min: 0,
          max: (intervals.length - 1).toDouble(),
          divisions: intervals.length - 1,
          thumbColor: Theme.of(context).colorScheme.primary,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (value) {
            final selectedDays = intervals[value.toInt()];
            context.read<ChatBackupBloc>().add(
              UpdateReminderInterval(selectedDays == 0 ? 0 : selectedDays),
            );
          },
        ),
      ],
    );
  }

  String _getReminderLabel(BuildContext context, int days) {
    if (days == 0) {
      return context.strings.generic_disabled;
    } else if (days == 1) {
      return context.strings.chat_backup_screen_backup_reminder_interval_day;
    } else {
      return context.strings.chat_backup_screen_backup_reminder_interval_days(days.toString());
    }
  }
}
