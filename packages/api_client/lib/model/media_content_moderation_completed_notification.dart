//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MediaContentModerationCompletedNotification {
  /// Returns a new [MediaContentModerationCompletedNotification] instance.
  MediaContentModerationCompletedNotification({
    required this.accepted,
    required this.acceptedViewed,
    required this.rejected,
    required this.rejectedViewed,
  });

  /// Wrapping notification ID
  int accepted;

  /// Wrapping notification ID
  int acceptedViewed;

  /// Wrapping notification ID
  int rejected;

  /// Wrapping notification ID
  int rejectedViewed;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MediaContentModerationCompletedNotification &&
    other.accepted == accepted &&
    other.acceptedViewed == acceptedViewed &&
    other.rejected == rejected &&
    other.rejectedViewed == rejectedViewed;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accepted.hashCode) +
    (acceptedViewed.hashCode) +
    (rejected.hashCode) +
    (rejectedViewed.hashCode);

  @override
  String toString() => 'MediaContentModerationCompletedNotification[accepted=$accepted, acceptedViewed=$acceptedViewed, rejected=$rejected, rejectedViewed=$rejectedViewed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accepted'] = this.accepted;
      json[r'accepted_viewed'] = this.acceptedViewed;
      json[r'rejected'] = this.rejected;
      json[r'rejected_viewed'] = this.rejectedViewed;
    return json;
  }

  /// Returns a new [MediaContentModerationCompletedNotification] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MediaContentModerationCompletedNotification? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MediaContentModerationCompletedNotification[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MediaContentModerationCompletedNotification[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MediaContentModerationCompletedNotification(
        accepted: mapValueOfType<int>(json, r'accepted')!,
        acceptedViewed: mapValueOfType<int>(json, r'accepted_viewed')!,
        rejected: mapValueOfType<int>(json, r'rejected')!,
        rejectedViewed: mapValueOfType<int>(json, r'rejected_viewed')!,
      );
    }
    return null;
  }

  static List<MediaContentModerationCompletedNotification> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MediaContentModerationCompletedNotification>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MediaContentModerationCompletedNotification.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MediaContentModerationCompletedNotification> mapFromJson(dynamic json) {
    final map = <String, MediaContentModerationCompletedNotification>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MediaContentModerationCompletedNotification.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MediaContentModerationCompletedNotification-objects as value to a dart map
  static Map<String, List<MediaContentModerationCompletedNotification>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MediaContentModerationCompletedNotification>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MediaContentModerationCompletedNotification.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accepted',
    'accepted_viewed',
    'rejected',
    'rejected_viewed',
  };
}

