
import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/utils/api.dart';
import 'package:openapi/api.dart';

class AttributeAndFilterState extends AttributeValueAreaInfoProvider {
  final UiAttribute _attribute;
  final AttributeStateStorage selectedValues;
  final AttributeStateStorage nonselectedValues;
  final FilterSettingsState settingsState;
  AttributeAndFilterState(this._attribute, this.selectedValues, this.nonselectedValues, this.settingsState);

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
  bool valueAreaSelectedAlternativeColor() => settingsState.requireAllWantedValues;

  @override
  List<UiAttributeValue> valueAreaNonselectedValues() {
    final list = nonselectedValues.selected.values.toList();
    reorderAttributeValues(list, _attribute.apiAttribute().valueOrder);
    return list;
  }

  @override
  UiAttribute attribute() => _attribute;
}

class FilterSettingsState {
  final bool acceptMissingAttribute;
  final bool requireAllWantedValues;
  FilterSettingsState({
    this.acceptMissingAttribute = false,
    this.requireAllWantedValues = false,
  });

  factory FilterSettingsState.parseFromFilterUpdate(ProfileAttributeFilterValueUpdate u) {
    return FilterSettingsState(
      acceptMissingAttribute: u.acceptMissingAttribute,
      requireAllWantedValues: u.useLogicalOperatorAnd,
    );
  }
}

class AttributeFilterUpdateBuilder {
  static ProfileAttributeFilterValueUpdate copyWithValues(
    UiAttribute attribute,
    ProfileAttributeFilterValueUpdate current,
    AttributeStateStorage selectedValues,
    AttributeStateStorage nonselectedValues,
  ) {
    final update = ProfileAttributeFilterValueUpdate(
      id: current.id,
      acceptMissingAttribute: current.acceptMissingAttribute,
      useLogicalOperatorAnd: current.useLogicalOperatorAnd,
      filterValues: selectedValues.toAttributeValueUpdate(attribute).v,
      filterValuesNonselected: nonselectedValues.toAttributeValueUpdate(attribute).v,
    );
    update.updateIsEnabled();
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
      useLogicalOperatorAnd: settings.requireAllWantedValues,
      filterValues: [ ...current.filterValues ],
      filterValuesNonselected: [ ...current.filterValuesNonselected ],
    );
    update.updateIsEnabled();
    return update;
  }
}
