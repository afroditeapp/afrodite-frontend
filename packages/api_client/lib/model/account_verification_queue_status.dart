//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountVerificationQueueStatus {
  /// Returns a new [AccountVerificationQueueStatus] instance.
  AccountVerificationQueueStatus({
    this.queuePosition,
    required this.verificationErrorFlags,
    this.verificationMethod,
    this.verificationUnixTime,
  });

  /// The first queue position is 1
  ///
  /// Minimum value: 0
  int? queuePosition;

  /// Empty flags value means there are no known verification errors.
  AccountVerificationErrorFlagsValue verificationErrorFlags;

  VerificationMethod? verificationMethod;

  UnixTime? verificationUnixTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountVerificationQueueStatus &&
    other.queuePosition == queuePosition &&
    other.verificationErrorFlags == verificationErrorFlags &&
    other.verificationMethod == verificationMethod &&
    other.verificationUnixTime == verificationUnixTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (queuePosition == null ? 0 : queuePosition!.hashCode) +
    (verificationErrorFlags.hashCode) +
    (verificationMethod == null ? 0 : verificationMethod!.hashCode) +
    (verificationUnixTime == null ? 0 : verificationUnixTime!.hashCode);

  @override
  String toString() => 'AccountVerificationQueueStatus[queuePosition=$queuePosition, verificationErrorFlags=$verificationErrorFlags, verificationMethod=$verificationMethod, verificationUnixTime=$verificationUnixTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.queuePosition != null) {
      json[r'queue_position'] = this.queuePosition;
    } else {
      json[r'queue_position'] = null;
    }
      json[r'verification_error_flags'] = this.verificationErrorFlags;
    if (this.verificationMethod != null) {
      json[r'verification_method'] = this.verificationMethod;
    } else {
      json[r'verification_method'] = null;
    }
    if (this.verificationUnixTime != null) {
      json[r'verification_unix_time'] = this.verificationUnixTime;
    } else {
      json[r'verification_unix_time'] = null;
    }
    return json;
  }

  /// Returns a new [AccountVerificationQueueStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountVerificationQueueStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountVerificationQueueStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountVerificationQueueStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountVerificationQueueStatus(
        queuePosition: mapValueOfType<int>(json, r'queue_position'),
        verificationErrorFlags: AccountVerificationErrorFlagsValue.fromJson(json[r'verification_error_flags'])!,
        verificationMethod: VerificationMethod.fromJson(json[r'verification_method']),
        verificationUnixTime: UnixTime.fromJson(json[r'verification_unix_time']),
      );
    }
    return null;
  }

  static List<AccountVerificationQueueStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountVerificationQueueStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountVerificationQueueStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountVerificationQueueStatus> mapFromJson(dynamic json) {
    final map = <String, AccountVerificationQueueStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountVerificationQueueStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountVerificationQueueStatus-objects as value to a dart map
  static Map<String, List<AccountVerificationQueueStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountVerificationQueueStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountVerificationQueueStatus.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'verification_error_flags',
  };
}

