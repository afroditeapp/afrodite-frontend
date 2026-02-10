import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/bloc_listener.dart";
import "package:app/ui_utils/padding.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/logic/settings/chat_backup.dart";
import "package:app/model/freezed/logic/settings/chat_backup.dart";
import "package:app/ui/initial_setup/profile_attributes.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class ChatInfoPage extends InitialSetupPageBase with SimpleUrlParser<ChatInfoPage> {
  ChatInfoPage() : super(builder: (_) => ChatInfoScreen());

  @override
  String get nameForDb => 'chat_info';

  @override
  ChatInfoPage create() => ChatInfoPage();
}

class ChatInfoScreen extends StatelessWidget {
  const ChatInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialSetupLoadingGuard(child: _ChatInfoScreenInternal());
  }
}

class _ChatInfoScreenInternal extends StatelessWidget {
  const _ChatInfoScreenInternal();

  @override
  Widget build(BuildContext context) {
    // Init profile attributes as it is next screen
    context.read<ProfileAttributesBloc>();

    return commonInitialSetupScreenContent(
      context: context,
      // When resuming initial setup backup might be already created
      child: BlocListenerWithInitialValue<ChatBackupBloc, ChatBackupData>(
        listener: (context, state) {
          if (state.lastBackupTime != null &&
              !context.read<InitialSetupBloc>().state.chatInfoUnderstood) {
            context.read<InitialSetupBloc>().add(SetChatInfoUnderstood(true));
          }
        },
        child: QuestionAsker(
          getContinueButtonCallback: (context, state) {
            if (state.chatInfoUnderstood) {
              return () {
                final attributes =
                    context.read<ProfileAttributesBloc>().state.manager?.requiredAttributes() ?? [];
                final nextAttribute = attributes.firstOrNull;
                if (nextAttribute == null) {
                  context.read<InitialSetupBloc>().add(CompleteInitialSetup());
                } else {
                  final nextPage = AskProfileAttributesPage(attributeIndex: 0);
                  MyNavigator.push(context, nextPage);
                  context.read<InitialSetupBloc>().add(SetCurrentPage(nextPage.nameForDb));
                }
              };
            } else {
              return null;
            }
          },
          question: const ChatInfoContent(),
          expandQuestion: true,
        ),
      ),
    );
  }
}

class ChatInfoContent extends StatefulWidget {
  const ChatInfoContent({super.key});

  @override
  State<ChatInfoContent> createState() => _ChatInfoContentState();
}

class _ChatInfoContentState extends State<ChatInfoContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBackupBloc, ChatBackupData>(
      builder: (context, state) {
        return content(context, state);
      },
    );
  }

  Widget content(BuildContext context, ChatBackupData backupState) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_chat_info_title),
          const SizedBox(height: 16),
          hPad(
            Text(
              context.strings.initial_setup_screen_chat_info_description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 32),
          if (backupState.lastBackupTime == null) ...[
            Center(
              child: backupState.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      onPressed: backupState.lastBackupTime == null
                          ? () {
                              context.read<ChatBackupBloc>().add(CreateAndSaveChatBackup());
                            }
                          : null,
                      icon: const Icon(Icons.save),
                      label: Text(
                        context.strings.initial_setup_screen_chat_info_save_backup_button,
                      ),
                    ),
            ),
          ],
          if (backupState.lastBackupTime != null || backupState.isError) ...[
            if (backupState.isError) const SizedBox(height: 16),
            Center(
              child: backupState.isError
                  ? Text(
                      context.strings.generic_error_occurred,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, color: Colors.green, size: 48),
                        const SizedBox(height: 8),
                        Text(
                          context.strings.initial_setup_screen_chat_info_backup_saved_successfully,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
