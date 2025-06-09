//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MatchesPage {
  /// Returns a new [MatchesPage] instance.
  MatchesPage({
    this.errorInvalidIteratorSessionId = false,
    this.p = const [],
  });

  bool errorInvalidIteratorSessionId;

  List<ChatProfileLink> p;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MatchesPage &&
    other.errorInvalidIteratorSessionId == errorInvalidIteratorSessionId &&
    _deepEquality.equals(other.p, p);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorInvalidIteratorSessionId.hashCode) +
    (p.hashCode);

  @override
  String toString() => 'MatchesPage[errorInvalidIteratorSessionId=$errorInvalidIteratorSessionId, p=$p]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_invalid_iterator_session_id'] = this.errorInvalidIteratorSessionId;
      json[r'p'] = this.p;
    return json;
  }

  /// Returns a new [MatchesPage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MatchesPage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MatchesPage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MatchesPage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MatchesPage(
        errorInvalidIteratorSessionId: mapValueOfType<bool>(json, r'error_invalid_iterator_session_id') ?? false,
        p: ChatProfileLink.listFromJson(json[r'p']),
      );
    }
    return null;
  }

  static List<MatchesPage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MatchesPage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MatchesPage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MatchesPage> mapFromJson(dynamic json) {
    final map = <String, MatchesPage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MatchesPage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MatchesPage-objects as value to a dart map
  static Map<String, List<MatchesPage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MatchesPage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MatchesPage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'p',
  };
}

