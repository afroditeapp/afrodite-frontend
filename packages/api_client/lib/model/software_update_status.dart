//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SoftwareUpdateStatus {
  /// Returns a new [SoftwareUpdateStatus] instance.
  SoftwareUpdateStatus({
    this.downloaded,
    this.installed,
    required this.state,
  });

  SoftwareInfo? downloaded;

  SoftwareInfo? installed;

  SoftwareUpdateState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SoftwareUpdateStatus &&
    other.downloaded == downloaded &&
    other.installed == installed &&
    other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (downloaded == null ? 0 : downloaded!.hashCode) +
    (installed == null ? 0 : installed!.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'SoftwareUpdateStatus[downloaded=$downloaded, installed=$installed, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.downloaded != null) {
      json[r'downloaded'] = this.downloaded;
    } else {
      json[r'downloaded'] = null;
    }
    if (this.installed != null) {
      json[r'installed'] = this.installed;
    } else {
      json[r'installed'] = null;
    }
      json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [SoftwareUpdateStatus] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SoftwareUpdateStatus? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SoftwareUpdateStatus[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SoftwareUpdateStatus[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SoftwareUpdateStatus(
        downloaded: SoftwareInfo.fromJson(json[r'downloaded']),
        installed: SoftwareInfo.fromJson(json[r'installed']),
        state: SoftwareUpdateState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<SoftwareUpdateStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoftwareUpdateStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoftwareUpdateStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SoftwareUpdateStatus> mapFromJson(dynamic json) {
    final map = <String, SoftwareUpdateStatus>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SoftwareUpdateStatus.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SoftwareUpdateStatus-objects as value to a dart map
  static Map<String, List<SoftwareUpdateStatus>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SoftwareUpdateStatus>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SoftwareUpdateStatus.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'state',
  };
}

