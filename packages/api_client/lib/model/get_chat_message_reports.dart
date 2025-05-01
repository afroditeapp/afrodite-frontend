//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetChatMessageReports {
  /// Returns a new [GetChatMessageReports] instance.
  GetChatMessageReports({
    required this.creator,
    required this.onlyNotProcessed,
    required this.target,
  });

  AccountId creator;

  bool onlyNotProcessed;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetChatMessageReports &&
    other.creator == creator &&
    other.onlyNotProcessed == onlyNotProcessed &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (creator.hashCode) +
    (onlyNotProcessed.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'GetChatMessageReports[creator=$creator, onlyNotProcessed=$onlyNotProcessed, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'creator'] = this.creator;
      json[r'only_not_processed'] = this.onlyNotProcessed;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [GetChatMessageReports] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetChatMessageReports? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetChatMessageReports[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetChatMessageReports[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetChatMessageReports(
        creator: AccountId.fromJson(json[r'creator'])!,
        onlyNotProcessed: mapValueOfType<bool>(json, r'only_not_processed')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<GetChatMessageReports> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetChatMessageReports>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetChatMessageReports.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetChatMessageReports> mapFromJson(dynamic json) {
    final map = <String, GetChatMessageReports>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetChatMessageReports.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetChatMessageReports-objects as value to a dart map
  static Map<String, List<GetChatMessageReports>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetChatMessageReports>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetChatMessageReports.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'creator',
    'only_not_processed',
    'target',
  };
}

