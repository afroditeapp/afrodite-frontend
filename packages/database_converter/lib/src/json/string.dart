import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class JsonString {
  final Map<String, Object?> jsonMap;
  JsonString(this.jsonMap);

  AccountStateContainer? toAccountStateContainer() {
    return AccountStateContainer.fromJson(jsonMap);
  }

  Permissions? toPermissions() {
    return Permissions.fromJson(jsonMap);
  }

  GetProfileFilteringSettings? toProfileAttributeFilterList() {
    return GetProfileFilteringSettings.fromJson(jsonMap);
  }

  SearchGroups? toSearchGroups() {
    return SearchGroups.fromJson(jsonMap);
  }

  Attribute? toAttribute() {
    return Attribute.fromJson(jsonMap);
  }

  CustomReportsConfig? toCustomReportsConfig() {
    return CustomReportsConfig.fromJson(jsonMap);
  }

  ClientFeaturesConfig? toClientFeaturesConfig() {
    return ClientFeaturesConfig.fromJson(jsonMap);
  }

  static TypeConverter<JsonString, String> driftConverter = TypeConverter.json2(
    fromJson: (json) => JsonString(json as Map<String, Object?>),
    toJson: (object) => object.jsonMap,
  );
}

extension AccountStateContainerJson on AccountStateContainer {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension PermissionsJson on Permissions {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension GetProfileFilteringSettingsJson on GetProfileFilteringSettings {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension SearchGroupsJson on SearchGroups {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension AttributeJson on Attribute {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension CustomReportsConfigJson on CustomReportsConfig {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}

extension ClientFeaturesConfigJson on ClientFeaturesConfig {
  JsonString toJsonString() {
    return JsonString(toJson());
  }
}
