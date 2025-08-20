import 'package:app/localizations.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/utils/api.dart';
import 'package:openapi/api.dart';

class AttributeAndFilterState extends AttributeValueAreaInfoProvider {
  final UiAttribute _attribute;
  final AttributeStateStorage wanted;
  final AttributeStateStorage unwanted;
  final FilterSettingsState settingsState;
  AttributeAndFilterState(this._attribute, this.wanted, this.unwanted, this.settingsState);

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
    final list = wanted.selected.values.toList();
    reorderAttributeValues(list, _attribute.apiAttribute().valueOrder);
    return list;
  }

  @override
  bool valueAreaSelectedAlternativeColor() => settingsState.requireAllWantedValues;

  @override
  List<UiAttributeValue> valueAreaUnwantedValues() {
    final list = unwanted.selected.values.toList();
    reorderAttributeValues(list, _attribute.apiAttribute().valueOrder);
    return list;
  }

  @override
  UiAttribute attribute() => _attribute;
}

class FilterSettingsState {
  final bool acceptMissingAttribute;
  final bool requireAllWantedValues;
  FilterSettingsState({this.acceptMissingAttribute = false, this.requireAllWantedValues = false});

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
    AttributeStateStorage wanted,
    AttributeStateStorage unwanted,
  ) {
    final update = ProfileAttributeFilterValueUpdate(
      id: current.id,
      acceptMissingAttribute: current.acceptMissingAttribute,
      useLogicalOperatorAnd: current.useLogicalOperatorAnd,
      wanted: wanted.toAttributeValueUpdate(attribute).v,
      unwanted: unwanted.toAttributeValueUpdate(attribute).v,
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
      wanted: [...current.wanted],
      unwanted: [...current.unwanted],
    );
    update.updateIsEnabled();
    return update;
  }
}
