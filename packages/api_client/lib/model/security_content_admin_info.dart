//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SecurityContentAdminInfo {
  /// Returns a new [SecurityContentAdminInfo] instance.
  SecurityContentAdminInfo({
    this.content,
    this.securityContentVerified,
    this.securityContentVerifiedManual,
  });

  MyContentInfo? content;

  bool? securityContentVerified;

  bool? securityContentVerifiedManual;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SecurityContentAdminInfo &&
    other.content == content &&
    other.securityContentVerified == securityContentVerified &&
    other.securityContentVerifiedManual == securityContentVerifiedManual;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content == null ? 0 : content!.hashCode) +
    (securityContentVerified == null ? 0 : securityContentVerified!.hashCode) +
    (securityContentVerifiedManual == null ? 0 : securityContentVerifiedManual!.hashCode);

  @override
  String toString() => 'SecurityContentAdminInfo[content=$content, securityContentVerified=$securityContentVerified, securityContentVerifiedManual=$securityContentVerifiedManual]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.content != null) {
      json[r'content'] = this.content;
    } else {
      json[r'content'] = null;
    }
    if (this.securityContentVerified != null) {
      json[r'security_content_verified'] = this.securityContentVerified;
    } else {
      json[r'security_content_verified'] = null;
    }
    if (this.securityContentVerifiedManual != null) {
      json[r'security_content_verified_manual'] = this.securityContentVerifiedManual;
    } else {
      json[r'security_content_verified_manual'] = null;
    }
    return json;
  }

  /// Returns a new [SecurityContentAdminInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SecurityContentAdminInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SecurityContentAdminInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SecurityContentAdminInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SecurityContentAdminInfo(
        content: MyContentInfo.fromJson(json[r'content']),
        securityContentVerified: mapValueOfType<bool>(json, r'security_content_verified'),
        securityContentVerifiedManual: mapValueOfType<bool>(json, r'security_content_verified_manual'),
      );
    }
    return null;
  }

  static List<SecurityContentAdminInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SecurityContentAdminInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SecurityContentAdminInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SecurityContentAdminInfo> mapFromJson(dynamic json) {
    final map = <String, SecurityContentAdminInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SecurityContentAdminInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SecurityContentAdminInfo-objects as value to a dart map
  static Map<String, List<SecurityContentAdminInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SecurityContentAdminInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SecurityContentAdminInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

