//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostMediaContentFaceVerifiedValueItem {
  /// Returns a new [PostMediaContentFaceVerifiedValueItem] instance.
  PostMediaContentFaceVerifiedValueItem({
    required this.contentId,
    this.value,
  });

  ContentId contentId;

  /// Bot sets automatic face verification value. Human admin sets manual override value. Set to None to clear the currently applicable value.
  bool? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostMediaContentFaceVerifiedValueItem &&
    other.contentId == contentId &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (contentId.hashCode) +
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'PostMediaContentFaceVerifiedValueItem[contentId=$contentId, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content_id'] = this.contentId;
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    return json;
  }

  /// Returns a new [PostMediaContentFaceVerifiedValueItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostMediaContentFaceVerifiedValueItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostMediaContentFaceVerifiedValueItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostMediaContentFaceVerifiedValueItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostMediaContentFaceVerifiedValueItem(
        contentId: ContentId.fromJson(json[r'content_id'])!,
        value: mapValueOfType<bool>(json, r'value'),
      );
    }
    return null;
  }

  static List<PostMediaContentFaceVerifiedValueItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostMediaContentFaceVerifiedValueItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostMediaContentFaceVerifiedValueItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostMediaContentFaceVerifiedValueItem> mapFromJson(dynamic json) {
    final map = <String, PostMediaContentFaceVerifiedValueItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostMediaContentFaceVerifiedValueItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostMediaContentFaceVerifiedValueItem-objects as value to a dart map
  static Map<String, List<PostMediaContentFaceVerifiedValueItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostMediaContentFaceVerifiedValueItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostMediaContentFaceVerifiedValueItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content_id',
  };
}

