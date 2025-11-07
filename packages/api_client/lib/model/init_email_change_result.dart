//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InitEmailChangeResult {
  /// Returns a new [InitEmailChangeResult] instance.
  InitEmailChangeResult({
    this.error = false,
    this.errorEmailSendingFailed = false,
    this.errorEmailSendingTimeout = false,
    this.errorTryAgainLaterAfterSeconds,
  });

  bool error;

  bool errorEmailSendingFailed;

  bool errorEmailSendingTimeout;

  /// Minimum value: 0
  int? errorTryAgainLaterAfterSeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InitEmailChangeResult &&
    other.error == error &&
    other.errorEmailSendingFailed == errorEmailSendingFailed &&
    other.errorEmailSendingTimeout == errorEmailSendingTimeout &&
    other.errorTryAgainLaterAfterSeconds == errorTryAgainLaterAfterSeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorEmailSendingFailed.hashCode) +
    (errorEmailSendingTimeout.hashCode) +
    (errorTryAgainLaterAfterSeconds == null ? 0 : errorTryAgainLaterAfterSeconds!.hashCode);

  @override
  String toString() => 'InitEmailChangeResult[error=$error, errorEmailSendingFailed=$errorEmailSendingFailed, errorEmailSendingTimeout=$errorEmailSendingTimeout, errorTryAgainLaterAfterSeconds=$errorTryAgainLaterAfterSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'error_email_sending_failed'] = this.errorEmailSendingFailed;
      json[r'error_email_sending_timeout'] = this.errorEmailSendingTimeout;
    if (this.errorTryAgainLaterAfterSeconds != null) {
      json[r'error_try_again_later_after_seconds'] = this.errorTryAgainLaterAfterSeconds;
    } else {
      json[r'error_try_again_later_after_seconds'] = null;
    }
    return json;
  }

  /// Returns a new [InitEmailChangeResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InitEmailChangeResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "InitEmailChangeResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "InitEmailChangeResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InitEmailChangeResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorEmailSendingFailed: mapValueOfType<bool>(json, r'error_email_sending_failed') ?? false,
        errorEmailSendingTimeout: mapValueOfType<bool>(json, r'error_email_sending_timeout') ?? false,
        errorTryAgainLaterAfterSeconds: mapValueOfType<int>(json, r'error_try_again_later_after_seconds'),
      );
    }
    return null;
  }

  static List<InitEmailChangeResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InitEmailChangeResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InitEmailChangeResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InitEmailChangeResult> mapFromJson(dynamic json) {
    final map = <String, InitEmailChangeResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InitEmailChangeResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InitEmailChangeResult-objects as value to a dart map
  static Map<String, List<InitEmailChangeResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InitEmailChangeResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InitEmailChangeResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

