//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendLike {
  /// Returns a new [SendLike] instance.
  SendLike({
    required this.accountId,
    this.allowMatching = false,
  });

  AccountId accountId;

  bool allowMatching;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendLike &&
    other.accountId == accountId &&
    other.allowMatching == allowMatching;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accountId.hashCode) +
    (allowMatching.hashCode);

  @override
  String toString() => 'SendLike[accountId=$accountId, allowMatching=$allowMatching]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'account_id'] = this.accountId;
      json[r'allow_matching'] = this.allowMatching;
    return json;
  }

  /// Returns a new [SendLike] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendLike? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendLike[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendLike[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendLike(
        accountId: AccountId.fromJson(json[r'account_id'])!,
        allowMatching: mapValueOfType<bool>(json, r'allow_matching') ?? false,
      );
    }
    return null;
  }

  static List<SendLike> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendLike>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendLike.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendLike> mapFromJson(dynamic json) {
    final map = <String, SendLike>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendLike.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendLike-objects as value to a dart map
  static Map<String, List<SendLike>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendLike>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendLike.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'account_id',
  };
}

