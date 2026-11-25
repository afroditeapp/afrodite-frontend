//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendFeedbackResult {
  /// Returns a new [SendFeedbackResult] instance.
  SendFeedbackResult({
    this.error = false,
    this.errorBodyTooLong = false,
    this.errorEmailSendingFailed = false,
    this.errorUnknownCategory = false,
  });

  bool error;

  /// The feedback body is longer than the configured limit.
  bool errorBodyTooLong;

  /// Email sending failed.
  bool errorEmailSendingFailed;

  /// The category key is not in the current server config. The client should fetch the feedback config again.
  bool errorUnknownCategory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendFeedbackResult &&
    other.error == error &&
    other.errorBodyTooLong == errorBodyTooLong &&
    other.errorEmailSendingFailed == errorEmailSendingFailed &&
    other.errorUnknownCategory == errorUnknownCategory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorBodyTooLong.hashCode) +
    (errorEmailSendingFailed.hashCode) +
    (errorUnknownCategory.hashCode);

  @override
  String toString() => 'SendFeedbackResult[error=$error, errorBodyTooLong=$errorBodyTooLong, errorEmailSendingFailed=$errorEmailSendingFailed, errorUnknownCategory=$errorUnknownCategory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'error_body_too_long'] = this.errorBodyTooLong;
      json[r'error_email_sending_failed'] = this.errorEmailSendingFailed;
      json[r'error_unknown_category'] = this.errorUnknownCategory;
    return json;
  }

  /// Returns a new [SendFeedbackResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendFeedbackResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return SendFeedbackResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorBodyTooLong: mapValueOfType<bool>(json, r'error_body_too_long') ?? false,
        errorEmailSendingFailed: mapValueOfType<bool>(json, r'error_email_sending_failed') ?? false,
        errorUnknownCategory: mapValueOfType<bool>(json, r'error_unknown_category') ?? false,
      );
    }
    return null;
  }

  static List<SendFeedbackResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendFeedbackResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendFeedbackResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendFeedbackResult> mapFromJson(dynamic json) {
    final map = <String, SendFeedbackResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendFeedbackResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendFeedbackResult-objects as value to a dart map
  static Map<String, List<SendFeedbackResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendFeedbackResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendFeedbackResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

