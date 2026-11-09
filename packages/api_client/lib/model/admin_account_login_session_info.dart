//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminAccountLoginSessionInfo {
  /// Returns a new [AdminAccountLoginSessionInfo] instance.
  AdminAccountLoginSessionInfo({
    this.appAttestationAppIntegrity,
    this.appAttestationDeviceIntegrity,
    this.appAttestationFailed,
    this.appAttestationType,
    this.clientType,
    this.loginMethod,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? appAttestationAppIntegrity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? appAttestationDeviceIntegrity;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? appAttestationFailed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  AppAttestationTypeNumber? appAttestationType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ClientType? clientType;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  LoginMethod? loginMethod;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminAccountLoginSessionInfo &&
    other.appAttestationAppIntegrity == appAttestationAppIntegrity &&
    other.appAttestationDeviceIntegrity == appAttestationDeviceIntegrity &&
    other.appAttestationFailed == appAttestationFailed &&
    other.appAttestationType == appAttestationType &&
    other.clientType == clientType &&
    other.loginMethod == loginMethod;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (appAttestationAppIntegrity == null ? 0 : appAttestationAppIntegrity!.hashCode) +
    (appAttestationDeviceIntegrity == null ? 0 : appAttestationDeviceIntegrity!.hashCode) +
    (appAttestationFailed == null ? 0 : appAttestationFailed!.hashCode) +
    (appAttestationType == null ? 0 : appAttestationType!.hashCode) +
    (clientType == null ? 0 : clientType!.hashCode) +
    (loginMethod == null ? 0 : loginMethod!.hashCode);

  @override
  String toString() => 'AdminAccountLoginSessionInfo[appAttestationAppIntegrity=$appAttestationAppIntegrity, appAttestationDeviceIntegrity=$appAttestationDeviceIntegrity, appAttestationFailed=$appAttestationFailed, appAttestationType=$appAttestationType, clientType=$clientType, loginMethod=$loginMethod]';

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
    if (this.appAttestationType != null) {
      json[r'app_attestation_type'] = this.appAttestationType;
    } else {
      json[r'app_attestation_type'] = null;
    }
    if (this.clientType != null) {
      json[r'client_type'] = this.clientType;
    } else {
      json[r'client_type'] = null;
    }
    if (this.loginMethod != null) {
      json[r'login_method'] = this.loginMethod;
    } else {
      json[r'login_method'] = null;
    }
    return json;
  }

  /// Returns a new [AdminAccountLoginSessionInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminAccountLoginSessionInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return AdminAccountLoginSessionInfo(
        appAttestationAppIntegrity: mapValueOfType<bool>(json, r'app_attestation_app_integrity'),
        appAttestationDeviceIntegrity: mapValueOfType<bool>(json, r'app_attestation_device_integrity'),
        appAttestationFailed: mapValueOfType<bool>(json, r'app_attestation_failed'),
        appAttestationType: AppAttestationTypeNumber.fromJson(json[r'app_attestation_type']),
        clientType: ClientType.fromJson(json[r'client_type']),
        loginMethod: LoginMethod.fromJson(json[r'login_method']),
      );
    }
    return null;
  }

  static List<AdminAccountLoginSessionInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminAccountLoginSessionInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminAccountLoginSessionInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminAccountLoginSessionInfo> mapFromJson(dynamic json) {
    final map = <String, AdminAccountLoginSessionInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminAccountLoginSessionInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminAccountLoginSessionInfo-objects as value to a dart map
  static Map<String, List<AdminAccountLoginSessionInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminAccountLoginSessionInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminAccountLoginSessionInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

