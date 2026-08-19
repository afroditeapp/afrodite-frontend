//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class EmailRegistrationDomainLists {
  /// Returns a new [EmailRegistrationDomainLists] instance.
  EmailRegistrationDomainLists({
    this.allowlist = const [],
    this.blocklist = const [],
  });

  /// If non-empty, only email domains in this list are accepted for email registration. Values are lowercased and trimmed when the config is saved.
  List<String> allowlist;

  /// Email domains in this list are rejected for email registration. Values are lowercased and trimmed when the config is saved.
  List<String> blocklist;

  @override
  bool operator ==(Object other) => identical(this, other) || other is EmailRegistrationDomainLists &&
    _deepEquality.equals(other.allowlist, allowlist) &&
    _deepEquality.equals(other.blocklist, blocklist);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (allowlist.hashCode) +
    (blocklist.hashCode);

  @override
  String toString() => 'EmailRegistrationDomainLists[allowlist=$allowlist, blocklist=$blocklist]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'allowlist'] = this.allowlist;
      json[r'blocklist'] = this.blocklist;
    return json;
  }

  /// Returns a new [EmailRegistrationDomainLists] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static EmailRegistrationDomainLists? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return EmailRegistrationDomainLists(
        allowlist: json[r'allowlist'] is Iterable
            ? (json[r'allowlist'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        blocklist: json[r'blocklist'] is Iterable
            ? (json[r'blocklist'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<EmailRegistrationDomainLists> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <EmailRegistrationDomainLists>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = EmailRegistrationDomainLists.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, EmailRegistrationDomainLists> mapFromJson(dynamic json) {
    final map = <String, EmailRegistrationDomainLists>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = EmailRegistrationDomainLists.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of EmailRegistrationDomainLists-objects as value to a dart map
  static Map<String, List<EmailRegistrationDomainLists>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<EmailRegistrationDomainLists>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = EmailRegistrationDomainLists.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

