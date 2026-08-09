//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PutSignInWithApple {
  /// Returns a new [PutSignInWithApple] instance.
  PutSignInWithApple({
    this.apple,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SignInWithAppleInfo? apple;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PutSignInWithApple &&
    other.apple == apple;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (apple == null ? 0 : apple!.hashCode);

  @override
  String toString() => 'PutSignInWithApple[apple=$apple]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.apple != null) {
      json[r'apple'] = this.apple;
    } else {
      json[r'apple'] = null;
    }
    return json;
  }

  /// Returns a new [PutSignInWithApple] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PutSignInWithApple? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return PutSignInWithApple(
        apple: SignInWithAppleInfo.fromJson(json[r'apple']),
      );
    }
    return null;
  }

  static List<PutSignInWithApple> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PutSignInWithApple>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PutSignInWithApple.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PutSignInWithApple> mapFromJson(dynamic json) {
    final map = <String, PutSignInWithApple>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PutSignInWithApple.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PutSignInWithApple-objects as value to a dart map
  static Map<String, List<PutSignInWithApple>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PutSignInWithApple>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PutSignInWithApple.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

