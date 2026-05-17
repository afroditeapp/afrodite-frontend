import 'dart:typed_data';

import 'package:app/api/binary/utils.dart';
import 'package:openapi/api.dart';

/// First byte of websocket binary protocol messages sent from server to client.
///
/// Remaining bytes are message payload. Payload format depends on the message
/// type value:
/// - [ServerMessageTypeCode.pendingAppNotificationsChanged] (0): payload is
///   empty.
/// - [ServerMessageTypeCode.clientConfigChanged] (1): payload is empty.
/// - [ServerMessageTypeCode.newsCountChanged] (2): payload is empty.
/// - [ServerMessageTypeCode.scheduledMaintenanceStatus] (3): payload format:
///   - admin bot offline (u8, 0 or 1)
///   - maintenance start as optional minimal i64
///   - if start exists, maintenance end as optional minimal i64
/// - [ServerMessageTypeCode.adminBotNotification] (4): payload is unsigned
///   integer with little-endian byte order for admin bot notification bitflags.
/// - [ServerMessageTypeCode.pushNotificationInfoChanged] (5): payload is empty.
/// - [ServerMessageTypeCode.webSocketConnectionAttemptsRemaining] (7): payload
///   is remaining daily websocket connection attempts as u8.
/// - [ServerMessageTypeCode.appUpdateAvailable] (8): payload can be empty or
///   non-empty to keep protocol forward compatible.
/// - [ServerMessageTypeCode.accountStateChanged] (30): payload is empty.
/// - [ServerMessageTypeCode.accountVerificationQueuePositionChanged] (31):
///   payload format:
///   - optional queue position as 1 byte (empty payload means null)
/// - [ServerMessageTypeCode.profileChanged] (60): payload is empty.
/// - [ServerMessageTypeCode.responseResetProfilePaging] (61): payload format:
///   - request id byte (u8)
///   - status byte:
///     - 0: success
///     - 1: rate limited
///     - 2: internal server error
///   - if status is 0:
///     - profile iterator session id as minimal i64
/// - [ServerMessageTypeCode.responseNextProfilePage] (62): payload format:
///   - request id byte (u8)
///   - status byte:
///     - 0: success
///     - 1: invalid iterator session id
///     - 2: rate limited
///     - 3: internal server error
///   - if status is 0:
///     - repeated profile entries until payload ends
/// - [ServerMessageTypeCode.responseAutomaticProfileSearchResetProfilePaging]
///   (63): payload format:
///   - request id byte (u8)
///   - status byte:
///     - 0: success
///     - 1: rate limited
///     - 2: internal server error
///   - if status is 0:
///     - automatic profile search iterator session id as minimal i64
/// - [ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage]
///   (64): payload format:
///   - request id byte (u8)
///   - status byte:
///     - 0: success
///     - 1: invalid iterator session id
///     - 2: rate limited
///     - 3: internal server error
///   - if status is 0:
///     - repeated profile entries until payload ends
/// - [ServerMessageTypeCode.contentProcessingStateChanged] (90): payload format:
///   - content processing server process ID as minimal i64
///   - content processing state byte:
///     - 0: Empty
///     - 1: InQueue
///     - 2: Processing
///     - 3: Completed
///     - 4: Failed
///     - 5: NsfwDetected
///   - state specific data:
///     - InQueue: queue number as minimal i64
///     - Completed:
///       - content ID as 16-byte big-endian UUID
///       - face detection bool (1 byte, 0 or 1)
/// - [ServerMessageTypeCode.mediaContentChanged] (91): payload is empty.
/// - [ServerMessageTypeCode.newMessageReceived] (120): payload is empty.
/// - [ServerMessageTypeCode.pendingChatNotificationsChanged] (121): payload is
///   empty.
/// - [ServerMessageTypeCode.receivedLikesChanged] (122): payload is empty.
/// - [ServerMessageTypeCode.dailyLikesLeftChanged] (123): payload is empty.
/// - [ServerMessageTypeCode.typingStart] (124): payload is exactly 16 bytes
///   account UUID in big-endian byte order.
/// - [ServerMessageTypeCode.typingStop] (125): payload is exactly 16 bytes
///   account UUID in big-endian byte order.
/// - [ServerMessageTypeCode.onlineStatusUpdated] (126): payload is 16 bytes
///   account UUID, followed by null last seen time (0 byte) or last seen
///   time as minimal i64.
/// - [ServerMessageTypeCode.messageDeliveryInfoChanged] (127): payload is
///   empty.
/// - [ServerMessageTypeCode.latestSeenMessageChanged] (128): payload is empty.
enum ServerMessageTypeCode {
  pendingAppNotificationsChanged(0),
  clientConfigChanged(1),
  newsCountChanged(2),
  scheduledMaintenanceStatus(3),
  adminBotNotification(4),
  pushNotificationInfoChanged(5),
  webSocketConnectionAttemptsRemaining(7),
  appUpdateAvailable(8),
  accountStateChanged(30),
  accountVerificationQueuePositionChanged(31),
  profileChanged(60),
  responseResetProfilePaging(61),
  responseNextProfilePage(62),
  responseAutomaticProfileSearchResetProfilePaging(63),
  responseAutomaticProfileSearchNextProfilePage(64),
  contentProcessingStateChanged(90),
  mediaContentChanged(91),
  newMessageReceived(120),
  pendingChatNotificationsChanged(121),
  receivedLikesChanged(122),
  dailyLikesLeftChanged(123),
  typingStart(124),
  typingStop(125),
  onlineStatusUpdated(126),
  messageDeliveryInfoChanged(127),
  latestSeenMessageChanged(128);

  final int code;
  const ServerMessageTypeCode(this.code);

  static ServerMessageTypeCode? fromCode(int code) {
    for (final value in values) {
      if (value.code == code) {
        return value;
      }
    }
    return null;
  }
}

class ContentProcessingServerProcessId {
  final int id;
  const ContentProcessingServerProcessId({required this.id});
}

class ContentProcessingStateChanged {
  final ContentProcessingServerProcessId id;
  final ContentProcessingState newState;

  const ContentProcessingStateChanged({required this.id, required this.newState});
}

class ScheduledMaintenanceStatus {
  final UnixTime? end;
  final bool adminBotOffline;
  final UnixTime? start;

  const ScheduledMaintenanceStatus({
    required this.end,
    required this.adminBotOffline,
    required this.start,
  });
}

class CheckOnlineStatusResponse {
  final AccountId a;
  final int? l;

  const CheckOnlineStatusResponse({required this.a, this.l});
}

class _ResponseResetProfilePagingPayload {
  final int requestId;
  final ProfileIteratorSessionId? sessionId;

  const _ResponseResetProfilePagingPayload({required this.requestId, this.sessionId});
}

class _ResponseNextProfilePagePayload {
  final int requestId;
  final ProfilePage page;

  const _ResponseNextProfilePagePayload({required this.requestId, required this.page});
}

class _ResponseAutomaticProfileSearchResetProfilePagingPayload {
  final int requestId;
  final AutomaticProfileSearchIteratorSessionId? sessionId;

  const _ResponseAutomaticProfileSearchResetProfilePagingPayload({
    required this.requestId,
    this.sessionId,
  });
}

class ServerMessage {
  final ServerMessageTypeCode type;
  final Uint8List payload;
  final int? responseId;

  final int? adminBotNotification;
  final int? accountVerificationQueuePosition;
  final int? webSocketConnectionAttemptsRemaining;
  final CheckOnlineStatusResponse? checkOnlineStatusResponse;
  final ContentProcessingStateChanged? contentProcessingStateChanged;
  final ProfileIteratorSessionId? responseResetProfilePaging;
  final ProfilePage? responseNextProfilePage;
  final AutomaticProfileSearchIteratorSessionId? responseAutomaticProfileSearchResetProfilePaging;
  final ProfilePage? responseAutomaticProfileSearchNextProfilePage;
  final ScheduledMaintenanceStatus? scheduledMaintenanceStatus;
  final AccountId? typingStart;
  final AccountId? typingStop;

  const ServerMessage._({
    required this.type,
    required this.payload,
    this.responseId,
    this.adminBotNotification,
    this.accountVerificationQueuePosition,
    this.webSocketConnectionAttemptsRemaining,
    this.checkOnlineStatusResponse,
    this.contentProcessingStateChanged,
    this.responseResetProfilePaging,
    this.responseNextProfilePage,
    this.responseAutomaticProfileSearchResetProfilePaging,
    this.responseAutomaticProfileSearchNextProfilePage,
    this.scheduledMaintenanceStatus,
    this.typingStart,
    this.typingStop,
  });

  /// Bytes must not be empty
  static ServerMessage? fromBytes(Uint8List bytes) {
    final type = ServerMessageTypeCode.fromCode(bytes[0]);
    if (type == null) {
      return null;
    }

    final payload = Uint8List.sublistView(bytes, 1);

    switch (type) {
      case ServerMessageTypeCode.pendingAppNotificationsChanged:
      case ServerMessageTypeCode.clientConfigChanged:
      case ServerMessageTypeCode.newsCountChanged:
      case ServerMessageTypeCode.pushNotificationInfoChanged:
      case ServerMessageTypeCode.appUpdateAvailable:
      case ServerMessageTypeCode.accountStateChanged:
      case ServerMessageTypeCode.profileChanged:
      case ServerMessageTypeCode.mediaContentChanged:
      case ServerMessageTypeCode.newMessageReceived:
      case ServerMessageTypeCode.pendingChatNotificationsChanged:
      case ServerMessageTypeCode.receivedLikesChanged:
      case ServerMessageTypeCode.dailyLikesLeftChanged:
      case ServerMessageTypeCode.messageDeliveryInfoChanged:
      case ServerMessageTypeCode.latestSeenMessageChanged:
        if (type == ServerMessageTypeCode.appUpdateAvailable) {
          return ServerMessage._(type: type, payload: payload);
        }
        if (payload.isNotEmpty) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload);
      case ServerMessageTypeCode.accountVerificationQueuePositionChanged:
        if (payload.length > 1) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          accountVerificationQueuePosition: payload.isEmpty ? null : payload[0],
        );
      case ServerMessageTypeCode.responseResetProfilePaging:
        final response = _parseResponseResetProfilePaging(payload);
        if (response == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          responseId: response.requestId,
          responseResetProfilePaging: response.sessionId,
        );
      case ServerMessageTypeCode.responseNextProfilePage:
        final response = _parseResponseNextProfilePage(payload);
        if (response == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          responseId: response.requestId,
          responseNextProfilePage: response.page,
        );
      case ServerMessageTypeCode.responseAutomaticProfileSearchResetProfilePaging:
        final response = _parseResponseAutomaticProfileSearchResetProfilePaging(payload);
        if (response == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          responseId: response.requestId,
          responseAutomaticProfileSearchResetProfilePaging: response.sessionId,
        );
      case ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage:
        final response = _parseResponseNextProfilePage(payload);
        if (response == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          responseId: response.requestId,
          responseAutomaticProfileSearchNextProfilePage: response.page,
        );
      case ServerMessageTypeCode.scheduledMaintenanceStatus:
        final maintenance = _parseScheduledMaintenanceStatus(payload);
        if (maintenance == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          scheduledMaintenanceStatus: maintenance,
        );
      case ServerMessageTypeCode.adminBotNotification:
        final value = _parseUnsignedLittleEndian(payload);
        if (value == null) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload, adminBotNotification: value);
      case ServerMessageTypeCode.webSocketConnectionAttemptsRemaining:
        if (payload.length != 1) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          webSocketConnectionAttemptsRemaining: payload[0],
        );
      case ServerMessageTypeCode.contentProcessingStateChanged:
        final contentProcessingState = _parseContentProcessingStateChanged(payload);
        if (contentProcessingState == null) {
          return null;
        }
        return ServerMessage._(
          type: type,
          payload: payload,
          contentProcessingStateChanged: contentProcessingState,
        );
      case ServerMessageTypeCode.typingStart:
        final accountId = _accountIdFromUuidBytes(payload);
        if (accountId == null) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload, typingStart: accountId);
      case ServerMessageTypeCode.typingStop:
        final accountId = _accountIdFromUuidBytes(payload);
        if (accountId == null) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload, typingStop: accountId);
      case ServerMessageTypeCode.onlineStatusUpdated:
        final response = _parseCheckOnlineStatusResponse(payload);
        if (response == null) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload, checkOnlineStatusResponse: response);
    }
  }
}

/// Parses [ServerMessageTypeCode.responseResetProfilePaging] payload.
///
/// Returns null for malformed payloads.
///
/// Non-success statuses (1 and 2) are valid and returned with null session id.
_ResponseResetProfilePagingPayload? _parseResponseResetProfilePaging(Uint8List payload) {
  final reader = ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final byteCount = reader.readU8();
      if (byteCount == null) {
        return null;
      }
      final sessionId = reader.readMinimalI64WithKnownByteCount(byteCount);
      if (sessionId == null) {
        return null;
      }
      return _ResponseResetProfilePagingPayload(
        requestId: requestId,
        sessionId: ProfileIteratorSessionId(id: sessionId),
      );
    case 1:
    case 2:
      return _ResponseResetProfilePagingPayload(requestId: requestId);
    default:
      return null;
  }
}

/// Parses profile paging payloads:
/// - [ServerMessageTypeCode.responseNextProfilePage]
/// - [ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage]
///
/// Returns null for malformed payloads.
_ResponseNextProfilePagePayload? _parseResponseNextProfilePage(Uint8List payload) {
  final reader = ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final profiles = <ProfileLink>[];
      while (true) {
        final profile = _parseProfileLinkForPaging(reader);
        if (profile == null) {
          break;
        }
        profiles.add(profile);
      }
      return _ResponseNextProfilePagePayload(
        requestId: requestId,
        page: ProfilePage(profiles: profiles),
      );
    case 1:
      return _ResponseNextProfilePagePayload(
        requestId: requestId,
        page: ProfilePage(errorInvalidIteratorSessionId: true),
      );
    case 2:
    case 3:
      return _ResponseNextProfilePagePayload(requestId: requestId, page: ProfilePage(error: true));
    default:
      return null;
  }
}

/// Parses [ServerMessageTypeCode.responseAutomaticProfileSearchResetProfilePaging]
/// payload.
///
/// Returns null for malformed payloads.
///
/// Non-success statuses (1 and 2) are valid and returned with null session id.
_ResponseAutomaticProfileSearchResetProfilePagingPayload?
_parseResponseAutomaticProfileSearchResetProfilePaging(Uint8List payload) {
  final reader = ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final byteCount = reader.readU8();
      if (byteCount == null) {
        return null;
      }
      final sessionId = reader.readMinimalI64WithKnownByteCount(byteCount);
      if (sessionId == null) {
        return null;
      }
      return _ResponseAutomaticProfileSearchResetProfilePagingPayload(
        requestId: requestId,
        sessionId: AutomaticProfileSearchIteratorSessionId(id: sessionId),
      );
    case 1:
    case 2:
      return _ResponseAutomaticProfileSearchResetProfilePagingPayload(requestId: requestId);
    default:
      return null;
  }
}

ProfileLink? _parseProfileLinkForPaging(ByteReader reader) {
  final accountIdBytes = reader.readBytes(16);
  final profileVersionBytes = reader.readBytes(16);
  final profileContentVersionBytes = reader.readBytes(16);
  final lastSeenMarker = reader.readU8();

  if (accountIdBytes == null ||
      profileVersionBytes == null ||
      profileContentVersionBytes == null ||
      lastSeenMarker == null) {
    return null;
  }

  int? lastSeen;
  if (lastSeenMarker == 0) {
    lastSeen = null;
  } else {
    lastSeen = reader.readMinimalI64WithKnownByteCount(lastSeenMarker);
    if (lastSeen == null) {
      return null;
    }
  }

  return ProfileLink(
    a: AccountId(aid: toIdString(accountIdBytes)),
    c: ProfileContentVersion(v: toIdString(profileContentVersionBytes)),
    l: lastSeen,
    p: ProfileVersion(v: toIdString(profileVersionBytes)),
  );
}

ScheduledMaintenanceStatus? _parseScheduledMaintenanceStatus(Uint8List payload) {
  if (payload.isEmpty) {
    return null;
  }

  final reader = ByteReader(payload);
  final adminBotOffline = switch (reader.readU8()) {
    0 => false,
    1 => true,
    _ => null,
  };
  if (adminBotOffline == null) {
    return null;
  }

  final start = _optionalUnixTimeFromMinimalI64(reader);

  final end = start != null ? _optionalUnixTimeFromMinimalI64(reader) : null;

  return ScheduledMaintenanceStatus(end: end, adminBotOffline: adminBotOffline, start: start);
}

ContentProcessingStateChanged? _parseContentProcessingStateChanged(Uint8List payload) {
  final reader = ByteReader(payload);

  final processIdByteCount = reader.readU8();
  if (processIdByteCount == null) {
    return null;
  }
  final processId = reader.readMinimalI64WithKnownByteCount(processIdByteCount);
  if (processId == null) {
    return null;
  }

  final stateCode = reader.readU8();
  final stateType = switch (stateCode) {
    0 => ContentProcessingStateType.empty,
    1 => ContentProcessingStateType.inQueue,
    2 => ContentProcessingStateType.processing,
    3 => ContentProcessingStateType.completed,
    4 => ContentProcessingStateType.failed,
    5 => ContentProcessingStateType.nsfwDetected,
    _ => null,
  };
  if (stateType == null) {
    return null;
  }

  int? waitQueuePosition;
  ContentId? contentId;
  bool? faceDetected;

  switch (stateType) {
    case ContentProcessingStateType.inQueue:
      final queueByteCount = reader.readU8();
      if (queueByteCount == null) {
        return null;
      }
      final queueNumber = reader.readMinimalI64WithKnownByteCount(queueByteCount);
      if (queueNumber == null) {
        return null;
      }
      waitQueuePosition = queueNumber;
      break;
    case ContentProcessingStateType.completed:
      final contentIdBytes = reader.readBytes(16);
      final completedContentId = _contentIdFromUuidBytes(contentIdBytes);
      final faceDetectedByte = reader.readU8();
      if (completedContentId == null || faceDetectedByte == null) {
        return null;
      }
      if (faceDetectedByte != 0 && faceDetectedByte != 1) {
        return null;
      }
      contentId = completedContentId;
      faceDetected = faceDetectedByte == 1;
      break;
    case ContentProcessingStateType.empty:
    case ContentProcessingStateType.processing:
    case ContentProcessingStateType.failed:
    case ContentProcessingStateType.nsfwDetected:
      // No extra payload for these states.
      break;
  }

  final state = ContentProcessingState(
    cid: contentId,
    faceDetected: faceDetected,
    state: stateType,
    waitQueuePosition: waitQueuePosition,
  );

  return ContentProcessingStateChanged(
    id: ContentProcessingServerProcessId(id: processId),
    newState: state,
  );
}

CheckOnlineStatusResponse? _parseCheckOnlineStatusResponse(Uint8List payload) {
  final reader = ByteReader(payload);
  final accountIdBytes = reader.readBytes(16);
  final accountId = _accountIdFromUuidBytes(accountIdBytes);
  final marker = reader.readU8();

  if (accountId == null || marker == null) {
    return null;
  }

  int? lastSeen;
  if (marker == 0) {
    lastSeen = null;
  } else {
    lastSeen = reader.readMinimalI64WithKnownByteCount(marker);
    if (lastSeen == null) {
      return null;
    }
  }

  return CheckOnlineStatusResponse(a: accountId, l: lastSeen);
}

UnixTime? _optionalUnixTimeFromMinimalI64(ByteReader reader) {
  final byteCount = reader.readU8();
  if (byteCount == null) {
    return null;
  }
  final value = reader.readMinimalI64WithKnownByteCount(byteCount);
  if (value == null) {
    return null;
  }
  return UnixTime(ut: value);
}

int? _parseUnsignedLittleEndian(Uint8List payload) {
  if (payload.isEmpty || payload.length > 8) {
    return null;
  }

  final data = ByteData.sublistView(payload);
  return switch (payload.length) {
    1 => data.getUint8(0),
    2 => data.getUint16(0, Endian.little),
    4 => data.getUint32(0, Endian.little),
    8 => data.getUint64(0, Endian.little),
    _ => null,
  };
}

AccountId? _accountIdFromUuidBytes(Uint8List? bytes) {
  if (bytes == null || bytes.length != 16) {
    return null;
  }
  return AccountId(aid: toIdString(bytes));
}

ContentId? _contentIdFromUuidBytes(Uint8List? bytes) {
  if (bytes == null || bytes.length != 16) {
    return null;
  }
  return ContentId(cid: toIdString(bytes));
}
