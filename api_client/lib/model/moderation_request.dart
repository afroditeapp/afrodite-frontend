//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ModerationRequest {
  /// Returns a new [ModerationRequest] instance.
  ModerationRequest({
    required this.content,
    required this.state,
  });

  ModerationRequestContent content;

  ModerationRequestState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ModerationRequest &&
     other.content == content &&
     other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'ModerationRequest[content=$content, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [ModerationRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ModerationRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ModerationRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ModerationRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ModerationRequest(
        content: ModerationRequestContent.fromJson(json[r'content'])!,
        state: ModerationRequestState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<ModerationRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ModerationRequest> mapFromJson(dynamic json) {
    final map = <String, ModerationRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ModerationRequest-objects as value to a dart map
  static Map<String, List<ModerationRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ModerationRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequest.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'state',
  };
}

