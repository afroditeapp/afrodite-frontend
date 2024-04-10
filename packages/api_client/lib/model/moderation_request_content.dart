//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ModerationRequestContent {
  /// Returns a new [ModerationRequestContent] instance.
  ModerationRequestContent({
    required this.content0,
    this.content1,
    this.content2,
    this.content3,
    this.content4,
    this.content5,
    this.content6,
  });

  ContentId content0;

  ContentId? content1;

  ContentId? content2;

  ContentId? content3;

  ContentId? content4;

  ContentId? content5;

  ContentId? content6;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ModerationRequestContent &&
     other.content0 == content0 &&
     other.content1 == content1 &&
     other.content2 == content2 &&
     other.content3 == content3 &&
     other.content4 == content4 &&
     other.content5 == content5 &&
     other.content6 == content6;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content0.hashCode) +
    (content1 == null ? 0 : content1!.hashCode) +
    (content2 == null ? 0 : content2!.hashCode) +
    (content3 == null ? 0 : content3!.hashCode) +
    (content4 == null ? 0 : content4!.hashCode) +
    (content5 == null ? 0 : content5!.hashCode) +
    (content6 == null ? 0 : content6!.hashCode);

  @override
  String toString() => 'ModerationRequestContent[content0=$content0, content1=$content1, content2=$content2, content3=$content3, content4=$content4, content5=$content5, content6=$content6]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content0'] = this.content0;
    if (this.content1 != null) {
      json[r'content1'] = this.content1;
    } else {
      json[r'content1'] = null;
    }
    if (this.content2 != null) {
      json[r'content2'] = this.content2;
    } else {
      json[r'content2'] = null;
    }
    if (this.content3 != null) {
      json[r'content3'] = this.content3;
    } else {
      json[r'content3'] = null;
    }
    if (this.content4 != null) {
      json[r'content4'] = this.content4;
    } else {
      json[r'content4'] = null;
    }
    if (this.content5 != null) {
      json[r'content5'] = this.content5;
    } else {
      json[r'content5'] = null;
    }
    if (this.content6 != null) {
      json[r'content6'] = this.content6;
    } else {
      json[r'content6'] = null;
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
        content0: ContentId.fromJson(json[r'content0'])!,
        content1: ContentId.fromJson(json[r'content1']),
        content2: ContentId.fromJson(json[r'content2']),
        content3: ContentId.fromJson(json[r'content3']),
        content4: ContentId.fromJson(json[r'content4']),
        content5: ContentId.fromJson(json[r'content5']),
        content6: ContentId.fromJson(json[r'content6']),
      );
    }
    return null;
  }

  static List<ModerationRequestContent>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ModerationRequestContent.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content0',
  };
}

