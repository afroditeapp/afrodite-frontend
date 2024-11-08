//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostModerateProfileText {
  /// Returns a new [PostModerateProfileText] instance.
  PostModerateProfileText({
    required this.accept,
    required this.id,
    this.rejectedCategory,
    this.rejectedDetails,
    required this.text,
  });

  bool accept;

  AccountId id;

  ProfileTextModerationRejectedReasonCategory? rejectedCategory;

  ProfileTextModerationRejectedReasonDetails? rejectedDetails;

  String text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostModerateProfileText &&
    other.accept == accept &&
    other.id == id &&
    other.rejectedCategory == rejectedCategory &&
    other.rejectedDetails == rejectedDetails &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accept.hashCode) +
    (id.hashCode) +
    (rejectedCategory == null ? 0 : rejectedCategory!.hashCode) +
    (rejectedDetails == null ? 0 : rejectedDetails!.hashCode) +
    (text.hashCode);

  @override
  String toString() => 'PostModerateProfileText[accept=$accept, id=$id, rejectedCategory=$rejectedCategory, rejectedDetails=$rejectedDetails, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accept'] = this.accept;
      json[r'id'] = this.id;
    if (this.rejectedCategory != null) {
      json[r'rejected_category'] = this.rejectedCategory;
    } else {
      json[r'rejected_category'] = null;
    }
    if (this.rejectedDetails != null) {
      json[r'rejected_details'] = this.rejectedDetails;
    } else {
      json[r'rejected_details'] = null;
    }
      json[r'text'] = this.text;
    return json;
  }

  /// Returns a new [PostModerateProfileText] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostModerateProfileText? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostModerateProfileText[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostModerateProfileText[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostModerateProfileText(
        accept: mapValueOfType<bool>(json, r'accept')!,
        id: AccountId.fromJson(json[r'id'])!,
        rejectedCategory: ProfileTextModerationRejectedReasonCategory.fromJson(json[r'rejected_category']),
        rejectedDetails: ProfileTextModerationRejectedReasonDetails.fromJson(json[r'rejected_details']),
        text: mapValueOfType<String>(json, r'text')!,
      );
    }
    return null;
  }

  static List<PostModerateProfileText> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostModerateProfileText>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostModerateProfileText.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostModerateProfileText> mapFromJson(dynamic json) {
    final map = <String, PostModerateProfileText>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostModerateProfileText.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostModerateProfileText-objects as value to a dart map
  static Map<String, List<PostModerateProfileText>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostModerateProfileText>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostModerateProfileText.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accept',
    'id',
    'text',
  };
}

