//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentInfoDetailed {
  /// Returns a new [ContentInfoDetailed] instance.
  ContentInfoDetailed({
    required this.contentType,
    required this.id,
    required this.secureCapture,
    this.slot,
    required this.state,
  });

  MediaContentType contentType;

  ContentId id;

  bool secureCapture;

  ContentSlot? slot;

  ContentState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentInfoDetailed &&
     other.contentType == contentType &&
     other.id == id &&
     other.secureCapture == secureCapture &&
     other.slot == slot &&
     other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentType.hashCode) +
    (id.hashCode) +
    (secureCapture.hashCode) +
    (slot == null ? 0 : slot!.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'ContentInfoDetailed[contentType=$contentType, id=$id, secureCapture=$secureCapture, slot=$slot, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_type'] = this.contentType;
      json[r'id'] = this.id;
      json[r'secure_capture'] = this.secureCapture;
    if (this.slot != null) {
      json[r'slot'] = this.slot;
    } else {
      json[r'slot'] = null;
    }
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [ContentInfoDetailed] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentInfoDetailed? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentInfoDetailed[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentInfoDetailed[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentInfoDetailed(
        contentType: MediaContentType.fromJson(json[r'content_type'])!,
        id: ContentId.fromJson(json[r'id'])!,
        secureCapture: mapValueOfType<bool>(json, r'secure_capture')!,
        slot: ContentSlot.fromJson(json[r'slot']),
        state: ContentState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<ContentInfoDetailed>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentInfoDetailed>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentInfoDetailed.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentInfoDetailed> mapFromJson(dynamic json) {
    final map = <String, ContentInfoDetailed>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfoDetailed.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentInfoDetailed-objects as value to a dart map
  static Map<String, List<ContentInfoDetailed>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentInfoDetailed>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfoDetailed.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_type',
    'id',
    'secure_capture',
    'state',
  };
}

