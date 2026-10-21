//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestationRequirements {
  /// Returns a new [AppAttestationRequirements] instance.
  AppAttestationRequirements({
    this.androidAppIntegrity = false,
    this.androidDeviceIntegrity = false,
    this.iosValidToken = false,
  });

  /// Android: require Play Integrity API app integrity verdict.
  bool androidAppIntegrity;

  /// Android: require Play Integrity API device integrity verdict.
  bool androidDeviceIntegrity;

  /// iOS: require valid Apple App Attest token.
  bool iosValidToken;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppAttestationRequirements &&
    other.androidAppIntegrity == androidAppIntegrity &&
    other.androidDeviceIntegrity == androidDeviceIntegrity &&
    other.iosValidToken == iosValidToken;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (androidAppIntegrity.hashCode) +
    (androidDeviceIntegrity.hashCode) +
    (iosValidToken.hashCode);

  @override
  String toString() => 'AppAttestationRequirements[androidAppIntegrity=$androidAppIntegrity, androidDeviceIntegrity=$androidDeviceIntegrity, iosValidToken=$iosValidToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'android_app_integrity'] = this.androidAppIntegrity;
      json[r'android_device_integrity'] = this.androidDeviceIntegrity;
      json[r'ios_valid_token'] = this.iosValidToken;
    return json;
  }

  /// Returns a new [AppAttestationRequirements] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestationRequirements? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return AppAttestationRequirements(
        androidAppIntegrity: mapValueOfType<bool>(json, r'android_app_integrity') ?? false,
        androidDeviceIntegrity: mapValueOfType<bool>(json, r'android_device_integrity') ?? false,
        iosValidToken: mapValueOfType<bool>(json, r'ios_valid_token') ?? false,
      );
    }
    return null;
  }

  static List<AppAttestationRequirements> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AppAttestationRequirements>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestationRequirements.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestationRequirements> mapFromJson(dynamic json) {
    final map = <String, AppAttestationRequirements>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestationRequirements.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestationRequirements-objects as value to a dart map
  static Map<String, List<AppAttestationRequirements>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AppAttestationRequirements>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestationRequirements.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

