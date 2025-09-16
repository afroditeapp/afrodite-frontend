import "package:app/logic/app/navigator_state.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:app/ui_utils/attribute/widgets/select_value.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/utils/list.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/ui_utils/initial_setup_common.dart";

class AskProfileAttributesPage extends MyScreenPage<()> {
  AskProfileAttributesPage({
    required int attributeIndex,
    required UiAttribute currentAttribute,
    required List<UiAttribute> attributes,
  }) : super(
         builder: (_) => AskProfileAttributesScreen(
           attributeIndex: attributeIndex,
           currentAttribute: currentAttribute,
           attributes: attributes,
         ),
       );
}

class AskProfileAttributesScreen extends StatelessWidget {
  final int attributeIndex;
  final UiAttribute currentAttribute;
  final List<UiAttribute> attributes;
  const AskProfileAttributesScreen({
    required this.attributeIndex,
    required this.currentAttribute,
    required this.attributes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.profileAttributes.answerForRequiredAttributeExists(
            currentAttribute.apiAttribute().id,
          )) {
            return () {
              final nextAttributeIndex = attributeIndex + 1;
              final nextAttribute = attributes.getAtOrNull(nextAttributeIndex);
              if (nextAttribute == null) {
                context.read<InitialSetupBloc>().add(CompleteInitialSetup());
              } else {
                MyNavigator.push(
                  context,
                  AskProfileAttributesPage(
                    attributeIndex: nextAttributeIndex,
                    currentAttribute: nextAttribute,
                    attributes: attributes,
                  ),
                );
              }
            };
          } else {
            return null;
          }
        },
        question: AskProfileAttributes(currentAttribute: currentAttribute),
        expandQuestion: true,
      ),
    );
  }
}

class AskProfileAttributes extends StatefulWidget {
  final UiAttribute currentAttribute;
  const AskProfileAttributes({required this.currentAttribute, super.key});

  @override
  State<AskProfileAttributes> createState() => _AskProfileAttributesState();
}

class _AskProfileAttributesState extends State<AskProfileAttributes> {
  final state = AttributeStateStorage();

  @override
  Widget build(BuildContext context) {
    return askInfo(context);
  }

  Widget askInfo(BuildContext context) {
    return SelectAttributeValue(
      attribute: widget.currentAttribute,
      firstListItem: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
          attributeTitle(context),
        ],
      ),
      initialStateBuilder: () => SelectAttributeValueStorage.selected(
        AttributeStateStorage.parseFromUpdateList(
          widget.currentAttribute,
          context.read<InitialSetupBloc>().state.profileAttributes.answers,
        ),
      ),
      onChanged: (storage) {
        context.read<InitialSetupBloc>().add(
          UpdateAttributeValue(storage.selected.toAttributeValueUpdate(widget.currentAttribute)),
        );
      },
    );
  }

  Widget attributeTitle(BuildContext context) {
    final text = Text(
      widget.currentAttribute.uiName(),
      style: Theme.of(context).textTheme.titleLarge,
    );
    return Padding(padding: const EdgeInsets.all(INITIAL_SETUP_PADDING), child: text);
  }
}
