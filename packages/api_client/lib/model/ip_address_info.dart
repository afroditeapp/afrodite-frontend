//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IpAddressInfo {
  /// Returns a new [IpAddressInfo] instance.
  IpAddressInfo({
    required this.a,
    required this.c,
    required this.f,
    required this.l,
    this.lists = const [],
  });

  /// IP address
  String a;

  /// Usage count
  int c;

  /// First usage time
  UnixTime f;

  /// Latest usage time
  UnixTime l;

  /// IP list names. IP address belongs to these IP lists.
  List<String> lists;

  @override
  bool operator ==(Object other) => identical(this, other) || other is IpAddressInfo &&
    other.a == a &&
    other.c == c &&
    other.f == f &&
    other.l == l &&
    _deepEquality.equals(other.lists, lists);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (a.hashCode) +
    (c.hashCode) +
    (f.hashCode) +
    (l.hashCode) +
    (lists.hashCode);

  @override
  String toString() => 'IpAddressInfo[a=$a, c=$c, f=$f, l=$l, lists=$lists]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'a'] = this.a;
      json[r'c'] = this.c;
      json[r'f'] = this.f;
      json[r'l'] = this.l;
      json[r'lists'] = this.lists;
    return json;
  }

  /// Returns a new [IpAddressInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IpAddressInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "IpAddressInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "IpAddressInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IpAddressInfo(
        a: mapValueOfType<String>(json, r'a')!,
        c: mapValueOfType<int>(json, r'c')!,
        f: UnixTime.fromJson(json[r'f'])!,
        l: UnixTime.fromJson(json[r'l'])!,
        lists: json[r'lists'] is Iterable
            ? (json[r'lists'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<IpAddressInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <IpAddressInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IpAddressInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IpAddressInfo> mapFromJson(dynamic json) {
    final map = <String, IpAddressInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IpAddressInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IpAddressInfo-objects as value to a dart map
  static Map<String, List<IpAddressInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<IpAddressInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IpAddressInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'a',
    'c',
    'f',
    'l',
  };
}

