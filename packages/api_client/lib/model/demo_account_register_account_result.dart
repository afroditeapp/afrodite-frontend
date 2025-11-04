//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DemoAccountRegisterAccountResult {
  /// Returns a new [DemoAccountRegisterAccountResult] instance.
  DemoAccountRegisterAccountResult({
    this.aid,
    this.errorMaxAccountCount = false,
  });

  /// Account ID if registration was successful
  AccountId? aid;

  /// True when the demo account has reached its maximum account limit
  bool errorMaxAccountCount;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DemoAccountRegisterAccountResult &&
    other.aid == aid &&
    other.errorMaxAccountCount == errorMaxAccountCount;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (aid == null ? 0 : aid!.hashCode) +
    (errorMaxAccountCount.hashCode);

  @override
  String toString() => 'DemoAccountRegisterAccountResult[aid=$aid, errorMaxAccountCount=$errorMaxAccountCount]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.aid != null) {
      json[r'aid'] = this.aid;
    } else {
      json[r'aid'] = null;
    }
      json[r'error_max_account_count'] = this.errorMaxAccountCount;
    return json;
  }

  /// Returns a new [DemoAccountRegisterAccountResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DemoAccountRegisterAccountResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DemoAccountRegisterAccountResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DemoAccountRegisterAccountResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DemoAccountRegisterAccountResult(
        aid: AccountId.fromJson(json[r'aid']),
        errorMaxAccountCount: mapValueOfType<bool>(json, r'error_max_account_count') ?? false,
      );
    }
    return null;
  }

  static List<DemoAccountRegisterAccountResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DemoAccountRegisterAccountResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DemoAccountRegisterAccountResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DemoAccountRegisterAccountResult> mapFromJson(dynamic json) {
    final map = <String, DemoAccountRegisterAccountResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DemoAccountRegisterAccountResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DemoAccountRegisterAccountResult-objects as value to a dart map
  static Map<String, List<DemoAccountRegisterAccountResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DemoAccountRegisterAccountResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DemoAccountRegisterAccountResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

