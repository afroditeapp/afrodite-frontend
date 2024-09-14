//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ModerationRequestContent {
  /// Returns a new [ModerationRequestContent] instance.
  ModerationRequestContent({
    required this.c0,
    this.c1,
    this.c2,
    this.c3,
    this.c4,
    this.c5,
    this.c6,
  });

  ContentId c0;

  ContentId? c1;

  ContentId? c2;

  ContentId? c3;

  ContentId? c4;

  ContentId? c5;

  ContentId? c6;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ModerationRequestContent &&
    other.c0 == c0 &&
    other.c1 == c1 &&
    other.c2 == c2 &&
    other.c3 == c3 &&
    other.c4 == c4 &&
    other.c5 == c5 &&
    other.c6 == c6;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (c0.hashCode) +
    (c1 == null ? 0 : c1!.hashCode) +
    (c2 == null ? 0 : c2!.hashCode) +
    (c3 == null ? 0 : c3!.hashCode) +
    (c4 == null ? 0 : c4!.hashCode) +
    (c5 == null ? 0 : c5!.hashCode) +
    (c6 == null ? 0 : c6!.hashCode);

  @override
  String toString() => 'ModerationRequestContent[c0=$c0, c1=$c1, c2=$c2, c3=$c3, c4=$c4, c5=$c5, c6=$c6]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'c0'] = this.c0;
    if (this.c1 != null) {
      json[r'c1'] = this.c1;
    } else {
      json[r'c1'] = null;
    }
    if (this.c2 != null) {
      json[r'c2'] = this.c2;
    } else {
      json[r'c2'] = null;
    }
    if (this.c3 != null) {
      json[r'c3'] = this.c3;
    } else {
      json[r'c3'] = null;
    }
    if (this.c4 != null) {
      json[r'c4'] = this.c4;
    } else {
      json[r'c4'] = null;
    }
    if (this.c5 != null) {
      json[r'c5'] = this.c5;
    } else {
      json[r'c5'] = null;
    }
    if (this.c6 != null) {
      json[r'c6'] = this.c6;
    } else {
      json[r'c6'] = null;
    }
    return json;
  }

  /// Returns a new [ModerationRequestContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ModerationRequestContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ModerationRequestContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ModerationRequestContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ModerationRequestContent(
        c0: ContentId.fromJson(json[r'c0'])!,
        c1: ContentId.fromJson(json[r'c1']),
        c2: ContentId.fromJson(json[r'c2']),
        c3: ContentId.fromJson(json[r'c3']),
        c4: ContentId.fromJson(json[r'c4']),
        c5: ContentId.fromJson(json[r'c5']),
        c6: ContentId.fromJson(json[r'c6']),
      );
    }
    return null;
  }

  static List<ModerationRequestContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ModerationRequestContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ModerationRequestContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ModerationRequestContent> mapFromJson(dynamic json) {
    final map = <String, ModerationRequestContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequestContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ModerationRequestContent-objects as value to a dart map
  static Map<String, List<ModerationRequestContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ModerationRequestContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ModerationRequestContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'c0',
  };
}

