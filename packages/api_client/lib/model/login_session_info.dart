//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class LoginSessionInfo {
  /// Returns a new [LoginSessionInfo] instance.
  LoginSessionInfo({
    this.appAttestationAppIntegrity,
    this.appAttestationDeviceIntegrity,
    this.appAttestationFailed,
    this.appAttestationTypeNumber,
    this.clientPlatform,
  });

  bool? appAttestationAppIntegrity;

  bool? appAttestationDeviceIntegrity;

  bool? appAttestationFailed;

  AppAttestationTypeNumber? appAttestationTypeNumber;

  ClientType? clientPlatform;

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoginSessionInfo &&
    other.appAttestationAppIntegrity == appAttestationAppIntegrity &&
    other.appAttestationDeviceIntegrity == appAttestationDeviceIntegrity &&
    other.appAttestationFailed == appAttestationFailed &&
    other.appAttestationTypeNumber == appAttestationTypeNumber &&
    other.clientPlatform == clientPlatform;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (appAttestationAppIntegrity == null ? 0 : appAttestationAppIntegrity!.hashCode) +
    (appAttestationDeviceIntegrity == null ? 0 : appAttestationDeviceIntegrity!.hashCode) +
    (appAttestationFailed == null ? 0 : appAttestationFailed!.hashCode) +
    (appAttestationTypeNumber == null ? 0 : appAttestationTypeNumber!.hashCode) +
    (clientPlatform == null ? 0 : clientPlatform!.hashCode);

  @override
  String toString() => 'LoginSessionInfo[appAttestationAppIntegrity=$appAttestationAppIntegrity, appAttestationDeviceIntegrity=$appAttestationDeviceIntegrity, appAttestationFailed=$appAttestationFailed, appAttestationTypeNumber=$appAttestationTypeNumber, clientPlatform=$clientPlatform]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.appAttestationAppIntegrity != null) {
      json[r'app_attestation_app_integrity'] = this.appAttestationAppIntegrity;
    } else {
      json[r'app_attestation_app_integrity'] = null;
    }
    if (this.appAttestationDeviceIntegrity != null) {
      json[r'app_attestation_device_integrity'] = this.appAttestationDeviceIntegrity;
    } else {
      json[r'app_attestation_device_integrity'] = null;
    }
    if (this.appAttestationFailed != null) {
      json[r'app_attestation_failed'] = this.appAttestationFailed;
    } else {
      json[r'app_attestation_failed'] = null;
    }
    if (this.appAttestationTypeNumber != null) {
      json[r'app_attestation_type_number'] = this.appAttestationTypeNumber;
    } else {
      json[r'app_attestation_type_number'] = null;
    }
    if (this.clientPlatform != null) {
      json[r'client_platform'] = this.clientPlatform;
    } else {
      json[r'client_platform'] = null;
    }
    return json;
  }

  /// Returns a new [LoginSessionInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static LoginSessionInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return LoginSessionInfo(
        appAttestationAppIntegrity: mapValueOfType<bool>(json, r'app_attestation_app_integrity'),
        appAttestationDeviceIntegrity: mapValueOfType<bool>(json, r'app_attestation_device_integrity'),
        appAttestationFailed: mapValueOfType<bool>(json, r'app_attestation_failed'),
        appAttestationTypeNumber: AppAttestationTypeNumber.fromJson(json[r'app_attestation_type_number']),
        clientPlatform: ClientType.fromJson(json[r'client_platform']),
      );
    }
    return null;
  }

  static List<LoginSessionInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <LoginSessionInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = LoginSessionInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, LoginSessionInfo> mapFromJson(dynamic json) {
    final map = <String, LoginSessionInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = LoginSessionInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of LoginSessionInfo-objects as value to a dart map
  static Map<String, List<LoginSessionInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<LoginSessionInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = LoginSessionInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

