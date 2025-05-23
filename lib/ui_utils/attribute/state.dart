
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
      intList = [apiValue];
    } else {
      intList = values.map((v) => v.selectedValueForApi()).toList();
    }
    return ProfileAttributeValueUpdate(
      id: attribute.apiAttribute().id,
      v: intList,
    );
  }

  factory AttributeStateStorage.parseFromUpdateList(UiAttribute attribute, List<ProfileAttributeValueUpdate> state) {
    final storage = AttributeStateStorage();
    for (final u in state) {
      if (u.id != attribute.apiAttribute().id) {
        continue;
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
    }
    return storage;
  }
}
