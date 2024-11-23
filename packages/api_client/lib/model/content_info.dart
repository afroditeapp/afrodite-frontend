//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentInfo {
  /// Returns a new [ContentInfo] instance.
  ContentInfo({
    required this.cid,
    required this.ctype,
    required this.fd,
  });

  ContentId cid;

  MediaContentType ctype;

  /// Face detected
  bool fd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentInfo &&
    other.cid == cid &&
    other.ctype == ctype &&
    other.fd == fd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cid.hashCode) +
    (ctype.hashCode) +
    (fd.hashCode);

  @override
  String toString() => 'ContentInfo[cid=$cid, ctype=$ctype, fd=$fd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'cid'] = this.cid;
      json[r'ctype'] = this.ctype;
      json[r'fd'] = this.fd;
    return json;
  }

  /// Returns a new [ContentInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentInfo(
        cid: ContentId.fromJson(json[r'cid'])!,
        ctype: MediaContentType.fromJson(json[r'ctype'])!,
        fd: mapValueOfType<bool>(json, r'fd')!,
      );
    }
    return null;
  }

  static List<ContentInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentInfo> mapFromJson(dynamic json) {
    final map = <String, ContentInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentInfo-objects as value to a dart map
  static Map<String, List<ContentInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ContentInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'cid',
    'ctype',
    'fd',
  };
}

