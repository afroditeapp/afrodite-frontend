//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteStatus {
  /// Returns a new [DeleteStatus] instance.
  DeleteStatus({
    required this.deleteDate,
  });

  String deleteDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteStatus &&
     other.deleteDate == deleteDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (deleteDate.hashCode);

  @override
  String toString() => 'DeleteStatus[deleteDate=$deleteDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'delete_date'] = this.deleteDate;
    return json;
  }

  /// Returns a new [DeleteStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteStatus(
        deleteDate: mapValueOfType<String>(json, r'delete_date')!,
      );
    }
    return null;
  }

  static List<DeleteStatus>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteStatus> mapFromJson(dynamic json) {
    final map = <String, DeleteStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteStatus-objects as value to a dart map
  static Map<String, List<DeleteStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteStatus>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteStatus.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'delete_date',
  };
}

