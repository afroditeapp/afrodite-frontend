//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostAccountVerificationQueueRemoveNextItem {
  /// Returns a new [PostAccountVerificationQueueRemoveNextItem] instance.
  PostAccountVerificationQueueRemoveNextItem({
    required this.accountId,
    this.edit,
    required this.verificationErrorFlags,
  });

  AccountId accountId;

  EditVerificationValues? edit;

  AccountVerificationErrorFlagsValue verificationErrorFlags;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostAccountVerificationQueueRemoveNextItem &&
    other.accountId == accountId &&
    other.edit == edit &&
    other.verificationErrorFlags == verificationErrorFlags;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (edit == null ? 0 : edit!.hashCode) +
    (verificationErrorFlags.hashCode);

  @override
  String toString() => 'PostAccountVerificationQueueRemoveNextItem[accountId=$accountId, edit=$edit, verificationErrorFlags=$verificationErrorFlags]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
    if (this.edit != null) {
      json[r'edit'] = this.edit;
    } else {
      json[r'edit'] = null;
    }
      json[r'verification_error_flags'] = this.verificationErrorFlags;
    return json;
  }

  /// Returns a new [PostAccountVerificationQueueRemoveNextItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostAccountVerificationQueueRemoveNextItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostAccountVerificationQueueRemoveNextItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostAccountVerificationQueueRemoveNextItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostAccountVerificationQueueRemoveNextItem(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        edit: EditVerificationValues.fromJson(json[r'edit']),
        verificationErrorFlags: AccountVerificationErrorFlagsValue.fromJson(json[r'verification_error_flags'])!,
      );
    }
    return null;
  }

  static List<PostAccountVerificationQueueRemoveNextItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostAccountVerificationQueueRemoveNextItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostAccountVerificationQueueRemoveNextItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostAccountVerificationQueueRemoveNextItem> mapFromJson(dynamic json) {
    final map = <String, PostAccountVerificationQueueRemoveNextItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostAccountVerificationQueueRemoveNextItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostAccountVerificationQueueRemoveNextItem-objects as value to a dart map
  static Map<String, List<PostAccountVerificationQueueRemoveNextItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostAccountVerificationQueueRemoveNextItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostAccountVerificationQueueRemoveNextItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
    'verification_error_flags',
  };
}

