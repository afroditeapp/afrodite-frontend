//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// First byte of websocket binary protocol messages sent from client to server.  Remaining bytes are message payload. Payload format depends on the message type value: - `SyncVersionList` (0): payload contains list of current data sync versions.   Each byte in the payload is a sync version for a data type. The position   of the byte defines the data type (see `SyncCheckDataType`). If client   does not have any version of the data, version number must be `255`. - `ClearMaintenanceStatusIfPossible` (1): payload is empty. - `RequestResetProfilePaging` (60): payload format:   - request id byte (u8) - `RequestGetNextProfilePage` (61): payload format:   - request id byte (u8)   - profile iterator session id as minimal i64 - `RequestAutomaticProfileSearchResetProfilePaging` (62): payload format:   - request id byte (u8) - `RequestAutomaticProfileSearchGetNextProfilePage` (63): payload format:   - request id byte (u8)   - automatic profile search iterator session id as minimal i64 - `TypingStart` (120): payload is exactly 16 bytes account UUID in big-endian   byte order. - `TypingStop` (121): payload is empty. - `CheckOnlineStatus` (122): payload is 16 bytes account UUID. Optional   17th byte can be included for online status hint (0 = false, non-zero = true).  # Data formats  Data types used in payload definitions: - minimal i64:   - i64 byte count (u8, values: 1, 2, 3, 4, 5, 6, 7, 8)   - i64 bytes (little-endian byte order) - optional values in payloads are omitted when they are not present
enum ClientMessageType {
  syncVersionList._(r'SyncVersionList'),
  clearMaintenanceStatusIfPossible._(r'ClearMaintenanceStatusIfPossible'),
  requestResetProfilePaging._(r'RequestResetProfilePaging'),
  requestGetNextProfilePage._(r'RequestGetNextProfilePage'),
  requestAutomaticProfileSearchResetProfilePaging._(r'RequestAutomaticProfileSearchResetProfilePaging'),
  requestAutomaticProfileSearchGetNextProfilePage._(r'RequestAutomaticProfileSearchGetNextProfilePage'),
  typingStart._(r'TypingStart'),
  typingStop._(r'TypingStop'),
  checkOnlineStatus._(r'CheckOnlineStatus'),
  ;

  /// Instantiate a new enum with the provided value.
  const ClientMessageType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ClientMessageType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ClientMessageType? fromJson(dynamic value) => ClientMessageTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ClientMessageType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ClientMessageType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientMessageType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientMessageType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ClientMessageType] to String,
/// and [decode] dynamic data back to [ClientMessageType].
class ClientMessageTypeTypeTransformer {
  factory ClientMessageTypeTypeTransformer() => _instance ??= const ClientMessageTypeTypeTransformer._();

  const ClientMessageTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ClientMessageType data) => data._value;

  /// Returns the instance of [ClientMessageType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClientMessageType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ClientMessageType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'SyncVersionList': return ClientMessageType.syncVersionList;
        case r'ClearMaintenanceStatusIfPossible': return ClientMessageType.clearMaintenanceStatusIfPossible;
        case r'RequestResetProfilePaging': return ClientMessageType.requestResetProfilePaging;
        case r'RequestGetNextProfilePage': return ClientMessageType.requestGetNextProfilePage;
        case r'RequestAutomaticProfileSearchResetProfilePaging': return ClientMessageType.requestAutomaticProfileSearchResetProfilePaging;
        case r'RequestAutomaticProfileSearchGetNextProfilePage': return ClientMessageType.requestAutomaticProfileSearchGetNextProfilePage;
        case r'TypingStart': return ClientMessageType.typingStart;
        case r'TypingStop': return ClientMessageType.typingStop;
        case r'CheckOnlineStatus': return ClientMessageType.checkOnlineStatus;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ClientMessageTypeTypeTransformer? _instance;
}

