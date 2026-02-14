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

class FirstChatBackupPage extends InitialSetupPageBase with SimpleUrlParser<FirstChatBackupPage> {
  FirstChatBackupPage() : super(builder: (_) => FirstChatBackupScreen());

  @override
  String get nameForDb => 'first_chat_backup';

  @override
  FirstChatBackupPage create() => FirstChatBackupPage();
}

class FirstChatBackupScreen extends StatelessWidget {
  const FirstChatBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitialSetupLoadingGuard(child: _FirstChatBackupScreenInternal());
  }
}

class _FirstChatBackupScreenInternal extends StatelessWidget {
  const _FirstChatBackupScreenInternal();

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
              !context.read<InitialSetupBloc>().state.firstChatBackupCreated) {
            context.read<InitialSetupBloc>().add(SetFirstChatBackupCreated(true));
          }
        },
        child: QuestionAsker(
          getContinueButtonCallback: (context, state) {
            if (state.firstChatBackupCreated) {
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
          question: const FirstChatBackupContent(),
          expandQuestion: true,
        ),
      ),
    );
  }
}

class FirstChatBackupContent extends StatefulWidget {
  const FirstChatBackupContent({super.key});

  @override
  State<FirstChatBackupContent> createState() => _FirstChatBackupContentState();
}

class _FirstChatBackupContentState extends State<FirstChatBackupContent> {
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
          questionTitleText(context, context.strings.initial_setup_screen_first_chat_backup_title),
          const SizedBox(height: 16),
          hPad(
            Text(
              context.strings.initial_setup_screen_first_chat_backup_description,
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
                        context.strings.initial_setup_screen_first_chat_backup_save_backup_button,
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
                          context
                              .strings
                              .initial_setup_screen_first_chat_backup_backup_saved_successfully,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
            ),
            if (backupState.lastBackupTime != null) ...[
              const SizedBox(height: 24),
              hPad(
                Text(
                  context.strings.initial_setup_screen_first_chat_backup_security_info,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
