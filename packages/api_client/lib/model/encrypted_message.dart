//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EncryptedMessage {
  /// Returns a new [EncryptedMessage] instance.
  EncryptedMessage({
    required this.pgpMessage,
    required this.version,
  });

  String pgpMessage;

  /// Encryption version
  int version;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EncryptedMessage &&
     other.pgpMessage == pgpMessage &&
     other.version == version;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (pgpMessage.hashCode) +
    (version.hashCode);

  @override
  String toString() => 'EncryptedMessage[pgpMessage=$pgpMessage, version=$version]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'pgp_message'] = this.pgpMessage;
      json[r'version'] = this.version;
    return json;
  }

  /// Returns a new [EncryptedMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EncryptedMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "EncryptedMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "EncryptedMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return EncryptedMessage(
        pgpMessage: mapValueOfType<String>(json, r'pgp_message')!,
        version: mapValueOfType<int>(json, r'version')!,
      );
    }
    return null;
  }

  static List<EncryptedMessage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EncryptedMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EncryptedMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EncryptedMessage> mapFromJson(dynamic json) {
    final map = <String, EncryptedMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EncryptedMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EncryptedMessage-objects as value to a dart map
  static Map<String, List<EncryptedMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EncryptedMessage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EncryptedMessage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'pgp_message',
    'version',
  };
}

