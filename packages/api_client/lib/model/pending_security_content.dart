//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PendingSecurityContent {
  /// Returns a new [PendingSecurityContent] instance.
  PendingSecurityContent({
    this.contentId,
  });

  ContentInfo? contentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PendingSecurityContent &&
    other.contentId == contentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId == null ? 0 : contentId!.hashCode);

  @override
  String toString() => 'PendingSecurityContent[contentId=$contentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentId != null) {
      json[r'content_id'] = this.contentId;
    } else {
      json[r'content_id'] = null;
    }
    return json;
  }

  /// Returns a new [PendingSecurityContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PendingSecurityContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PendingSecurityContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PendingSecurityContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PendingSecurityContent(
        contentId: ContentInfo.fromJson(json[r'content_id']),
      );
    }
    return null;
  }

  static List<PendingSecurityContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PendingSecurityContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PendingSecurityContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PendingSecurityContent> mapFromJson(dynamic json) {
    final map = <String, PendingSecurityContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PendingSecurityContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PendingSecurityContent-objects as value to a dart map
  static Map<String, List<PendingSecurityContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PendingSecurityContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PendingSecurityContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

