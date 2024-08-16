//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Moderation {
  /// Returns a new [Moderation] instance.
  Moderation({
    required this.content,
    required this.moderatorId,
    required this.requestCreatorId,
    required this.requestId,
  });

  ModerationRequestContent content;

  AccountId moderatorId;

  AccountId requestCreatorId;

  ModerationRequestId requestId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Moderation &&
    other.content == content &&
    other.moderatorId == moderatorId &&
    other.requestCreatorId == requestCreatorId &&
    other.requestId == requestId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (moderatorId.hashCode) +
    (requestCreatorId.hashCode) +
    (requestId.hashCode);

  @override
  String toString() => 'Moderation[content=$content, moderatorId=$moderatorId, requestCreatorId=$requestCreatorId, requestId=$requestId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'moderator_id'] = this.moderatorId;
      json[r'request_creator_id'] = this.requestCreatorId;
      json[r'request_id'] = this.requestId;
    return json;
  }

  /// Returns a new [Moderation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Moderation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Moderation[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Moderation[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Moderation(
        content: ModerationRequestContent.fromJson(json[r'content'])!,
        moderatorId: AccountId.fromJson(json[r'moderator_id'])!,
        requestCreatorId: AccountId.fromJson(json[r'request_creator_id'])!,
        requestId: ModerationRequestId.fromJson(json[r'request_id'])!,
      );
    }
    return null;
  }

  static List<Moderation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Moderation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Moderation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Moderation> mapFromJson(dynamic json) {
    final map = <String, Moderation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Moderation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Moderation-objects as value to a dart map
  static Map<String, List<Moderation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Moderation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Moderation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'moderator_id',
    'request_creator_id',
    'request_id',
  };
}

