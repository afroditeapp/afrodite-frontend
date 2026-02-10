//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingMessageAcknowledgementList {
  /// Returns a new [PendingMessageAcknowledgementList] instance.
  PendingMessageAcknowledgementList({
    this.deliveryFailed = false,
    this.ids = const [],
  });

  bool deliveryFailed;

  List<PendingMessageId> ids;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingMessageAcknowledgementList &&
    other.deliveryFailed == deliveryFailed &&
    _deepEquality.equals(other.ids, ids);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (deliveryFailed.hashCode) +
    (ids.hashCode);

  @override
  String toString() => 'PendingMessageAcknowledgementList[deliveryFailed=$deliveryFailed, ids=$ids]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'delivery_failed'] = this.deliveryFailed;
      json[r'ids'] = this.ids;
    return json;
  }

  /// Returns a new [PendingMessageAcknowledgementList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingMessageAcknowledgementList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingMessageAcknowledgementList[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingMessageAcknowledgementList[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingMessageAcknowledgementList(
        deliveryFailed: mapValueOfType<bool>(json, r'delivery_failed') ?? false,
        ids: PendingMessageId.listFromJson(json[r'ids']),
      );
    }
    return null;
  }

  static List<PendingMessageAcknowledgementList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingMessageAcknowledgementList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingMessageAcknowledgementList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingMessageAcknowledgementList> mapFromJson(dynamic json) {
    final map = <String, PendingMessageAcknowledgementList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingMessageAcknowledgementList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingMessageAcknowledgementList-objects as value to a dart map
  static Map<String, List<PendingMessageAcknowledgementList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingMessageAcknowledgementList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingMessageAcknowledgementList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'ids',
  };
}

