import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class AskUnlimitedLikesScreen extends StatelessWidget {
  const AskUnlimitedLikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.unlimitedLikes != null) {
            return () {
              context.read<InitialSetupBloc>().add(CompleteInitialSetup());
            };
          } else {
            return null;
          }
        },
        question: Column(
          children: [
            questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
            const AskUnlimitedLikes(),

            // Zero sized widgets
            ProgressDialogOpener<InitialSetupBloc, InitialSetupData>(
              dialogVisibilityGetter: (state) =>
                state.sendingInProgress,
            ),
          ],
        ),
      ),
    );
  }
}

class AskUnlimitedLikes extends StatefulWidget {
  const AskUnlimitedLikes({
    super.key,
  });

  @override
  State<AskUnlimitedLikes> createState() => _AskUnlimitedLikesState();
}

class _AskUnlimitedLikesState extends State<AskUnlimitedLikes> {

  @override
  Widget build(BuildContext context) {
    return askInfo(context);
  }

  Widget askInfo(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
              child: Text(
                context.strings.initial_setup_screen_unlimited_likes_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
              child: Column(
                children: [
                  Text(context.strings.initial_setup_screen_unlimited_likes_description_part_1),
                  const Padding(padding: EdgeInsets.only(top: INITIAL_SETUP_PADDING)),
                  Row(
                    children: [
                      Expanded(child: Text(context.strings.initial_setup_screen_unlimited_likes_description_part_2)),
                      const Padding(padding: EdgeInsets.only(left: INITIAL_SETUP_PADDING)),
                      const Icon(Icons.all_inclusive),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            RadioListTile<bool>(
              title: Text(context.strings.initial_setup_screen_unlimited_likes_enabled),
              value: true,
              groupValue: state.unlimitedLikes,
              onChanged: (bool? value) {
                if (value != null) {
                  context.read<InitialSetupBloc>().add(SetUnlimitedLikes(value));
                }
              },
            ),
            RadioListTile<bool>(
              title: Text(context.strings.initial_setup_screen_unlimited_likes_disabled),
              value: false,
              groupValue: state.unlimitedLikes,
              onChanged: (bool? value) {
                if (value != null) {
                  context.read<InitialSetupBloc>().add(SetUnlimitedLikes(value));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
