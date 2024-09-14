//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SecurityContent {
  /// Returns a new [SecurityContent] instance.
  SecurityContent({
    this.c0,
  });

  ContentInfo? c0;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SecurityContent &&
    other.c0 == c0;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c0 == null ? 0 : c0!.hashCode);

  @override
  String toString() => 'SecurityContent[c0=$c0]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.c0 != null) {
      json[r'c0'] = this.c0;
    } else {
      json[r'c0'] = null;
    }
    return json;
  }

  /// Returns a new [SecurityContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SecurityContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SecurityContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SecurityContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SecurityContent(
        c0: ContentInfo.fromJson(json[r'c0']),
      );
    }
    return null;
  }

  static List<SecurityContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SecurityContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SecurityContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SecurityContent> mapFromJson(dynamic json) {
    final map = <String, SecurityContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SecurityContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SecurityContent-objects as value to a dart map
  static Map<String, List<SecurityContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SecurityContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SecurityContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

