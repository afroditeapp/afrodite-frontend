//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AvailableProfileAttributes {
  /// Returns a new [AvailableProfileAttributes] instance.
  AvailableProfileAttributes({
    this.info,
    required this.syncVersion,
  });

  ProfileAttributeInfo? info;

  ProfileAttributesSyncVersion syncVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AvailableProfileAttributes &&
    other.info == info &&
    other.syncVersion == syncVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (info == null ? 0 : info!.hashCode) +
    (syncVersion.hashCode);

  @override
  String toString() => 'AvailableProfileAttributes[info=$info, syncVersion=$syncVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.info != null) {
      json[r'info'] = this.info;
    } else {
      json[r'info'] = null;
    }
      json[r'sync_version'] = this.syncVersion;
    return json;
  }

  /// Returns a new [AvailableProfileAttributes] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AvailableProfileAttributes? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AvailableProfileAttributes[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AvailableProfileAttributes[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AvailableProfileAttributes(
        info: ProfileAttributeInfo.fromJson(json[r'info']),
        syncVersion: ProfileAttributesSyncVersion.fromJson(json[r'sync_version'])!,
      );
    }
    return null;
  }

  static List<AvailableProfileAttributes> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AvailableProfileAttributes>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AvailableProfileAttributes.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AvailableProfileAttributes> mapFromJson(dynamic json) {
    final map = <String, AvailableProfileAttributes>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AvailableProfileAttributes.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AvailableProfileAttributes-objects as value to a dart map
  static Map<String, List<AvailableProfileAttributes>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AvailableProfileAttributes>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AvailableProfileAttributes.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sync_version',
  };
}

