import "package:app/logic/app/navigator_state.dart";
import "package:app/ui/initial_setup/unlimited_likes.dart";
import "package:app/ui_utils/attribute/attribute.dart";
import "package:app/ui_utils/attribute/state.dart";
import "package:app/ui_utils/attribute/widgets/select_value.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:app/utils/list.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/utils/api.dart";

final log = Logger("AskProfileAttributesScreen");

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
          if (state.profileAttributes.answerForRequiredAttributeExists(currentAttribute.apiAttribute().id)) {
            return () {
              final nextAttributeIndex = attributeIndex + 1;
              final nextAttribute = attributes.getAtOrNull(nextAttributeIndex);
              if (nextAttribute == null) {
                MyNavigator.push(context, const MaterialPage<void>(child: AskUnlimitedLikesScreen()));
              } else {
                MyNavigator.push(
                  context,
                  MaterialPage<void>(child: AskProfileAttributesScreen(
                    attributeIndex: nextAttributeIndex,
                    currentAttribute: nextAttribute,
                    attributes: attributes,
                  )),
                );
              }
            };
          } else {
            return null;
          }
        },
        question: AskProfileAttributes(
          currentAttribute: currentAttribute,
        ),
        expandQuestion: true,
      ),
    );
  }
}

class AskProfileAttributes extends StatefulWidget {
  final UiAttribute currentAttribute;
  const AskProfileAttributes({
    required this.currentAttribute,
    super.key,
  });

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
      isFilter: false,
      firstListItem: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_profile_basic_info_title),
          attributeTitle(context),
        ],
      ),
      initialStateBuilder: () => AttributeStateStorage.parseFromUpdateList(
        widget.currentAttribute,
        context.read<InitialSetupBloc>().state.profileAttributes.answers,
      ),
      onChanged: (storage) {
        context.read<InitialSetupBloc>().add(
          UpdateAttributeValue(storage.toAttributeValueUpdate(widget.currentAttribute)),
        );
      },
    );
  }

  Widget attributeTitle(BuildContext context) {
    final text = Text(
      widget.currentAttribute.uiName(),
      style: Theme.of(context).textTheme.titleLarge,
    );
    return Padding(
      padding: const EdgeInsets.all(INITIAL_SETUP_PADDING),
      child: text
    );
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
