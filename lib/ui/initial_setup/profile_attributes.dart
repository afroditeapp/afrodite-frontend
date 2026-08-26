import "package:app/logic/profile/attributes.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:app/ui_utils/attribute/widgets/select_value.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/navigation/url.dart";
import "package:app/utils/list.dart";
import "package:app/utils/result.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/ui/initial_setup/navigation.dart";
import "package:app/ui/normal/settings/profile/edit_profile.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:openapi/api.dart";

class AskProfileAttributesPageUrlParser extends UrlParser<AskProfileAttributesPage> {
  @override
  Future<Result<(AskProfileAttributesPage, UrlSegments), ()>> parseFromSegments(
    UrlSegments urlSegments,
  ) async {
    return urlSegments.intValue().mapOk(
      (v) => (AskProfileAttributesPage(attributeIndex: v.$1), v.$2),
    );
  }
}

class AskProfileAttributesPage extends InitialSetupPageBase {
  final int attributeIndex;
  AskProfileAttributesPage({required this.attributeIndex})
    : super(builder: (_) => AskProfileAttributesScreen(attributeIndex: attributeIndex));

  @override
  String get nameForDb => 'profile_attributes';

  @override
  String get urlPath => "/$urlName/$attributeIndex";

  @override
  bool checkEquality(MyPageWithUrlNavigation<Object> other) =>
      other is AskProfileAttributesPage && other.attributeIndex == attributeIndex;
}

class AskProfileAttributesScreen extends StatelessWidget {
  final int attributeIndex;
  const AskProfileAttributesScreen({required this.attributeIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return InitialSetupLoadingGuard(
      child: _AskProfileAttributesScreenInternal(attributeIndex: attributeIndex),
    );
  }
}

class _AskProfileAttributesScreenInternal extends StatelessWidget {
  final int attributeIndex;
  const _AskProfileAttributesScreenInternal({required this.attributeIndex});

  @override
  Widget build(BuildContext context) {
    final attributes =
        context.read<ProfileAttributesBloc>().state.manager?.requiredAttributes() ?? [];
    final currentAttribute = attributes.getAtOrNull(attributeIndex);
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (currentAttribute == null) {
            return null;
          }

          if (state.profileAttributes.answerForRequiredAttributeExists(
            currentAttribute.apiAttribute().id,
          )) {
            return () => navigateToNextInitialSetupPage(context);
          } else {
            return null;
          }
        },
        question: currentAttribute == null
            ? Center(child: Text(context.strings.generic_error))
            : AskProfileAttributes(currentAttribute: currentAttribute),
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
    return switch (widget.currentAttribute.apiAttribute().mode) {
      AttributeMode.bitflag ||
      AttributeMode.oneLevel ||
      AttributeMode.twoLevel => askNormalAttributeInfo(context),
      AttributeMode.unsignedInteger => askUnsignedIntegerInfo(context),
      AttributeMode.unknownDefaultOpenApi => Center(child: Text(context.strings.generic_error)),
    };
  }

  Widget askNormalAttributeInfo(BuildContext context) {
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

  Widget askUnsignedIntegerInfo(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(
      builder: (context, state) {
        final answers = state.profileAttributes.answers;
        final storage = AttributeStateStorage.parseFromUpdateList(widget.currentAttribute, answers);
        final a = AttributeAndState(widget.currentAttribute, storage);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            questionTitleText(
              context,
              context.strings.initial_setup_screen_profile_basic_info_title,
            ),
            attributeTitle(context),
            EditUnsignedIntegerAttributeRow(
              a: a,
              onChanged: (value) {
                final v = value == null ? const <int>[] : [value];
                context.read<InitialSetupBloc>().add(
                  UpdateAttributeValue(
                    ProfileAttributeValueUpdate(
                      id: widget.currentAttribute.apiAttribute().id,
                      v: v,
                    ),
                  ),
                );
              },
            ),
          ],
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
