//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// First byte of websocket binary protocol messages sent from server to client.  # Message types and payloads  - `PendingAppNotificationsChanged` (0): payload is empty. - `ClientConfigChanged` (1): payload is empty. - `NewsCountChanged` (2): payload is empty. - `ScheduledMaintenanceStatus` (3): payload format:   - admin bot offline (u8, 0 or 1)   - maintenance start as optional minimal i64   - if start exists, maintenance end as optional minimal i64 - `AdminBotNotification` (4): payload is unsigned integer with   little-endian byte order for `AdminBotNotificationTypes` bitflags.   (1 byte = u8, 2 bytes = u16 etc.) - `PushNotificationInfoChanged` (5): payload is empty. - `RequestAdminBotConfigWarnings` (6): payload format:   - request id byte (u8) - `AccountStateChanged` (30): payload is empty. - `ProfileChanged` (60): payload is empty. - `ResponseResetProfilePaging` (61): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: rate limited     - 2: internal server error   - if status is 0:     - profile iterator session id as minimal i64 - `ResponseNextProfilePage` (62): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: invalid iterator session id     - 2: rate limited     - 3: internal server error   - if status is 0:     - repeated profile entries until payload ends:       - account id as 16-byte big-endian UUID       - profile version as 16-byte big-endian UUID       - profile content version as 16-byte big-endian UUID       - null last seen time (0 byte) or last seen time as minimal i64 - `ResponseAutomaticProfileSearchResetProfilePaging` (63): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: rate limited     - 2: internal server error   - if status is 0:     - automatic profile search iterator session id as minimal i64 - `ResponseAutomaticProfileSearchNextProfilePage` (64): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: invalid iterator session id     - 2: rate limited     - 3: internal server error   - if status is 0:     - repeated profile entries until payload ends:       - account id as 16-byte big-endian UUID       - profile version as 16-byte big-endian UUID       - profile content version as 16-byte big-endian UUID       - null last seen time (0 byte) or last seen time as minimal i64 - `ContentProcessingStateChanged` (90): payload format:   - content processing server process ID as minimal i64   - content processing state byte:     - 0: Empty     - 1: InQueue     - 2: Processing     - 3: Completed     - 4: Failed     - 5: NsfwDetected   - state specific data:     - InQueue: queue number as minimal i64     - Completed:       - content ID as 16 byte big-endian UUID (16 bytes)       - face detection bool (1 byte, 0 or 1) - `MediaContentChanged` (91): payload is empty. - `NewMessageReceived` (120): payload is empty. - `PendingChatNotificationsChanged` (121): payload is empty. - `ReceivedLikesChanged` (122): payload is empty. - `DailyLikesLeftChanged` (123): payload is empty. - `TypingStart` (124): payload is exactly 16 bytes account UUID in   big-endian byte order. - `TypingStop` (125): payload is exactly 16 bytes account UUID in   big-endian byte order. - `OnlineStatusUpdated` (126): payload is 16 bytes account UUID,   followed by null last seen time (0 byte) or last seen time as minimal i64. - `MessageDeliveryInfoChanged` (127): payload is empty. - `LatestSeenMessageChanged` (128): payload is empty.  # Data formats  Data types used in payload definitions: - minimal i64:   - i64 byte count (u8, values: 1, 2, 4, 8)   - i64 bytes (little-endian byte order) - optional values in payloads are omitted when they are not present
class ServerMessageType {
  /// Instantiate a new enum with the provided [value].
  const ServerMessageType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const pendingAppNotificationsChanged = ServerMessageType._(r'PendingAppNotificationsChanged');
  static const clientConfigChanged = ServerMessageType._(r'ClientConfigChanged');
  static const newsCountChanged = ServerMessageType._(r'NewsCountChanged');
  static const scheduledMaintenanceStatus = ServerMessageType._(r'ScheduledMaintenanceStatus');
  static const adminBotNotification = ServerMessageType._(r'AdminBotNotification');
  static const pushNotificationInfoChanged = ServerMessageType._(r'PushNotificationInfoChanged');
  static const requestAdminBotConfigWarnings = ServerMessageType._(r'RequestAdminBotConfigWarnings');
  static const accountStateChanged = ServerMessageType._(r'AccountStateChanged');
  static const profileChanged = ServerMessageType._(r'ProfileChanged');
  static const responseResetProfilePaging = ServerMessageType._(r'ResponseResetProfilePaging');
  static const responseNextProfilePage = ServerMessageType._(r'ResponseNextProfilePage');
  static const responseAutomaticProfileSearchResetProfilePaging = ServerMessageType._(r'ResponseAutomaticProfileSearchResetProfilePaging');
  static const responseAutomaticProfileSearchNextProfilePage = ServerMessageType._(r'ResponseAutomaticProfileSearchNextProfilePage');
  static const contentProcessingStateChanged = ServerMessageType._(r'ContentProcessingStateChanged');
  static const mediaContentChanged = ServerMessageType._(r'MediaContentChanged');
  static const newMessageReceived = ServerMessageType._(r'NewMessageReceived');
  static const pendingChatNotificationsChanged = ServerMessageType._(r'PendingChatNotificationsChanged');
  static const receivedLikesChanged = ServerMessageType._(r'ReceivedLikesChanged');
  static const dailyLikesLeftChanged = ServerMessageType._(r'DailyLikesLeftChanged');
  static const typingStart = ServerMessageType._(r'TypingStart');
  static const typingStop = ServerMessageType._(r'TypingStop');
  static const onlineStatusUpdated = ServerMessageType._(r'OnlineStatusUpdated');
  static const messageDeliveryInfoChanged = ServerMessageType._(r'MessageDeliveryInfoChanged');
  static const latestSeenMessageChanged = ServerMessageType._(r'LatestSeenMessageChanged');

  /// List of all possible values in this [enum][ServerMessageType].
  static const values = <ServerMessageType>[
    pendingAppNotificationsChanged,
    clientConfigChanged,
    newsCountChanged,
    scheduledMaintenanceStatus,
    adminBotNotification,
    pushNotificationInfoChanged,
    requestAdminBotConfigWarnings,
    accountStateChanged,
    profileChanged,
    responseResetProfilePaging,
    responseNextProfilePage,
    responseAutomaticProfileSearchResetProfilePaging,
    responseAutomaticProfileSearchNextProfilePage,
    contentProcessingStateChanged,
    mediaContentChanged,
    newMessageReceived,
    pendingChatNotificationsChanged,
    receivedLikesChanged,
    dailyLikesLeftChanged,
    typingStart,
    typingStop,
    onlineStatusUpdated,
    messageDeliveryInfoChanged,
    latestSeenMessageChanged,
  ];

  static ServerMessageType? fromJson(dynamic value) => ServerMessageTypeTypeTransformer().decode(value);

  static List<ServerMessageType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServerMessageType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServerMessageType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ServerMessageType] to String,
/// and [decode] dynamic data back to [ServerMessageType].
class ServerMessageTypeTypeTransformer {
  factory ServerMessageTypeTypeTransformer() => _instance ??= const ServerMessageTypeTypeTransformer._();

  const ServerMessageTypeTypeTransformer._();

  String encode(ServerMessageType data) => data.value;

  /// Decodes a [dynamic value][data] to a ServerMessageType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ServerMessageType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'PendingAppNotificationsChanged': return ServerMessageType.pendingAppNotificationsChanged;
        case r'ClientConfigChanged': return ServerMessageType.clientConfigChanged;
        case r'NewsCountChanged': return ServerMessageType.newsCountChanged;
        case r'ScheduledMaintenanceStatus': return ServerMessageType.scheduledMaintenanceStatus;
        case r'AdminBotNotification': return ServerMessageType.adminBotNotification;
        case r'PushNotificationInfoChanged': return ServerMessageType.pushNotificationInfoChanged;
        case r'RequestAdminBotConfigWarnings': return ServerMessageType.requestAdminBotConfigWarnings;
        case r'AccountStateChanged': return ServerMessageType.accountStateChanged;
        case r'ProfileChanged': return ServerMessageType.profileChanged;
        case r'ResponseResetProfilePaging': return ServerMessageType.responseResetProfilePaging;
        case r'ResponseNextProfilePage': return ServerMessageType.responseNextProfilePage;
        case r'ResponseAutomaticProfileSearchResetProfilePaging': return ServerMessageType.responseAutomaticProfileSearchResetProfilePaging;
        case r'ResponseAutomaticProfileSearchNextProfilePage': return ServerMessageType.responseAutomaticProfileSearchNextProfilePage;
        case r'ContentProcessingStateChanged': return ServerMessageType.contentProcessingStateChanged;
        case r'MediaContentChanged': return ServerMessageType.mediaContentChanged;
        case r'NewMessageReceived': return ServerMessageType.newMessageReceived;
        case r'PendingChatNotificationsChanged': return ServerMessageType.pendingChatNotificationsChanged;
        case r'ReceivedLikesChanged': return ServerMessageType.receivedLikesChanged;
        case r'DailyLikesLeftChanged': return ServerMessageType.dailyLikesLeftChanged;
        case r'TypingStart': return ServerMessageType.typingStart;
        case r'TypingStop': return ServerMessageType.typingStop;
        case r'OnlineStatusUpdated': return ServerMessageType.onlineStatusUpdated;
        case r'MessageDeliveryInfoChanged': return ServerMessageType.messageDeliveryInfoChanged;
        case r'LatestSeenMessageChanged': return ServerMessageType.latestSeenMessageChanged;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ServerMessageTypeTypeTransformer] instance.
  static ServerMessageTypeTypeTransformer? _instance;
}

