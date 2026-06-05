//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateChatMessageReports {
  /// Returns a new [UpdateChatMessageReports] instance.
  UpdateChatMessageReports({
    this.messages = const [],
    required this.target,
  });

  List<ChatMessageReportData> messages;

  AccountId target;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateChatMessageReports &&
    _deepEquality.equals(other.messages, messages) &&
    other.target == target;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (messages.hashCode) +
    (target.hashCode);

  @override
  String toString() => 'UpdateChatMessageReports[messages=$messages, target=$target]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'messages'] = this.messages;
      json[r'target'] = this.target;
    return json;
  }

  /// Returns a new [UpdateChatMessageReports] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateChatMessageReports? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateChatMessageReports[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateChatMessageReports[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateChatMessageReports(
        messages: ChatMessageReportData.listFromJson(json[r'messages']),
        target: AccountId.fromJson(json[r'target'])!,
      );
    }
    return null;
  }

  static List<UpdateChatMessageReports> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateChatMessageReports>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateChatMessageReports.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateChatMessageReports> mapFromJson(dynamic json) {
    final map = <String, UpdateChatMessageReports>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateChatMessageReports.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateChatMessageReports-objects as value to a dart map
  static Map<String, List<UpdateChatMessageReports>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateChatMessageReports>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateChatMessageReports.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'messages',
    'target',
  };
}

