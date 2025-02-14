//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AccountReportContent {
  /// Returns a new [AccountReportContent] instance.
  AccountReportContent({
    this.details,
    this.isBot = false,
    this.isScammer = false,
    this.isSpammer = false,
    this.isUnderaged = false,
  });

  String? details;

  bool isBot;

  bool isScammer;

  bool isSpammer;

  bool isUnderaged;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AccountReportContent &&
    other.details == details &&
    other.isBot == isBot &&
    other.isScammer == isScammer &&
    other.isSpammer == isSpammer &&
    other.isUnderaged == isUnderaged;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (details == null ? 0 : details!.hashCode) +
    (isBot.hashCode) +
    (isScammer.hashCode) +
    (isSpammer.hashCode) +
    (isUnderaged.hashCode);

  @override
  String toString() => 'AccountReportContent[details=$details, isBot=$isBot, isScammer=$isScammer, isSpammer=$isSpammer, isUnderaged=$isUnderaged]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.details != null) {
      json[r'details'] = this.details;
    } else {
      json[r'details'] = null;
    }
      json[r'is_bot'] = this.isBot;
      json[r'is_scammer'] = this.isScammer;
      json[r'is_spammer'] = this.isSpammer;
      json[r'is_underaged'] = this.isUnderaged;
    return json;
  }

  /// Returns a new [AccountReportContent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AccountReportContent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AccountReportContent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AccountReportContent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AccountReportContent(
        details: mapValueOfType<String>(json, r'details'),
        isBot: mapValueOfType<bool>(json, r'is_bot') ?? false,
        isScammer: mapValueOfType<bool>(json, r'is_scammer') ?? false,
        isSpammer: mapValueOfType<bool>(json, r'is_spammer') ?? false,
        isUnderaged: mapValueOfType<bool>(json, r'is_underaged') ?? false,
      );
    }
    return null;
  }

  static List<AccountReportContent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AccountReportContent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AccountReportContent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AccountReportContent> mapFromJson(dynamic json) {
    final map = <String, AccountReportContent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AccountReportContent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AccountReportContent-objects as value to a dart map
  static Map<String, List<AccountReportContent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AccountReportContent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AccountReportContent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

