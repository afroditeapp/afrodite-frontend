import "package:app/logic/app/navigator_state.dart";
import "package:app/ui/initial_setup/unlimited_likes.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/profile/attributes.dart";
import "package:app/model/freezed/logic/account/initial_setup.dart";
import "package:app/model/freezed/logic/profile/attributes.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/loading_dialog.dart";
import "package:app/ui_utils/snack_bar.dart";
import 'package:utils/utils.dart';
import "package:app/utils/api.dart";

final log = Logger("AskProfileAttributesScreen");

class AskProfileAttributesScreen extends StatelessWidget {
  const AskProfileAttributesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          if (state.profileAttributes is FullyAnswered) {
            return () {
              MyNavigator.push(context, const MaterialPage<void>(child: AskUnlimitedLikesScreen()));
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
        askInfo(context),

        // Zero sized widgets
        ProgressDialogOpener<ProfileAttributesBloc, AttributesData>(
          dialogVisibilityGetter: (state) =>
            state.refreshState is AttributeRefreshLoading,
        ),
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
            context.read<ProfileAttributesBloc>().add(RefreshAttributesIfNeeded());
          },
          child: Text(context.strings.initial_setup_screen_profile_attributes_download_button),
        ),
      ],
    );
  }

  Widget attributeQuestionsUi(BuildContext context, AvailableProfileAttributes attributes) {
    final availableAttributes = attributes.info;
    if (availableAttributes != null) {
      final requiredAttributes = availableAttributes.attributes.where((element) => element.required_).toList();
      if (requiredAttributes.isNotEmpty) {
        reorderAttributes(requiredAttributes, availableAttributes.attributeOrder);
        return questionAnsweringUi(context, requiredAttributes);
      }
    }

    return noQuestionsUi(context);
  }

  Widget noQuestionsUi(BuildContext context) {
    context.read<InitialSetupBloc>().add(SetProfileAttributesState(const FullyAnswered([])));
    return Padding(
      padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
      child: Text(context.strings.initial_setup_screen_profile_attributes_no_questions_text),
    );
  }

  Widget questionAnsweringUi(BuildContext context, List<Attribute> attributes) {
    final questionWidgets = <Widget>[];

    for (final attribute in attributes) {
      final widgetList = attributeToWidget(context, attribute, attributes.length);
      questionWidgets.addAll(widgetList);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: questionWidgets,
    );
  }

  List<Widget> attributeToWidget(BuildContext context, Attribute attribute, int requiredAttributeCount) {
    final List<Widget> widgetList;
    if (attribute.mode == AttributeMode.selectSingleFilterSingle ||
      attribute.mode == AttributeMode.selectSingleFilterMultiple) {
      widgetList = widgetsForSelectSingleAttribute(context);
    } else if (attribute.mode == AttributeMode.selectMultipleFilterMultiple) {
      final valueList = attribute.values.toList();
      reorderValues(valueList, attribute.valueOrder);
      widgetList = widgetsForSelectMultipleAttribute(
        context,
        attribute,
        valueList,
        attribute.translations,
        requiredAttributeCount,
      );
    } else {
      widgetList = [];
    }

    return [
      questionTitle(context, attribute),
      ...widgetList,
    ];
  }

  Widget questionTitle(BuildContext context, Attribute attribute) {
    final text = Text(
      attributeName(context, attribute),
      style: Theme.of(context).textTheme.titleLarge,
    );
    // Title icon is disabled
    // final IconData? icon = iconResourceToMaterialIcon(attribute.icon);
    const IconData? icon = null;

    final Widget title;
    if (icon != null) {
      title = Row(
        children: [
          Icon(icon),
          const Padding(padding: EdgeInsets.all(8.0)),
          text,
        ],
      );
    } else {
      title = text;
    }

    return Padding(
      padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
      child: title
    );
  }

  List<Widget> widgetsForSelectSingleAttribute(BuildContext context) {
    log.error("Select single attributes are unsupported");
    showSnackBar(context.strings.generic_error);
    return [];
  }

  List<Widget> widgetsForSelectMultipleAttribute(
    BuildContext context,
    Attribute attribute,
    List<AttributeValue> attributeValues,
    List<Language> translations,
    int requiredAttributeCount,
  ) {
    // Group values are not supported in select multiple attributes.
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final icon = iconResourceToMaterialIcon(value.icon);
      final text = attributeValueName(context, value, translations);

      final Widget title;
      if (icon != null) {
        title = Row(
          children: [
            Icon(icon),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(text),
          ],
        );
      } else {
        title = Text(text);
      }

      final checkbox = BlocBuilder<InitialSetupBloc, InitialSetupData>(
        builder: (context, state) {
          final currentValue = attributeValueStateForBitflagAttributes(state.profileAttributes.answers, attribute, value);
          return CheckboxListTile(
            title: title,
            value: currentValue,
            onChanged: (bitflagValue) {
              context.read<InitialSetupBloc>().add(
                ModifyProfileAttributeBitflagValue(
                  requiredAttributeCount,
                  attribute,
                  value,
                  bitflagValue == true
                )
              );
            },
          );
        }
      );

      widgets.add(checkbox);
    }
    return widgets;
  }
}

void reorderAttributes(List<Attribute> attributes, AttributeOrderMode order) {
  if (order == AttributeOrderMode.orderNumber) {
    attributes.sort((a, b) {
      return a.orderNumber.compareTo(b.orderNumber);
    });
  }
}

void reorderValues(List<AttributeValue> attributeValues, AttributeValueOrderMode order) {
  if (order == AttributeValueOrderMode.orderNumber) {
    attributeValues.sort((a, b) {
      return a.orderNumber.compareTo(b.orderNumber);
    });
  } else if (order == AttributeValueOrderMode.alphabethicalKey) {
    attributeValues.sort((a, b) {
      return a.key.compareTo(b.key);
    });
  } else if (order == AttributeValueOrderMode.alphabethicalValue) {
    log.warning("Alphabethical value ordering is not supported");
  }
}

String attributeName(BuildContext context, Attribute attribute) {
  final locale = Localizations.localeOf(context);
  if (locale.languageCode == "en") {
    return attribute.name;
  }

  final translations = attribute.translations.where((element) => element.lang == locale.languageCode).firstOrNull;
  if (translations == null) {
    return attribute.name;
  }

  for (final translation in translations.values) {
    if (translation.key == attribute.key) {
      return translation.value;
    }
  }

  return attribute.name;
}

String attributeValueName(BuildContext context, AttributeValue attributeValue, List<Language> languages) {
  final locale = Localizations.localeOf(context);
  if (locale.languageCode == "en") {
    return attributeValue.value;
  }

  final translations = languages.where((element) => element.lang == locale.languageCode).firstOrNull;
  if (translations == null) {
    return attributeValue.value;
  }

  for (final translation in translations.values) {
    if (translation.key == attributeValue.key) {
      return translation.value;
    }
  }

  return attributeValue.value;
}

IconData? iconResourceToMaterialIcon(String? iconResouce) {
  if (iconResouce == null) {
    return null;
  }
  const PREFIX = "material:";
  if (!iconResouce.startsWith(PREFIX)) {
    log.warning("Only material icons are supported");
    return null;
  }

  final identifier = iconResouce.substring(PREFIX.length);

  final IconData? iconObject = switch (identifier) {
    "celebration_rounded" => Icons.celebration_rounded,
    "close_rounded" => Icons.close_rounded,
    "color_lens_rounded" => Icons.color_lens_rounded,
    "favorite_rounded" => Icons.favorite_rounded,
    "location_city_rounded" => Icons.location_city_rounded,
    "question_mark_rounded" => Icons.question_mark_rounded,
    "search_rounded" => Icons.search_rounded,
    "waving_hand_rounded" => Icons.waving_hand_rounded,
    "star_rounded" => Icons.star_rounded,
    _ => null,
  };

  if (iconObject == null) {
    log.warning("Icon $identifier is not supported");
  }

  return iconObject;
}

bool attributeValueStateForBitflagAttributes(
  List<ProfileAttributeValueUpdate> currentValues,
  Attribute attribute,
  AttributeValue attributeValue
) {
  for (final value in currentValues) {
    if (value.id == attribute.id) {
      final currentValue = value.bitflagValue() ?? 0;
      return currentValue & attributeValue.id != 0;
    }
  }

  return false;
}
