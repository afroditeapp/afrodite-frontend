//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddFavoriteProfileResult {
  /// Returns a new [AddFavoriteProfileResult] instance.
  AddFavoriteProfileResult({
    this.error = false,
    this.errorTooManyFavorites = false,
    this.remainingFavoritesCount,
  });

  bool error;

  /// No space for more favorite profiles.
  bool errorTooManyFavorites;

  /// Remaining favorites count. The value will be returned only if there is 5 or less favorites left.
  ///
  /// Minimum value: 0
  int? remainingFavoritesCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddFavoriteProfileResult &&
    other.error == error &&
    other.errorTooManyFavorites == errorTooManyFavorites &&
    other.remainingFavoritesCount == remainingFavoritesCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (errorTooManyFavorites.hashCode) +
    (remainingFavoritesCount == null ? 0 : remainingFavoritesCount!.hashCode);

  @override
  String toString() => 'AddFavoriteProfileResult[error=$error, errorTooManyFavorites=$errorTooManyFavorites, remainingFavoritesCount=$remainingFavoritesCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'error_too_many_favorites'] = this.errorTooManyFavorites;
    if (this.remainingFavoritesCount != null) {
      json[r'remaining_favorites_count'] = this.remainingFavoritesCount;
    } else {
      json[r'remaining_favorites_count'] = null;
    }
    return json;
  }

  /// Returns a new [AddFavoriteProfileResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddFavoriteProfileResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AddFavoriteProfileResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AddFavoriteProfileResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AddFavoriteProfileResult(
        error: mapValueOfType<bool>(json, r'error') ?? false,
        errorTooManyFavorites: mapValueOfType<bool>(json, r'error_too_many_favorites') ?? false,
        remainingFavoritesCount: mapValueOfType<int>(json, r'remaining_favorites_count'),
      );
    }
    return null;
  }

  static List<AddFavoriteProfileResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddFavoriteProfileResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddFavoriteProfileResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddFavoriteProfileResult> mapFromJson(dynamic json) {
    final map = <String, AddFavoriteProfileResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddFavoriteProfileResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddFavoriteProfileResult-objects as value to a dart map
  static Map<String, List<AddFavoriteProfileResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddFavoriteProfileResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AddFavoriteProfileResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

