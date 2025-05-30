
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:openapi/api.dart';

class AttributeStateStorage {
  final Map<String, UiAttributeValue> selected = {};
  AttributeStateStorage();

  bool isSelected(UiAttributeValue attribute) =>
    selected.containsKey(attribute.apiValue().key);

  void select(UiAttributeValue attribute) =>
    selected[attribute.apiValue().key] = attribute;

  void unselect(UiAttributeValue attribute) =>
    selected.remove(attribute.apiValue().key);

  void clear() => selected.clear();

  void clearAndSelect(UiAttributeValue attribute) {
    selected.clear();
    select(attribute);
  }

  bool isNotEmpty() => selected.isNotEmpty;

  int length() => selected.length;

  bool groupValueSelected(UiAttributeValue levelOneValue) {
    for (final v in selected.values) {
      if (levelOneValue.apiValue().key == v.groupValueParent()?.apiValue().key) {
        return true;
      }
    }
    return false;
  }

  void unselectGroupValues(UiAttributeValue levelOneValue) {
    final toBeUnselected = <UiAttributeValue>[];
    for (final v in selected.values) {
      if (levelOneValue.apiValue().key == v.groupValueParent()?.apiValue().key) {
        toBeUnselected.add(v);
      }
    }
    for (final v in toBeUnselected) {
      unselect(v);
    }
  }

  ProfileAttributeValueUpdate toAttributeValueUpdate(UiAttribute attribute) {
    final values = selected.values;
    List<int> intList;
    if (attribute.apiAttribute().mode == AttributeMode.bitflag) {
      final apiValue = values.fold(0, (previous, current) => previous | current.selectedValueForApi());
      if (apiValue == 0) {
        // Empty list removes the attribute
        intList = [];
      } else {
        intList = [apiValue];
      }
    } else {
      intList = values.map((v) => v.selectedValueForApi()).toList();
    }
    return ProfileAttributeValueUpdate(
      id: attribute.apiAttribute().id,
      v: intList,
    );
  }

  AttributeStateStorage copy() {
    final storage = AttributeStateStorage();
    for (final v in selected.values) {
      storage.select(v);
    }
    return storage;
  }

  factory AttributeStateStorage.parseFromUpdateList(UiAttribute attribute, List<ProfileAttributeValueUpdate> state) {
    for (final u in state) {
      if (u.id != attribute.apiAttribute().id) {
        continue;
      }
      return AttributeStateStorage.parseFromUpdate(attribute, u);
    }
    return AttributeStateStorage();
  }

  factory AttributeStateStorage.parseFromUpdate(UiAttribute attribute, ProfileAttributeValueUpdate u) {
    final storage = AttributeStateStorage();
    if (u.id != attribute.apiAttribute().id) {
      return storage;
    }
    for (final update in u.v) {
      if (attribute.apiAttribute().mode == AttributeMode.bitflag) {
        for (final availableValue in attribute.values()) {
          if (availableValue.selectedValueForApi() & update == availableValue.selectedValueForApi()) {
            storage.select(availableValue);
          }
        }
        break;
      } else {
        for (final availableValue in attribute.values()) {
          if (availableValue.selectedValueForApi() == update) {
            storage.select(availableValue);
          }
        }
      }
    }
    return storage;
  }

  factory AttributeStateStorage.parseFromFilterUpdate(
    UiAttribute attribute,
    ProfileAttributeFilterValueUpdate u,
    {
      bool nonselected = false,
    }
  ) {
    return AttributeStateStorage.parseFromUpdate(
      attribute,
      ProfileAttributeValueUpdate(
        id: attribute.apiAttribute().id,
        v: nonselected ? u.filterValuesNonselected : u.filterValues,
      ),
    );
  }
}

class AttributeAndState extends AttributeValueAreaInfoProvider {
  final UiAttribute _attribute;
  final AttributeStateStorage state;
  AttributeAndState(this._attribute, this.state);

  @override
  List<String> valueAreaExtraValues() {
    return [];
  }

  @override
  List<UiAttributeValue> valueAreaSelectedValues() {
    final list = state.selected.values.toList();
    reorderAttributeValues(list, _attribute.apiAttribute().valueOrder);
    return list;
  }

  @override
  bool valueAreaSelectedAlternativeColor() => false;

  @override
  List<UiAttributeValue> valueAreaNonselectedValues() {
    return [];
  }

  @override
  UiAttribute attribute() => _attribute;
}
