
import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:openapi/api.dart';

class AttributeAndFilterState extends AttributeValueAreaInfoProvider {
  final UiAttribute _attribute;
  final AttributeStateStorage selectedValues;
  final FilterSettingsState settingsState;
  AttributeAndFilterState(this._attribute, this.selectedValues, this.settingsState);

  @override
  List<String> valueAreaExtraValues() {
    if (settingsState.acceptMissingAttribute) {
      return [R.strings.generic_empty];
    } else {
      return [];
    }
  }

  @override
  List<UiAttributeValue> valueAreaSelectedValues() {
    final list = selectedValues.selected.values.toList();
    reorderAttributeValues(list, _attribute.apiAttribute().valueOrder);
    return list;
  }

  @override
  UiAttribute attribute() => _attribute;
}

class FilterSettingsState {
  final bool acceptMissingAttribute;
  FilterSettingsState({
    this.acceptMissingAttribute = false,
  });

  factory FilterSettingsState.parseFromFilterUpdate(ProfileAttributeFilterValueUpdate u) {
    return FilterSettingsState(
      acceptMissingAttribute: u.acceptMissingAttribute,
    );
  }
}

class AttributeFilterUpdateBuilder {
  static ProfileAttributeFilterValueUpdate copyWithValues(
    UiAttribute attribute,
    ProfileAttributeFilterValueUpdate current,
    AttributeStateStorage selectedValues,
  ) {
    final update = ProfileAttributeFilterValueUpdate(
      id: current.id,
      acceptMissingAttribute: current.acceptMissingAttribute,
      filterValues: selectedValues.toAttributeValueUpdate(attribute).v,
    );
    _updateIsEnabled(update);
    return update;
  }

  static ProfileAttributeFilterValueUpdate copyWithSettings(
    UiAttribute attribute,
    ProfileAttributeFilterValueUpdate current,
    FilterSettingsState settings,
  ) {
    final update = ProfileAttributeFilterValueUpdate(
      id: attribute.apiAttribute().id,
      acceptMissingAttribute: settings.acceptMissingAttribute,
      filterValues: [ ...current.filterValues ],
    );
    _updateIsEnabled(update);
    return update;
  }
}

void _updateIsEnabled(ProfileAttributeFilterValueUpdate value) {
  value.enabled = value.acceptMissingAttribute ||
    value.filterValues.isNotEmpty;
}
