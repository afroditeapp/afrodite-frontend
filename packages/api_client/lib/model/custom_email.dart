//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CustomEmail {
  /// Returns a new [CustomEmail] instance.
  CustomEmail({
    required this.id,
    this.sendingCompletedUnixTime,
    this.sendingInitiatedUnixTime,
    this.translations = const [],
  });

  CustomEmailId id;

  UnixTime? sendingCompletedUnixTime;

  UnixTime? sendingInitiatedUnixTime;

  List<CustomEmailTranslation> translations;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CustomEmail &&
    other.id == id &&
    other.sendingCompletedUnixTime == sendingCompletedUnixTime &&
    other.sendingInitiatedUnixTime == sendingInitiatedUnixTime &&
    _deepEquality.equals(other.translations, translations);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (sendingCompletedUnixTime == null ? 0 : sendingCompletedUnixTime!.hashCode) +
    (sendingInitiatedUnixTime == null ? 0 : sendingInitiatedUnixTime!.hashCode) +
    (translations.hashCode);

  @override
  String toString() => 'CustomEmail[id=$id, sendingCompletedUnixTime=$sendingCompletedUnixTime, sendingInitiatedUnixTime=$sendingInitiatedUnixTime, translations=$translations]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.sendingCompletedUnixTime != null) {
      json[r'sending_completed_unix_time'] = this.sendingCompletedUnixTime;
    } else {
      json[r'sending_completed_unix_time'] = null;
    }
    if (this.sendingInitiatedUnixTime != null) {
      json[r'sending_initiated_unix_time'] = this.sendingInitiatedUnixTime;
    } else {
      json[r'sending_initiated_unix_time'] = null;
    }
      json[r'translations'] = this.translations;
    return json;
  }

  /// Returns a new [CustomEmail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CustomEmail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CustomEmail[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CustomEmail[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CustomEmail(
        id: CustomEmailId.fromJson(json[r'id'])!,
        sendingCompletedUnixTime: UnixTime.fromJson(json[r'sending_completed_unix_time']),
        sendingInitiatedUnixTime: UnixTime.fromJson(json[r'sending_initiated_unix_time']),
        translations: CustomEmailTranslation.listFromJson(json[r'translations']),
      );
    }
    return null;
  }

  static List<CustomEmail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CustomEmail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CustomEmail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CustomEmail> mapFromJson(dynamic json) {
    final map = <String, CustomEmail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CustomEmail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CustomEmail-objects as value to a dart map
  static Map<String, List<CustomEmail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CustomEmail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CustomEmail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'translations',
  };
}

