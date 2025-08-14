//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostStartDataExport {
  /// Returns a new [PostStartDataExport] instance.
  PostStartDataExport({
    required this.dataExportType,
    required this.source_,
  });

  DataExportType dataExportType;

  /// Data reading source account.
  AccountId source_;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostStartDataExport &&
    other.dataExportType == dataExportType &&
    other.source_ == source_;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dataExportType.hashCode) +
    (source_.hashCode);

  @override
  String toString() => 'PostStartDataExport[dataExportType=$dataExportType, source_=$source_]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data_export_type'] = this.dataExportType;
      json[r'source'] = this.source_;
    return json;
  }

  /// Returns a new [PostStartDataExport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostStartDataExport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostStartDataExport[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostStartDataExport[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostStartDataExport(
        dataExportType: DataExportType.fromJson(json[r'data_export_type'])!,
        source_: AccountId.fromJson(json[r'source'])!,
      );
    }
    return null;
  }

  static List<PostStartDataExport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostStartDataExport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostStartDataExport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostStartDataExport> mapFromJson(dynamic json) {
    final map = <String, PostStartDataExport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostStartDataExport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostStartDataExport-objects as value to a dart map
  static Map<String, List<PostStartDataExport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostStartDataExport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostStartDataExport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data_export_type',
    'source',
  };
}

