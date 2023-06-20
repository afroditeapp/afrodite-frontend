//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SecurityImage {
  /// Returns a new [SecurityImage] instance.
  SecurityImage({
    this.contentId,
  });

  ContentId? contentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SecurityImage &&
     other.contentId == contentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId == null ? 0 : contentId!.hashCode);

  @override
  String toString() => 'SecurityImage[contentId=$contentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.contentId != null) {
      json[r'content_id'] = this.contentId;
    } else {
      json[r'content_id'] = null;
    }
    return json;
  }

  /// Returns a new [SecurityImage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SecurityImage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SecurityImage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SecurityImage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SecurityImage(
        contentId: ContentId.fromJson(json[r'content_id']),
      );
    }
    return null;
  }

  static List<SecurityImage>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SecurityImage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SecurityImage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SecurityImage> mapFromJson(dynamic json) {
    final map = <String, SecurityImage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SecurityImage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SecurityImage-objects as value to a dart map
  static Map<String, List<SecurityImage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SecurityImage>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SecurityImage.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

