//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// First byte of websocket binary protocol messages sent from client to server.  Remaining bytes are message payload. Payload format depends on the message type value: - `SyncVersionList` (0): payload contains list of current data sync versions.   Each byte in the payload is a sync version for a data type. The position   of the byte defines the data type (see `SyncCheckDataType`). If client   does not have any version of the data, version number must be `255`. - `ClearMaintenanceStatusIfPossible` (1): payload is empty. - `ResponseAdminBotConfigWarnings` (2): payload format:   - request id byte (u8)   - warnings flags byte (u8). Bits in the byte:     - bit 0: profile name moderation file config missing     - bit 1: profile text moderation file config missing     - bit 2: content moderation file config missing - `RequestResetProfilePaging` (60): payload format:   - request id byte (u8) - `RequestGetNextProfilePage` (61): payload format:   - request id byte (u8)   - profile iterator session id as minimal i64 - `RequestAutomaticProfileSearchResetProfilePaging` (62): payload format:   - request id byte (u8) - `RequestAutomaticProfileSearchGetNextProfilePage` (63): payload format:   - request id byte (u8)   - automatic profile search iterator session id as minimal i64 - `TypingStart` (120): payload is exactly 16 bytes account UUID in big-endian   byte order. - `TypingStop` (121): payload is empty. - `CheckOnlineStatus` (122): payload is 16 bytes account UUID. Optional   17th byte can be included for online status hint (0 = false, non-zero = true).  # Data formats  Data types used in payload definitions: - minimal i64:   - i64 byte count (u8, values: 1, 2, 4, 8)   - i64 bytes (little-endian byte order) - optional values in payloads are omitted when they are not present
class ClientMessageType {
  /// Instantiate a new enum with the provided [value].
  const ClientMessageType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const syncVersionList = ClientMessageType._(r'SyncVersionList');
  static const clearMaintenanceStatusIfPossible = ClientMessageType._(r'ClearMaintenanceStatusIfPossible');
  static const responseAdminBotConfigWarnings = ClientMessageType._(r'ResponseAdminBotConfigWarnings');
  static const requestResetProfilePaging = ClientMessageType._(r'RequestResetProfilePaging');
  static const requestGetNextProfilePage = ClientMessageType._(r'RequestGetNextProfilePage');
  static const requestAutomaticProfileSearchResetProfilePaging = ClientMessageType._(r'RequestAutomaticProfileSearchResetProfilePaging');
  static const requestAutomaticProfileSearchGetNextProfilePage = ClientMessageType._(r'RequestAutomaticProfileSearchGetNextProfilePage');
  static const typingStart = ClientMessageType._(r'TypingStart');
  static const typingStop = ClientMessageType._(r'TypingStop');
  static const checkOnlineStatus = ClientMessageType._(r'CheckOnlineStatus');

  /// List of all possible values in this [enum][ClientMessageType].
  static const values = <ClientMessageType>[
    syncVersionList,
    clearMaintenanceStatusIfPossible,
    responseAdminBotConfigWarnings,
    requestResetProfilePaging,
    requestGetNextProfilePage,
    requestAutomaticProfileSearchResetProfilePaging,
    requestAutomaticProfileSearchGetNextProfilePage,
    typingStart,
    typingStop,
    checkOnlineStatus,
  ];

  static ClientMessageType? fromJson(dynamic value) => ClientMessageTypeTypeTransformer().decode(value);

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

  String encode(ClientMessageType data) => data.value;

  /// Decodes a [dynamic value][data] to a ClientMessageType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClientMessageType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'SyncVersionList': return ClientMessageType.syncVersionList;
        case r'ClearMaintenanceStatusIfPossible': return ClientMessageType.clearMaintenanceStatusIfPossible;
        case r'ResponseAdminBotConfigWarnings': return ClientMessageType.responseAdminBotConfigWarnings;
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

  /// Singleton [ClientMessageTypeTypeTransformer] instance.
  static ClientMessageTypeTypeTransformer? _instance;
}

