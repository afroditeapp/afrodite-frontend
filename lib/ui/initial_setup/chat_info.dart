import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/padding.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/profile/attributes.dart";
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
    // Init profile attributes as it is next screen
    context.read<ProfileAttributesBloc>();

    return commonInitialSetupScreenContent(
      context: context,
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
    final understood = context.watch<InitialSetupBloc>().state.chatInfoUnderstood;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_chat_info_title),
          const SizedBox(height: 16),
          hPad(
            _buildWarningItem(
              context,
              Icons.warning_amber,
              context.strings.initial_setup_screen_chat_info_item1,
            ),
          ),
          const SizedBox(height: 16),
          hPad(
            _buildWarningItem(
              context,
              Icons.warning_amber,
              context.strings.initial_setup_screen_chat_info_item2,
            ),
          ),
          const SizedBox(height: 16),
          hPad(
            Text(
              context.strings.initial_setup_screen_chat_info_item3,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
            child: CheckboxListTile(
              value: understood,
              onChanged: (value) {
                if (value != null) {
                  context.read<InitialSetupBloc>().add(SetChatInfoUnderstood(value));
                }
              },
              title: Text(
                context.strings.initial_setup_screen_chat_info_checkbox,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningItem(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.error, size: 24),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }
}
