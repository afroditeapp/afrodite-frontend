//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LatestViewedMessageChanged {
  /// Returns a new [LatestViewedMessageChanged] instance.
  LatestViewedMessageChanged({
    required this.newLatestViewedMessage,
    required this.viewer,
  });

  MessageNumber newLatestViewedMessage;

  AccountId viewer;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LatestViewedMessageChanged &&
    other.newLatestViewedMessage == newLatestViewedMessage &&
    other.viewer == viewer;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newLatestViewedMessage.hashCode) +
    (viewer.hashCode);

  @override
  String toString() => 'LatestViewedMessageChanged[newLatestViewedMessage=$newLatestViewedMessage, viewer=$viewer]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'new_latest_viewed_message'] = this.newLatestViewedMessage;
      json[r'viewer'] = this.viewer;
    return json;
  }

  /// Returns a new [LatestViewedMessageChanged] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LatestViewedMessageChanged? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "LatestViewedMessageChanged[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "LatestViewedMessageChanged[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return LatestViewedMessageChanged(
        newLatestViewedMessage: MessageNumber.fromJson(json[r'new_latest_viewed_message'])!,
        viewer: AccountId.fromJson(json[r'viewer'])!,
      );
    }
    return null;
  }

  static List<LatestViewedMessageChanged> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LatestViewedMessageChanged>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LatestViewedMessageChanged.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LatestViewedMessageChanged> mapFromJson(dynamic json) {
    final map = <String, LatestViewedMessageChanged>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LatestViewedMessageChanged.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LatestViewedMessageChanged-objects as value to a dart map
  static Map<String, List<LatestViewedMessageChanged>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LatestViewedMessageChanged>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LatestViewedMessageChanged.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'new_latest_viewed_message',
    'viewer',
  };
}

