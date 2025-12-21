import 'package:app/logic/settings/chat_backup.dart';
import 'package:app/model/freezed/logic/settings/chat_backup.dart';
import 'package:app/ui/normal/settings/chat/chat_backup.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/localizations.dart';

class ChatBackupReminderDialogOpener extends StatelessWidget {
  const ChatBackupReminderDialogOpener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBackupBloc, ChatBackupData>(
      buildWhen: (previous, current) => previous.dialogTrigger != current.dialogTrigger,
      builder: (context, state) {
        final dialogTrigger = state.dialogTrigger;

        if (dialogTrigger != null) {
          // Mark dialog as opened and reset trigger
          final bloc = context.read<ChatBackupBloc>();
          bloc.add(HandleReminderDialogOpening());
          _showBackupReminderDialog(context, dialogTrigger);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _showBackupReminderDialog(BuildContext context, DialogTrigger trigger) async {
    final message = switch (trigger) {
      NoPreviousBackup() => context.strings.chat_backup_reminder_dialog_message_no_backup,
      OldBackup(:final daysSinceBackup) =>
        context.strings.chat_backup_reminder_dialog_message_old_backup(daysSinceBackup.toString()),
    };
    final result = await showConfirmDialog(
      context,
      context.strings.chat_backup_reminder_dialog_title,
      details: message,
      yesNoActions: true,
    );

    if (result == true && context.mounted) {
      openChatBackupScreen(context);
    }
  }
}
