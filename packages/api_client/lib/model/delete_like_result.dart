//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeleteLikeResult {
  /// Returns a new [DeleteLikeResult] instance.
  DeleteLikeResult({
    this.errorAccountInteractionStateMismatch,
    this.errorDeleteAlreadyDoneBefore = false,
  });

  CurrentAccountInteractionState? errorAccountInteractionStateMismatch;

  /// The account tracking for delete like only tracks the latest deleter account, so it is possible that this error resets if delete like target account likes and removes the like.
  bool errorDeleteAlreadyDoneBefore;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeleteLikeResult &&
    other.errorAccountInteractionStateMismatch == errorAccountInteractionStateMismatch &&
    other.errorDeleteAlreadyDoneBefore == errorDeleteAlreadyDoneBefore;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorAccountInteractionStateMismatch == null ? 0 : errorAccountInteractionStateMismatch!.hashCode) +
    (errorDeleteAlreadyDoneBefore.hashCode);

  @override
  String toString() => 'DeleteLikeResult[errorAccountInteractionStateMismatch=$errorAccountInteractionStateMismatch, errorDeleteAlreadyDoneBefore=$errorDeleteAlreadyDoneBefore]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.errorAccountInteractionStateMismatch != null) {
      json[r'error_account_interaction_state_mismatch'] = this.errorAccountInteractionStateMismatch;
    } else {
      json[r'error_account_interaction_state_mismatch'] = null;
    }
      json[r'error_delete_already_done_before'] = this.errorDeleteAlreadyDoneBefore;
    return json;
  }

  /// Returns a new [DeleteLikeResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeleteLikeResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DeleteLikeResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteLikeResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DeleteLikeResult(
        errorAccountInteractionStateMismatch: CurrentAccountInteractionState.fromJson(json[r'error_account_interaction_state_mismatch']),
        errorDeleteAlreadyDoneBefore: mapValueOfType<bool>(json, r'error_delete_already_done_before') ?? false,
      );
    }
    return null;
  }

  static List<DeleteLikeResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeleteLikeResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeleteLikeResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeleteLikeResult> mapFromJson(dynamic json) {
    final map = <String, DeleteLikeResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeleteLikeResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeleteLikeResult-objects as value to a dart map
  static Map<String, List<DeleteLikeResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeleteLikeResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeleteLikeResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

