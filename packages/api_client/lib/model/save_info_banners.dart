//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SaveInfoBanners {
  /// Returns a new [SaveInfoBanners] instance.
  SaveInfoBanners({
    this.current,
    required this.new_,
  });

  InfoBannersConfig? current;

  InfoBannersConfig new_;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SaveInfoBanners &&
    other.current == current &&
    other.new_ == new_;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (current == null ? 0 : current!.hashCode) +
    (new_.hashCode);

  @override
  String toString() => 'SaveInfoBanners[current=$current, new_=$new_]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.current != null) {
      json[r'current'] = this.current;
    } else {
      json[r'current'] = null;
    }
      json[r'new'] = this.new_;
    return json;
  }

  /// Returns a new [SaveInfoBanners] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SaveInfoBanners? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SaveInfoBanners[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SaveInfoBanners[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SaveInfoBanners(
        current: InfoBannersConfig.fromJson(json[r'current']),
        new_: InfoBannersConfig.fromJson(json[r'new'])!,
      );
    }
    return null;
  }

  static List<SaveInfoBanners> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveInfoBanners>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveInfoBanners.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SaveInfoBanners> mapFromJson(dynamic json) {
    final map = <String, SaveInfoBanners>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SaveInfoBanners.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SaveInfoBanners-objects as value to a dart map
  static Map<String, List<SaveInfoBanners>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SaveInfoBanners>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SaveInfoBanners.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'new',
  };
}

