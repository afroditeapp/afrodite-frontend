//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PortNumber {
  /// Returns a new [PortNumber] instance.
  PortNumber({
    required this.port,
  });

  int port;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PortNumber &&
    other.port == port;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (port.hashCode);

  @override
  String toString() => 'PortNumber[port=$port]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'port'] = this.port;
    return json;
  }

  /// Returns a new [PortNumber] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PortNumber? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'port'), 'Required key "PortNumber[port]" is missing from JSON.');
        assert(json[r'port'] != null, 'Required key "PortNumber[port]" has a null value in JSON.');
        return true;
      }());

      return PortNumber(
        port: mapValueOfType<int>(json, r'port')!,
      );
    }
    return null;
  }

  static List<PortNumber> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PortNumber>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PortNumber.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PortNumber> mapFromJson(dynamic json) {
    final map = <String, PortNumber>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PortNumber.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PortNumber-objects as value to a dart map
  static Map<String, List<PortNumber>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PortNumber>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PortNumber.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'port',
  };
}

