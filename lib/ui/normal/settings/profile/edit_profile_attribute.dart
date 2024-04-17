

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/attributes.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_attributes.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_basic_info.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_pictures.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/age.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

class EditProfileAttributeScreen extends StatefulWidget {
  final AttributeAndValue a;
  const EditProfileAttributeScreen({
    required this.a,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileAttributeScreen> createState() => _EditProfileAttributeScreenState();
}

class _EditProfileAttributeScreenState extends State<EditProfileAttributeScreen> {

  void validateAndSaveData(BuildContext context) {
    final currentAttributes = context.read<EditMyProfileBloc>().state.attributes;

    for (final a in currentAttributes) {
      if (a.id == widget.a.attribute.id && widget.a.attribute.required_ && a.valuePart1 == 0) {
        showSnackBar(context.strings.edit_attribute_value_screen_one_value_must_be_selected);
        return;
      }
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        validateAndSaveData(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.edit_profile_screen_title)),
        body: edit(context),
      ),
    );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EditSingleAttribute(
            a: widget.a,
            onNewAttributeValue: (value) {
              context.read<EditMyProfileBloc>().add(NewAttributeValue(value));
            },
          ),
        ],
      ),
    );
  }
}

class EditSingleAttribute extends StatefulWidget {
  final AttributeAndValue a;
  final void Function(ProfileAttributeValueUpdate) onNewAttributeValue;
  const EditSingleAttribute({required this.a, required this.onNewAttributeValue, super.key});

  @override
  State<EditSingleAttribute> createState() => _EditSingleAttributeState();
}

class _EditSingleAttributeState extends State<EditSingleAttribute> {
  int? valuePart1;
  int? valuePart2;

  @override
  void initState() {
    super.initState();

    valuePart1 = widget.a.value?.valuePart1;
    valuePart2 = widget.a.value?.valuePart2;
  }

  bool attributeValueStateForBitflagAttributes(
    AttributeValue attributeValue
  ) {
    final currentValue = valuePart1 ?? 0;
    return currentValue & attributeValue.id != 0;
  }

  void updateBitflagValue(
    bool newValue,
    AttributeValue attributeValue,
  ) {
    final int currentNumberValue = valuePart1 ?? 0;
    final int newNumberValue;
    if (newValue) {
      var v = valuePart1 ?? 0;
      v |= attributeValue.id;
      newNumberValue = v;
    } else {
      var v = valuePart1 ?? 0;
      v &= ~attributeValue.id;
      newNumberValue = v;
    }

    if (currentNumberValue != newNumberValue) {
      valuePart1 = newNumberValue;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  bool? firstLevelButtonValue(
    AttributeValue attributeValue
  ) {
    if (valuePart1 == attributeValue.id) {
      if (valuePart2 == null) {
        return true;
      } else {
        return null; // Indeterminate
      }
    } else {
      return false;
    }
  }

  bool secondLevelButtonValue(
    AttributeValue parentAttributeValue,
    AttributeValue attributeValue,
  ) {
    return valuePart1 == parentAttributeValue.id && valuePart2 == attributeValue.id;
  }

  void updateFirstLevelButtonValue(
    int? newPart1Value,
  ) {
    if (valuePart1 != newPart1Value) {
      valuePart1 = newPart1Value;
      valuePart2 = null;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  void updateSecondLevelButtonValue(
    int? newPart1Value,
    int? newPart2Value,
  ) {
    if (valuePart2 != newPart2Value || valuePart1 != newPart1Value) {
      valuePart1 = newPart1Value;
      valuePart2 = newPart2Value;
      widget.onNewAttributeValue(
        ProfileAttributeValueUpdate(
          id: widget.a.attribute.id,
          valuePart1: valuePart1,
          valuePart2: valuePart2,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: attributeToWidget(context, widget.a.attribute),
    );
  }

  List<Widget> attributeToWidget(BuildContext context, Attribute attribute) {
    final List<Widget> widgetList;
    if (attribute.mode == AttributeMode.selectSingleFilterSingle ||
      attribute.mode == AttributeMode.selectSingleFilterMultiple) {
      final valueList = attribute.values.toList();
      reorderValues(valueList, attribute.valueOrder);
      widgetList = widgetsForSelectSingleAttribute(
        context,
        attribute,
        valueList,
      );
    } else if (attribute.mode == AttributeMode.selectMultipleFilterMultiple) {
      final valueList = attribute.values.toList();
      reorderValues(valueList, attribute.valueOrder);
      widgetList = widgetsForSelectMultipleAttribute(
        context,
        valueList,
        attribute.translations,
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
      style: Theme.of(context).textTheme.bodyLarge,
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

  List<Widget> widgetsForSelectSingleAttribute(
    BuildContext context,
    Attribute attribute,
    List<AttributeValue> attributeValues,
  ) {
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final checkbox = CheckboxListTile(
        title: singleSelectTitle(attribute, value),
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: firstLevelButtonValue(value),
        onChanged: (newValue) {
          setState(() {
            if (valuePart1 == value.id) {
              updateFirstLevelButtonValue(null);
            } else {
              updateFirstLevelButtonValue(value.id);
            }
          });
        },
      );

      widgets.add(checkbox);

      final groupValues = value.groupValues?.values.toList();
      if (groupValues != null) {
        reorderValues(groupValues, attribute.valueOrder);
        final groupWidgets = widgetsForSelectSingleAttributeSecondLevel(
          context,
          attribute,
          value,
          groupValues,
        );
        widgets.addAll(groupWidgets);
      }
    }
    return widgets;
  }

  List<Widget> widgetsForSelectSingleAttributeSecondLevel(
    BuildContext context,
    Attribute attribute,
    AttributeValue parentValue,
    List<AttributeValue> attributeValues,
  ) {
    final widgets = <Widget>[];
    for (final value in attributeValues) {
      final checkbox = CheckboxListTile(
        title: singleSelectTitle(attribute, value),
        tristate: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: secondLevelButtonValue(parentValue, value),
        onChanged: (newValue) {
          setState(() {
            if (valuePart1 == parentValue.id && valuePart2 == value.id) {
              updateSecondLevelButtonValue(null, null);
            } else {
              updateSecondLevelButtonValue(parentValue.id, value.id);
            }
          });
        },
      );

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: checkbox
        )
      );
    }
    return widgets;
  }

  Widget singleSelectTitle(
    Attribute attribute,
    AttributeValue value,
  ) {
      final icon = iconResourceToMaterialIcon(value.icon);
      final text = attributeValueName(context, value, attribute.translations);
      if (icon != null) {
        return Row(
          children: [
            Icon(icon),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(text),
          ],
        );
      } else {
        return Text(text);
      }
  }

  List<Widget> widgetsForSelectMultipleAttribute(
    BuildContext context,
    List<AttributeValue> attributeValues,
    List<Language> translations,
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

      final checkbox = CheckboxListTile(
        title: title,
        value: attributeValueStateForBitflagAttributes(value),
        onChanged: (bitflagValue) {
          setState(() {
            updateBitflagValue(bitflagValue == true, value);
          });
        },
      );

      widgets.add(checkbox);
    }
    return widgets;
  }
}
