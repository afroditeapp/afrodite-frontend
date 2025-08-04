//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IpCountryStatistics {
  /// Returns a new [IpCountryStatistics] instance.
  IpCountryStatistics({
    required this.country,
    this.values = const [],
  });

  String country;

  List<IpCountryStatisticsValue> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is IpCountryStatistics &&
    other.country == country &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (country.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'IpCountryStatistics[country=$country, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'country'] = this.country;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [IpCountryStatistics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IpCountryStatistics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "IpCountryStatistics[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "IpCountryStatistics[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IpCountryStatistics(
        country: mapValueOfType<String>(json, r'country')!,
        values: IpCountryStatisticsValue.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<IpCountryStatistics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IpCountryStatistics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IpCountryStatistics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IpCountryStatistics> mapFromJson(dynamic json) {
    final map = <String, IpCountryStatistics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IpCountryStatistics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IpCountryStatistics-objects as value to a dart map
  static Map<String, List<IpCountryStatistics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<IpCountryStatistics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IpCountryStatistics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'country',
    'values',
  };
}

