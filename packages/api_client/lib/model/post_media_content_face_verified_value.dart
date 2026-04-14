//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostMediaContentFaceVerifiedValue {
  /// Returns a new [PostMediaContentFaceVerifiedValue] instance.
  PostMediaContentFaceVerifiedValue({
    required this.accountId,
    required this.securityContent,
    this.values = const [],
  });

  AccountId accountId;

  ContentId securityContent;

  List<PostMediaContentFaceVerifiedValueItem> values;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostMediaContentFaceVerifiedValue &&
    other.accountId == accountId &&
    other.securityContent == securityContent &&
    _deepEquality.equals(other.values, values);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (securityContent.hashCode) +
    (values.hashCode);

  @override
  String toString() => 'PostMediaContentFaceVerifiedValue[accountId=$accountId, securityContent=$securityContent, values=$values]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'security_content'] = this.securityContent;
      json[r'values'] = this.values;
    return json;
  }

  /// Returns a new [PostMediaContentFaceVerifiedValue] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostMediaContentFaceVerifiedValue? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostMediaContentFaceVerifiedValue[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostMediaContentFaceVerifiedValue[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostMediaContentFaceVerifiedValue(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        securityContent: ContentId.fromJson(json[r'security_content'])!,
        values: PostMediaContentFaceVerifiedValueItem.listFromJson(json[r'values']),
      );
    }
    return null;
  }

  static List<PostMediaContentFaceVerifiedValue> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostMediaContentFaceVerifiedValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostMediaContentFaceVerifiedValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostMediaContentFaceVerifiedValue> mapFromJson(dynamic json) {
    final map = <String, PostMediaContentFaceVerifiedValue>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostMediaContentFaceVerifiedValue.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostMediaContentFaceVerifiedValue-objects as value to a dart map
  static Map<String, List<PostMediaContentFaceVerifiedValue>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostMediaContentFaceVerifiedValue>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostMediaContentFaceVerifiedValue.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'security_content',
    'values',
  };
}

