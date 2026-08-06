//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminBotNsfwDetectionConfig {
  /// Returns a new [AdminBotNsfwDetectionConfig] instance.
  AdminBotNsfwDetectionConfig({
    required this.accept,
    required this.delete,
    required this.moveToHuman,
    required this.reject,
  });

  /// Thresholds for accepting the image.
  NsfwDetectionThresholds accept;

  /// Thresholds for image deletion.
  NsfwDetectionThresholds delete;

  /// Thresholds for moving image to human moderation.
  NsfwDetectionThresholds moveToHuman;

  /// Thresholds for image rejection.
  NsfwDetectionThresholds reject;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminBotNsfwDetectionConfig &&
    other.accept == accept &&
    other.delete == delete &&
    other.moveToHuman == moveToHuman &&
    other.reject == reject;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accept.hashCode) +
    (delete.hashCode) +
    (moveToHuman.hashCode) +
    (reject.hashCode);

  @override
  String toString() => 'AdminBotNsfwDetectionConfig[accept=$accept, delete=$delete, moveToHuman=$moveToHuman, reject=$reject]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept'] = this.accept;
      json[r'delete'] = this.delete;
      json[r'move_to_human'] = this.moveToHuman;
      json[r'reject'] = this.reject;
    return json;
  }

  /// Returns a new [AdminBotNsfwDetectionConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminBotNsfwDetectionConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accept'), 'Required key "AdminBotNsfwDetectionConfig[accept]" is missing from JSON.');
        assert(json[r'accept'] != null, 'Required key "AdminBotNsfwDetectionConfig[accept]" has a null value in JSON.');
        assert(json.containsKey(r'delete'), 'Required key "AdminBotNsfwDetectionConfig[delete]" is missing from JSON.');
        assert(json[r'delete'] != null, 'Required key "AdminBotNsfwDetectionConfig[delete]" has a null value in JSON.');
        assert(json.containsKey(r'move_to_human'), 'Required key "AdminBotNsfwDetectionConfig[move_to_human]" is missing from JSON.');
        assert(json[r'move_to_human'] != null, 'Required key "AdminBotNsfwDetectionConfig[move_to_human]" has a null value in JSON.');
        assert(json.containsKey(r'reject'), 'Required key "AdminBotNsfwDetectionConfig[reject]" is missing from JSON.');
        assert(json[r'reject'] != null, 'Required key "AdminBotNsfwDetectionConfig[reject]" has a null value in JSON.');
        return true;
      }());

      return AdminBotNsfwDetectionConfig(
        accept: NsfwDetectionThresholds.fromJson(json[r'accept'])!,
        delete: NsfwDetectionThresholds.fromJson(json[r'delete'])!,
        moveToHuman: NsfwDetectionThresholds.fromJson(json[r'move_to_human'])!,
        reject: NsfwDetectionThresholds.fromJson(json[r'reject'])!,
      );
    }
    return null;
  }

  static List<AdminBotNsfwDetectionConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminBotNsfwDetectionConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminBotNsfwDetectionConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminBotNsfwDetectionConfig> mapFromJson(dynamic json) {
    final map = <String, AdminBotNsfwDetectionConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminBotNsfwDetectionConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminBotNsfwDetectionConfig-objects as value to a dart map
  static Map<String, List<AdminBotNsfwDetectionConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminBotNsfwDetectionConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminBotNsfwDetectionConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept',
    'delete',
    'move_to_human',
    'reject',
  };
}

