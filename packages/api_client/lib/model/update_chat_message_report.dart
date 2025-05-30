//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateChatMessageReport {
  /// Returns a new [UpdateChatMessageReport] instance.
  UpdateChatMessageReport({
    required this.backendSignedMessageBase64,
    required this.decryptionKeyBase64,
    required this.target,
  });

  String backendSignedMessageBase64;

  String decryptionKeyBase64;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateChatMessageReport &&
    other.backendSignedMessageBase64 == backendSignedMessageBase64 &&
    other.decryptionKeyBase64 == decryptionKeyBase64 &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (backendSignedMessageBase64.hashCode) +
    (decryptionKeyBase64.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateChatMessageReport[backendSignedMessageBase64=$backendSignedMessageBase64, decryptionKeyBase64=$decryptionKeyBase64, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'backend_signed_message_base64'] = this.backendSignedMessageBase64;
      json[r'decryption_key_base64'] = this.decryptionKeyBase64;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateChatMessageReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateChatMessageReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateChatMessageReport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateChatMessageReport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateChatMessageReport(
        backendSignedMessageBase64: mapValueOfType<String>(json, r'backend_signed_message_base64')!,
        decryptionKeyBase64: mapValueOfType<String>(json, r'decryption_key_base64')!,
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateChatMessageReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateChatMessageReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateChatMessageReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateChatMessageReport> mapFromJson(dynamic json) {
    final map = <String, UpdateChatMessageReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateChatMessageReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateChatMessageReport-objects as value to a dart map
  static Map<String, List<UpdateChatMessageReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateChatMessageReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateChatMessageReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'backend_signed_message_base64',
    'decryption_key_base64',
    'target',
  };
}

