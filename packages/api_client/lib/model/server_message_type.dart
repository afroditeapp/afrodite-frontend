//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// First byte of websocket binary protocol messages sent from server to client.  # Message types and payloads  - `PendingAppNotificationsChanged` (0): payload is empty. - `ClientConfigChanged` (1): payload is empty. - `NewsCountChanged` (2): payload is empty. - `ScheduledMaintenanceStatus` (3): payload format:   - admin bot offline (u8, 0 or 1)   - maintenance start as optional minimal i64   - if start exists, maintenance end as optional minimal i64 - `AdminBotNotification` (4): payload is unsigned integer with   little-endian byte order for `AdminBotNotificationTypes` bitflags.   (1 byte = u8, 2 bytes = u16 etc.) - `PushNotificationInfoChanged` (5): payload is empty. - `WebSocketConnectionAttemptsRemaining` (6): payload format:   - remaining daily websocket connection attempts as u8 - `AppUpdateAvailable` (7): payload is currently empty.   - Client must accept both empty and non-empty payload to support     forward-compatible protocol changes. - `AccountStateChanged` (30): payload is empty. - `AccountVerificationQueuePositionChanged` (31): payload format:   - optional queue position as 1 byte (empty payload means `None`) - `EmailAddressStateChanged` (32): payload is empty. - `ProfileChanged` (60): payload is empty. - `ResponseResetProfilePaging` (61): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: rate limited     - 2: internal server error   - if status is 0:     - profile iterator session id as minimal i64 - `ResponseNextProfilePage` (62): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: invalid iterator session id     - 2: rate limited     - 3: internal server error   - if status is 0:     - repeated profile entries until payload ends:       - account id as 16-byte big-endian UUID       - profile version as 16-byte big-endian UUID       - profile content version as 16-byte big-endian UUID       - null last seen time (0 byte) or last seen time as minimal i64 - `ResponseAutomaticProfileSearchResetProfilePaging` (63): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: rate limited     - 2: internal server error   - if status is 0:     - automatic profile search iterator session id as minimal i64 - `ResponseAutomaticProfileSearchNextProfilePage` (64): payload format:   - request id byte (u8)   - status byte:     - 0: success     - 1: invalid iterator session id     - 2: rate limited     - 3: internal server error   - if status is 0:     - repeated profile entries until payload ends:       - account id as 16-byte big-endian UUID       - profile version as 16-byte big-endian UUID       - profile content version as 16-byte big-endian UUID       - null last seen time (0 byte) or last seen time as minimal i64 - `ContentProcessingStateChanged` (90): payload format:   - client-provided processing id byte (u8)   - content processing state byte:     - 0: InQueue     - 1: Processing     - 2: Completed     - 3: Failed     - 4: NsfwDetected   - state specific data:     - InQueue: queue number as minimal i64     - Completed:       - content ID as 16 byte big-endian UUID (16 bytes)       - face detection bool (1 byte, 0 or 1) - `MediaContentChanged` (91): payload is empty. - `NewMessageReceived` (120): payload is empty. - `PendingChatNotificationsChanged` (121): payload is empty. - `ReceivedLikesChanged` (122): payload is empty. - `DailyLikesLeftChanged` (123): payload is empty. - `TypingStart` (124): payload is exactly 16 bytes account UUID in   big-endian byte order. - `TypingStop` (125): payload is exactly 16 bytes account UUID in   big-endian byte order. - `OnlineStatusUpdated` (126): payload is 16 bytes account UUID,   followed by null last seen time (0 byte) or last seen time as minimal i64. - `MessageDeliveryInfoChanged` (127): payload is empty. - `LatestSeenMessageChanged` (128): payload is empty.  # Data formats  Data types used in payload definitions: - minimal i64:   - i64 byte count (u8, values: 1, 2, 3, 4, 5, 6, 7, 8)   - i64 bytes (little-endian byte order) - optional values in payloads are omitted when they are not present
enum ServerMessageType {
  pendingAppNotificationsChanged._(r'PendingAppNotificationsChanged'),
  clientConfigChanged._(r'ClientConfigChanged'),
  newsCountChanged._(r'NewsCountChanged'),
  scheduledMaintenanceStatus._(r'ScheduledMaintenanceStatus'),
  adminBotNotification._(r'AdminBotNotification'),
  pushNotificationInfoChanged._(r'PushNotificationInfoChanged'),
  webSocketConnectionAttemptsRemaining._(r'WebSocketConnectionAttemptsRemaining'),
  appUpdateAvailable._(r'AppUpdateAvailable'),
  accountStateChanged._(r'AccountStateChanged'),
  accountVerificationQueuePositionChanged._(r'AccountVerificationQueuePositionChanged'),
  emailAddressStateChanged._(r'EmailAddressStateChanged'),
  profileChanged._(r'ProfileChanged'),
  responseResetProfilePaging._(r'ResponseResetProfilePaging'),
  responseNextProfilePage._(r'ResponseNextProfilePage'),
  responseAutomaticProfileSearchResetProfilePaging._(r'ResponseAutomaticProfileSearchResetProfilePaging'),
  responseAutomaticProfileSearchNextProfilePage._(r'ResponseAutomaticProfileSearchNextProfilePage'),
  contentProcessingStateChanged._(r'ContentProcessingStateChanged'),
  mediaContentChanged._(r'MediaContentChanged'),
  newMessageReceived._(r'NewMessageReceived'),
  pendingChatNotificationsChanged._(r'PendingChatNotificationsChanged'),
  receivedLikesChanged._(r'ReceivedLikesChanged'),
  dailyLikesLeftChanged._(r'DailyLikesLeftChanged'),
  typingStart._(r'TypingStart'),
  typingStop._(r'TypingStop'),
  onlineStatusUpdated._(r'OnlineStatusUpdated'),
  messageDeliveryInfoChanged._(r'MessageDeliveryInfoChanged'),
  latestSeenMessageChanged._(r'LatestSeenMessageChanged'),
  ;

  /// Instantiate a new enum with the provided value.
  const ServerMessageType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ServerMessageType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ServerMessageType? fromJson(dynamic value) => ServerMessageTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ServerMessageType]
  /// that were successfully decoded from the passed [JSON][json].
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

  /// Encodes this enum as a value suitable for JSON.
  String encode(ServerMessageType data) => data._value;

  /// Returns the instance of [ServerMessageType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ServerMessageType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ServerMessageType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'PendingAppNotificationsChanged': return ServerMessageType.pendingAppNotificationsChanged;
        case r'ClientConfigChanged': return ServerMessageType.clientConfigChanged;
        case r'NewsCountChanged': return ServerMessageType.newsCountChanged;
        case r'ScheduledMaintenanceStatus': return ServerMessageType.scheduledMaintenanceStatus;
        case r'AdminBotNotification': return ServerMessageType.adminBotNotification;
        case r'PushNotificationInfoChanged': return ServerMessageType.pushNotificationInfoChanged;
        case r'WebSocketConnectionAttemptsRemaining': return ServerMessageType.webSocketConnectionAttemptsRemaining;
        case r'AppUpdateAvailable': return ServerMessageType.appUpdateAvailable;
        case r'AccountStateChanged': return ServerMessageType.accountStateChanged;
        case r'AccountVerificationQueuePositionChanged': return ServerMessageType.accountVerificationQueuePositionChanged;
        case r'EmailAddressStateChanged': return ServerMessageType.emailAddressStateChanged;
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

  /// The singleton instance of this transformer.
  static ServerMessageTypeTypeTransformer? _instance;
}

