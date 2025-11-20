//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CheckOnlineStatusResponse {
  /// Returns a new [CheckOnlineStatusResponse] instance.
  CheckOnlineStatusResponse({
    required this.a,
    required this.l,
  });

  AccountId a;

  /// Account's most recent disconnect time.  If the last seen time is not None, then it is Unix timestamp or -1 if the profile is currently online.
  int l;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CheckOnlineStatusResponse &&
    other.a == a &&
    other.l == l;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a.hashCode) +
    (l.hashCode);

  @override
  String toString() => 'CheckOnlineStatusResponse[a=$a, l=$l]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'a'] = this.a;
      json[r'l'] = this.l;
    return json;
  }

  /// Returns a new [CheckOnlineStatusResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CheckOnlineStatusResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CheckOnlineStatusResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CheckOnlineStatusResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CheckOnlineStatusResponse(
        a: AccountId.fromJson(json[r'a'])!,
        l: mapValueOfType<int>(json, r'l')!,
      );
    }
    return null;
  }

  static List<CheckOnlineStatusResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckOnlineStatusResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckOnlineStatusResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CheckOnlineStatusResponse> mapFromJson(dynamic json) {
    final map = <String, CheckOnlineStatusResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckOnlineStatusResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CheckOnlineStatusResponse-objects as value to a dart map
  static Map<String, List<CheckOnlineStatusResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CheckOnlineStatusResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CheckOnlineStatusResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'a',
    'l',
  };
}

