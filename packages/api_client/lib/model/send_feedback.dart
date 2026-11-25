//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendFeedback {
  /// Returns a new [SendFeedback] instance.
  SendFeedback({
    required this.body,
    required this.categoryKey,
  });

  /// Feedback body string. The string must be non-empty after trimming.
  String body;

  /// Feedback category key from [model::FeedbackCategory::key].
  String categoryKey;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendFeedback &&
    other.body == body &&
    other.categoryKey == categoryKey;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (body.hashCode) +
    (categoryKey.hashCode);

  @override
  String toString() => 'SendFeedback[body=$body, categoryKey=$categoryKey]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'body'] = this.body;
      json[r'category_key'] = this.categoryKey;
    return json;
  }

  /// Returns a new [SendFeedback] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendFeedback? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'body'), 'Required key "SendFeedback[body]" is missing from JSON.');
        assert(json[r'body'] != null, 'Required key "SendFeedback[body]" has a null value in JSON.');
        assert(json.containsKey(r'category_key'), 'Required key "SendFeedback[category_key]" is missing from JSON.');
        assert(json[r'category_key'] != null, 'Required key "SendFeedback[category_key]" has a null value in JSON.');
        return true;
      }());

      return SendFeedback(
        body: mapValueOfType<String>(json, r'body')!,
        categoryKey: mapValueOfType<String>(json, r'category_key')!,
      );
    }
    return null;
  }

  static List<SendFeedback> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendFeedback>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendFeedback.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendFeedback> mapFromJson(dynamic json) {
    final map = <String, SendFeedback>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendFeedback.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendFeedback-objects as value to a dart map
  static Map<String, List<SendFeedback>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendFeedback>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendFeedback.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'body',
    'category_key',
  };
}

