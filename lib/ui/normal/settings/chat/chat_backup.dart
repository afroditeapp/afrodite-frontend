import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/chat/receive_chat_backup.dart';
import 'package:app/logic/settings/chat_backup.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/settings/chat_backup.dart';
import 'package:app/ui/normal/settings/chat/receive_chat_backup.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/padding.dart';
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: 8)),
            hPad(
              Row(
                spacing: 16,
                children: [
                  createAndSaveBackupButton(context, state),
                  if (state.isLoading) CircularProgressIndicator(),
                ],
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: 16)),
            hPad(importButton(context, state)),
            Padding(padding: EdgeInsetsGeometry.only(top: 16)),
            hPad(receiveBackupButton(context, state)),
          ],
        );
      },
    );
  }

  Widget createAndSaveBackupButton(BuildContext context, ChatBackupData state) {
    return ElevatedButton(
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
      child: Text(context.strings.chat_backup_screen_create_backup),
    );
  }

  Widget importButton(BuildContext context, ChatBackupData state) {
    return ElevatedButton(
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
      child: Text(context.strings.chat_backup_screen_import_backup),
    );
  }

  Widget receiveBackupButton(BuildContext context, ChatBackupData state) {
    // Bloc might not be available as this screen can be opened
    // when account is banned or pending deletion.
    if (context.read<ReceiveChatBackupBloc?>() == null) {
      return SizedBox.shrink();
    }

    return ElevatedButton(
      onPressed: () {
        openReceiveChatBackupScreen(context);
      },
      child: Text(context.strings.receive_chat_backup_screen_title),
    );
  }
}
