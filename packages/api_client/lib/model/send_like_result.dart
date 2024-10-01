//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SendLikeResult {
  /// Returns a new [SendLikeResult] instance.
  SendLikeResult({
    this.errorAlreadyLiked = false,
    this.status,
  });

  bool errorAlreadyLiked;

  LimitedActionStatus? status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SendLikeResult &&
    other.errorAlreadyLiked == errorAlreadyLiked &&
    other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (errorAlreadyLiked.hashCode) +
    (status == null ? 0 : status!.hashCode);

  @override
  String toString() => 'SendLikeResult[errorAlreadyLiked=$errorAlreadyLiked, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error_already_liked'] = this.errorAlreadyLiked;
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    return json;
  }

  /// Returns a new [SendLikeResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SendLikeResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SendLikeResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SendLikeResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SendLikeResult(
        errorAlreadyLiked: mapValueOfType<bool>(json, r'error_already_liked') ?? false,
        status: LimitedActionStatus.fromJson(json[r'status']),
      );
    }
    return null;
  }

  static List<SendLikeResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SendLikeResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SendLikeResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SendLikeResult> mapFromJson(dynamic json) {
    final map = <String, SendLikeResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SendLikeResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SendLikeResult-objects as value to a dart map
  static Map<String, List<SendLikeResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SendLikeResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SendLikeResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

