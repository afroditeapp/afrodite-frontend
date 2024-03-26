import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/profile/attributes/attributes.dart";
import "package:pihka_frontend/ui/initial_setup/location.dart";
import "package:pihka_frontend/ui_utils/consts/padding.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/loading_dialog.dart";

class AskProfileAttributesScreen extends StatelessWidget {
  const AskProfileAttributesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.gender != null) {
            return () {
              Navigator.push(context, MaterialPageRoute<void>(builder: (_) => AskLocationScreen()));
            };
          } else {
            return null;
          }
        },
        question: AskProfileAttributes(
          attributesBloc: context.read<ProfileAttributesBloc>()
        ),
      ),
    );
  }
}

class AskProfileAttributes extends StatefulWidget {
  final ProfileAttributesBloc attributesBloc;
  const AskProfileAttributes({required this.attributesBloc, super.key});

  @override
  State<AskProfileAttributes> createState() => _AskProfileAttributesState();
}

class _AskProfileAttributesState extends State<AskProfileAttributes> {
  @override
  void initState() {
    super.initState();
    widget.attributesBloc.add(RefreshAttributesIfNeeded());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
        askInfo(context),

        // Zero sized widgets
        ProgressDialogOpener<ProfileAttributesBloc, AttributesData>(
          dialogVisibilityGetter: (context, state) =>
            state.refreshState is AttributeRefreshLoading,
        )
      ],
    );
  }

  Widget askInfo(BuildContext context) {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, state) {
        final attributes = state.attributes;
        if (attributes == null) {
          return attributesMissingUi(context);
        } else {
          return attributeQuestionsUi(context, attributes);
        }
      }
    );
  }

  Widget attributesMissingUi(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
          child: Text(context.strings.initial_setup_screen_profile_attributes_missing_error_text),
        ),
        ElevatedButton(
          onPressed: () {
            widget.attributesBloc.add(RefreshAttributesIfNeeded());
          },
          child: Text(context.strings.initial_setup_screen_profile_attributes_download_button),
        ),
      ],
    );
  }

  Widget attributeQuestionsUi(BuildContext context, AvailableProfileAttributes attributes) {
    return const SizedBox.shrink();
  }
}
