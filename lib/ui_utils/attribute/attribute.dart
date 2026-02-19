import 'package:app/ui_utils/attribute/filter.dart';
import 'package:app/ui_utils/attribute/icon.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/ui_utils/attribute/translation.dart';
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class AttributeManager {
  AttributeManager._(this._list);

  final List<UiAttribute> _list;

  factory AttributeManager.createFrom(ProfileAttributes attributes, String? locale) {
    final attributesCopy = attributes.attributes
        .map((a) => UiAttribute.createFrom(a, locale))
        .toList();

    if (attributes.attributeOrder == AttributeOrderMode.orderNumber) {
      attributesCopy.sort((a, b) {
        return a.apiAttribute().orderNumber.compareTo(b.apiAttribute().orderNumber);
      });
    }
    return AttributeManager._(attributesCopy);
  }

  List<UiAttribute> requiredAttributes() => _list.where((a) => a.apiAttribute().required_).toList();
  List<UiAttribute> allAttributes() => _list;

  List<AttributeAndState> parseStates(
    Map<int, ProfileAttributeValueUpdate> states, {
    bool includeNullAttributes = false,
  }) {
    final list = <AttributeAndState>[];
    for (final a in allAttributes()) {
      final state = states[a.apiAttribute().id];
      if (state != null) {
        list.add(AttributeAndState(a, AttributeStateStorage.parseFromUpdate(a, state)));
      } else if (includeNullAttributes) {
        list.add(AttributeAndState(a, AttributeStateStorage()));
      }
    }
    return list;
  }

  List<AttributeAndFilterState> parseFilterStates(
    Map<int, ProfileAttributeFilterValueUpdate> states,
  ) {
    final list = <AttributeAndFilterState>[];
    for (final a in allAttributes()) {
      final state = states[a.apiAttribute().id];
      if (state != null) {
        list.add(
          AttributeAndFilterState(
            a,
            AttributeStateStorage.parseFromFilterUpdate(a, state),
            AttributeStateStorage.parseFromFilterUpdate(a, state, parseUnwanted: true),
            FilterSettingsState.parseFromFilterUpdate(state),
          ),
        );
      } else {
        list.add(
          AttributeAndFilterState(
            a,
            AttributeStateStorage(),
            AttributeStateStorage(),
            FilterSettingsState(),
          ),
        );
      }
    }
    return list;
  }
}

class UiAttribute {
  final Attribute _attribute;
  final List<UiAttributeValue> _valuesAndGroupValues;
  final IconData? _icon;
  final String _uiName;
  UiAttribute._(this._attribute, this._valuesAndGroupValues, this._icon, this._uiName);

  factory UiAttribute.createFrom(Attribute attribute, String? locale) {
    final attributeValues = attribute.values
        .map((v) => UiAttributeValue.createFrom(attribute, v, null, locale))
        .toList();
    reorderAttributeValues(attributeValues, attribute.valueOrder);

    final valuesAndGroupValues = <UiAttributeValue>[];
    for (final levelOneValue in attributeValues) {
      valuesAndGroupValues.add(levelOneValue);
      final groupValues = levelOneValue
          .apiValue()
          .groupValues
          .map((v) => UiAttributeValue.createFrom(attribute, v, levelOneValue, locale))
          .toList();
      reorderAttributeValues(groupValues, attribute.valueOrder);
      valuesAndGroupValues.addAll(groupValues);
    }

    final valueKeysAndValueObjects = <String, UiAttributeValue>{};
    for (final v in valuesAndGroupValues) {
      valueKeysAndValueObjects[v.apiValue().key] = v;
    }

    return UiAttribute._(
      attribute,
      valuesAndGroupValues,
      AttributeIcons.iconResourceToMaterialIcon(attribute.icon),
      AttributeTranslation.getTranslatedString(
        locale,
        attribute.key,
        attribute.name,
        attribute.translations,
      ),
    );
  }

  Attribute apiAttribute() => _attribute;

  List<UiAttributeValue> values() => _valuesAndGroupValues;

  String uiName() => _uiName;

  IconData? uiIcon() => _icon;
}

class UiAttributeValue {
  final Attribute _apiAttribute;
  final AttributeValue _value;
  final IconData? _icon;
  final UiAttributeValue? _groupValueParent;
  final String _uiName;
  UiAttributeValue._(
    this._apiAttribute,
    this._value,
    this._icon,
    this._groupValueParent,
    this._uiName,
  );

  factory UiAttributeValue.createFrom(
    Attribute attribute,
    AttributeValue value,
    UiAttributeValue? groupValueParent,
    String? locale,
  ) {
    return UiAttributeValue._(
      attribute,
      value,
      AttributeIcons.iconResourceToMaterialIcon(value.icon),
      groupValueParent,
      AttributeTranslation.getTranslatedString(
        locale,
        value.key,
        value.name,
        attribute.translations,
      ),
    );
  }

  Attribute apiAttribute() => _apiAttribute;

  AttributeValue apiValue() => _value;

  String uiName() => _uiName;

  IconData? uiIcon() => _icon;

  UiAttributeValue? groupValueParent() => _groupValueParent;

  bool isGroupValue() => _groupValueParent != null;

  bool isParentOfGroupValue() => apiValue().groupValues.isNotEmpty;

  int selectedValueForApi() {
    final groupValueParent = _groupValueParent;
    if (apiAttribute().mode == AttributeMode.twoLevel) {
      final levelOneValue = apiValue().id << 16;
      if (groupValueParent != null) {
        return levelOneValue | groupValueParent.apiValue().id;
      } else {
        return levelOneValue;
      }
    } else {
      return apiValue().id;
    }
  }
}

abstract class AttributeValueAreaInfoProvider {
  List<String> valueAreaExtraValues();
  List<UiAttributeValue> valueAreaSelectedValues();
  bool valueAreaSelectedAlternativeColor();
  List<UiAttributeValue> valueAreaUnwantedValues();
  UiAttribute attribute();

  bool isEmpty() {
    return valueAreaExtraValues().isEmpty &&
        valueAreaSelectedValues().isEmpty &&
        valueAreaUnwantedValues().isEmpty;
  }
}

void reorderAttributeValues(List<UiAttributeValue> attributeValues, AttributeValueOrderMode order) {
  if (order == AttributeValueOrderMode.orderNumber) {
    attributeValues.sort((a, b) {
      return a.apiValue().orderNumber.compareTo(b.apiValue().orderNumber);
    });
  } else if (order == AttributeValueOrderMode.alphabethicalKey) {
    attributeValues.sort((a, b) {
      return a.apiValue().key.compareTo(b.apiValue().key);
    });
  } else if (order == AttributeValueOrderMode.alphabethicalValue) {
    attributeValues.sort((a, b) {
      return a.uiName().compareTo(b.uiName());
    });
  }
}
