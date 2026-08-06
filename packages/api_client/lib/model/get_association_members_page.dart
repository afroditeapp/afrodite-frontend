//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetAssociationMembersPage {
  /// Returns a new [GetAssociationMembersPage] instance.
  GetAssociationMembersPage({
    required this.page,
  });

  int page;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetAssociationMembersPage &&
    other.page == page;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (page.hashCode);

  @override
  String toString() => 'GetAssociationMembersPage[page=$page]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'page'] = this.page;
    return json;
  }

  /// Returns a new [GetAssociationMembersPage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetAssociationMembersPage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'page'), 'Required key "GetAssociationMembersPage[page]" is missing from JSON.');
        assert(json[r'page'] != null, 'Required key "GetAssociationMembersPage[page]" has a null value in JSON.');
        return true;
      }());

      return GetAssociationMembersPage(
        page: mapValueOfType<int>(json, r'page')!,
      );
    }
    return null;
  }

  static List<GetAssociationMembersPage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetAssociationMembersPage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetAssociationMembersPage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetAssociationMembersPage> mapFromJson(dynamic json) {
    final map = <String, GetAssociationMembersPage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetAssociationMembersPage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetAssociationMembersPage-objects as value to a dart map
  static Map<String, List<GetAssociationMembersPage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetAssociationMembersPage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetAssociationMembersPage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'page',
  };
}

