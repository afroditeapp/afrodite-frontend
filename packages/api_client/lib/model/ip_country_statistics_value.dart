//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IpCountryStatisticsValue {
  /// Returns a new [IpCountryStatisticsValue] instance.
  IpCountryStatisticsValue({
    required this.c,
    this.t,
  });

  int c;

  /// Value exists when [GetIpCountryStatisticsSettings::live_statistics] is false.
  UnixTime? t;

  @override
  bool operator ==(Object other) => identical(this, other) || other is IpCountryStatisticsValue &&
    other.c == c &&
    other.t == t;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c.hashCode) +
    (t == null ? 0 : t!.hashCode);

  @override
  String toString() => 'IpCountryStatisticsValue[c=$c, t=$t]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c'] = this.c;
    if (this.t != null) {
      json[r't'] = this.t;
    } else {
      json[r't'] = null;
    }
    return json;
  }

  /// Returns a new [IpCountryStatisticsValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IpCountryStatisticsValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "IpCountryStatisticsValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "IpCountryStatisticsValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IpCountryStatisticsValue(
        c: mapValueOfType<int>(json, r'c')!,
        t: UnixTime.fromJson(json[r't']),
      );
    }
    return null;
  }

  static List<IpCountryStatisticsValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IpCountryStatisticsValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IpCountryStatisticsValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IpCountryStatisticsValue> mapFromJson(dynamic json) {
    final map = <String, IpCountryStatisticsValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IpCountryStatisticsValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IpCountryStatisticsValue-objects as value to a dart map
  static Map<String, List<IpCountryStatisticsValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<IpCountryStatisticsValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IpCountryStatisticsValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c',
  };
}

