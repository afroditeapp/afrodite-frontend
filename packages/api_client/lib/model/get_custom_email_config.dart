//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetCustomEmailConfig {
  /// Returns a new [GetCustomEmailConfig] instance.
  GetCustomEmailConfig({
    this.emailBodyIsHtml,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? emailBodyIsHtml;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetCustomEmailConfig &&
    other.emailBodyIsHtml == emailBodyIsHtml;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (emailBodyIsHtml == null ? 0 : emailBodyIsHtml!.hashCode);

  @override
  String toString() => 'GetCustomEmailConfig[emailBodyIsHtml=$emailBodyIsHtml]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.emailBodyIsHtml != null) {
      json[r'email_body_is_html'] = this.emailBodyIsHtml;
    } else {
      json[r'email_body_is_html'] = null;
    }
    return json;
  }

  /// Returns a new [GetCustomEmailConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetCustomEmailConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return GetCustomEmailConfig(
        emailBodyIsHtml: mapValueOfType<bool>(json, r'email_body_is_html'),
      );
    }
    return null;
  }

  static List<GetCustomEmailConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetCustomEmailConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetCustomEmailConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetCustomEmailConfig> mapFromJson(dynamic json) {
    final map = <String, GetCustomEmailConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetCustomEmailConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetCustomEmailConfig-objects as value to a dart map
  static Map<String, List<GetCustomEmailConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetCustomEmailConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetCustomEmailConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

