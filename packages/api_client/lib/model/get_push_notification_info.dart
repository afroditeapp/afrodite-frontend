//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetPushNotificationInfo {
  /// Returns a new [GetPushNotificationInfo] instance.
  GetPushNotificationInfo({
    this.deviceToken,
    required this.syncVersion,
    this.vapidPublicKey,
  });

  PushNotificationDeviceToken? deviceToken;

  PushNotificationInfoSyncVersion syncVersion;

  /// Base64 encoded VAPID public key if web push notifications are enabled and current login session if from web client.
  VapidPublicKey? vapidPublicKey;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetPushNotificationInfo &&
    other.deviceToken == deviceToken &&
    other.syncVersion == syncVersion &&
    other.vapidPublicKey == vapidPublicKey;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (deviceToken == null ? 0 : deviceToken!.hashCode) +
    (syncVersion.hashCode) +
    (vapidPublicKey == null ? 0 : vapidPublicKey!.hashCode);

  @override
  String toString() => 'GetPushNotificationInfo[deviceToken=$deviceToken, syncVersion=$syncVersion, vapidPublicKey=$vapidPublicKey]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.deviceToken != null) {
      json[r'device_token'] = this.deviceToken;
    } else {
      json[r'device_token'] = null;
    }
      json[r'sync_version'] = this.syncVersion;
    if (this.vapidPublicKey != null) {
      json[r'vapid_public_key'] = this.vapidPublicKey;
    } else {
      json[r'vapid_public_key'] = null;
    }
    return json;
  }

  /// Returns a new [GetPushNotificationInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetPushNotificationInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetPushNotificationInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetPushNotificationInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetPushNotificationInfo(
        deviceToken: PushNotificationDeviceToken.fromJson(json[r'device_token']),
        syncVersion: PushNotificationInfoSyncVersion.fromJson(json[r'sync_version'])!,
        vapidPublicKey: VapidPublicKey.fromJson(json[r'vapid_public_key']),
      );
    }
    return null;
  }

  static List<GetPushNotificationInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetPushNotificationInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetPushNotificationInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetPushNotificationInfo> mapFromJson(dynamic json) {
    final map = <String, GetPushNotificationInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetPushNotificationInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetPushNotificationInfo-objects as value to a dart map
  static Map<String, List<GetPushNotificationInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetPushNotificationInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetPushNotificationInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sync_version',
  };
}

