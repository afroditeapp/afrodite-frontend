//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ContentProcessingState {
  /// Returns a new [ContentProcessingState] instance.
  ContentProcessingState({
    this.cid,
    required this.state,
    this.waitQueuePosition,
  });

  ContentId? cid;

  ContentProcessingStateType state;

  /// Current position in processing queue.  If ProcessingContentId is added to empty queue, then this will be 1.
  ///
  /// Minimum value: 0
  int? waitQueuePosition;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ContentProcessingState &&
    other.cid == cid &&
    other.state == state &&
    other.waitQueuePosition == waitQueuePosition;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cid == null ? 0 : cid!.hashCode) +
    (state.hashCode) +
    (waitQueuePosition == null ? 0 : waitQueuePosition!.hashCode);

  @override
  String toString() => 'ContentProcessingState[cid=$cid, state=$state, waitQueuePosition=$waitQueuePosition]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.cid != null) {
      json[r'cid'] = this.cid;
    } else {
      json[r'cid'] = null;
    }
      json[r'state'] = this.state;
    if (this.waitQueuePosition != null) {
      json[r'wait_queue_position'] = this.waitQueuePosition;
    } else {
      json[r'wait_queue_position'] = null;
    }
    return json;
  }

  /// Returns a new [ContentProcessingState] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ContentProcessingState? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ContentProcessingState[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ContentProcessingState[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ContentProcessingState(
        cid: ContentId.fromJson(json[r'cid']),
        state: ContentProcessingStateType.fromJson(json[r'state'])!,
        waitQueuePosition: mapValueOfType<int>(json, r'wait_queue_position'),
      );
    }
    return null;
  }

  static List<ContentProcessingState> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ContentProcessingState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ContentProcessingState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ContentProcessingState> mapFromJson(dynamic json) {
    final map = <String, ContentProcessingState>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ContentProcessingState.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ContentProcessingState-objects as value to a dart map
  static Map<String, List<ContentProcessingState>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ContentProcessingState>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ContentProcessingState.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'state',
  };
}

