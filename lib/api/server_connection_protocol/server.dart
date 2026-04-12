import 'dart:convert';
import 'dart:typed_data';

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
/// - [ServerMessageTypeCode.accountStateChanged] (30): payload is empty.
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
  accountStateChanged(30),
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
      case ServerMessageTypeCode.accountStateChanged:
      case ServerMessageTypeCode.profileChanged:
      case ServerMessageTypeCode.mediaContentChanged:
      case ServerMessageTypeCode.newMessageReceived:
      case ServerMessageTypeCode.pendingChatNotificationsChanged:
      case ServerMessageTypeCode.receivedLikesChanged:
      case ServerMessageTypeCode.dailyLikesLeftChanged:
      case ServerMessageTypeCode.messageDeliveryInfoChanged:
      case ServerMessageTypeCode.latestSeenMessageChanged:
        if (payload.isNotEmpty) {
          return null;
        }
        return ServerMessage._(type: type, payload: payload);
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
  final reader = _ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final sessionId = reader.readMinimalI64();
      if (sessionId == null || reader.failed || !reader.isAtEnd) {
        return null;
      }
      return _ResponseResetProfilePagingPayload(
        requestId: requestId,
        sessionId: ProfileIteratorSessionId(id: sessionId),
      );
    case 1:
    case 2:
      if (!reader.isAtEnd) {
        return null;
      }
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
  final reader = _ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final profiles = <ProfileLink>[];
      while (!reader.isAtEnd) {
        final profile = _parseProfileLinkForPaging(reader);
        if (profile == null) {
          return null;
        }
        profiles.add(profile);
      }
      if (reader.failed) {
        return null;
      }
      return _ResponseNextProfilePagePayload(
        requestId: requestId,
        page: ProfilePage(profiles: profiles),
      );
    case 1:
      if (!reader.isAtEnd) {
        return null;
      }
      return _ResponseNextProfilePagePayload(
        requestId: requestId,
        page: ProfilePage(errorInvalidIteratorSessionId: true),
      );
    case 2:
    case 3:
      if (!reader.isAtEnd) {
        return null;
      }
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
  final reader = _ByteReader(payload);

  final requestId = reader.readU8();
  final status = reader.readU8();
  if (requestId == null || status == null) {
    return null;
  }

  switch (status) {
    case 0:
      final sessionId = reader.readMinimalI64();
      if (sessionId == null || reader.failed || !reader.isAtEnd) {
        return null;
      }
      return _ResponseAutomaticProfileSearchResetProfilePagingPayload(
        requestId: requestId,
        sessionId: AutomaticProfileSearchIteratorSessionId(id: sessionId),
      );
    case 1:
    case 2:
      if (!reader.isAtEnd) {
        return null;
      }
      return _ResponseAutomaticProfileSearchResetProfilePagingPayload(requestId: requestId);
    default:
      return null;
  }
}

ProfileLink? _parseProfileLinkForPaging(_ByteReader reader) {
  final accountIdBytes = reader.readBytes(16);
  final profileVersionBytes = reader.readBytes(16);
  final profileContentVersionBytes = reader.readBytes(16);
  final lastSeenMarker = reader.readU8();

  if (reader.failed ||
      accountIdBytes == null ||
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
    if (reader.failed || lastSeen == null) {
      return null;
    }
  }

  return ProfileLink(
    a: AccountId(aid: _base64UrlWithoutPadding(accountIdBytes)),
    c: ProfileContentVersion(v: _base64UrlWithoutPadding(profileContentVersionBytes)),
    l: lastSeen,
    p: ProfileVersion(v: _base64UrlWithoutPadding(profileVersionBytes)),
  );
}

ScheduledMaintenanceStatus? _parseScheduledMaintenanceStatus(Uint8List payload) {
  if (payload.isEmpty) {
    return null;
  }

  final reader = _ByteReader(payload);
  final adminBotOffline = switch (reader.readU8()) {
    0 => false,
    1 => true,
    _ => null,
  };
  if (adminBotOffline == null) {
    return null;
  }

  final start = _optionalUnixTimeFromMinimalI64(reader);
  if (reader.failed) {
    return null;
  }

  final end = start != null ? _optionalUnixTimeFromMinimalI64(reader) : null;
  if (reader.failed || !reader.isAtEnd) {
    return null;
  }

  return ScheduledMaintenanceStatus(end: end, adminBotOffline: adminBotOffline, start: start);
}

ContentProcessingStateChanged? _parseContentProcessingStateChanged(Uint8List payload) {
  final reader = _ByteReader(payload);

  final processId = reader.readMinimalI64();
  if (reader.failed || processId == null) {
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
      final queueNumber = reader.readMinimalI64();
      if (queueNumber == null || reader.failed) {
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

  if (reader.failed || !reader.isAtEnd) {
    return null;
  }

  final state = ContentProcessingState(
    cid: contentId,
    fd: faceDetected,
    state: stateType,
    waitQueuePosition: waitQueuePosition,
  );

  return ContentProcessingStateChanged(
    id: ContentProcessingServerProcessId(id: processId),
    newState: state,
  );
}

CheckOnlineStatusResponse? _parseCheckOnlineStatusResponse(Uint8List payload) {
  final reader = _ByteReader(payload);
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

  if (reader.failed || !reader.isAtEnd) {
    return null;
  }

  return CheckOnlineStatusResponse(a: accountId, l: lastSeen);
}

UnixTime? _optionalUnixTimeFromMinimalI64(_ByteReader reader) {
  if (reader.isAtEnd) {
    return null;
  }
  final value = reader.readMinimalI64();
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
  return AccountId(aid: _base64UrlWithoutPadding(bytes));
}

ContentId? _contentIdFromUuidBytes(Uint8List? bytes) {
  if (bytes == null || bytes.length != 16) {
    return null;
  }
  return ContentId(cid: _base64UrlWithoutPadding(bytes));
}

String _base64UrlWithoutPadding(Uint8List bytes) {
  return base64UrlEncode(bytes).replaceAll('=', '');
}

class _ByteReader {
  final Uint8List _bytes;
  int _offset = 0;
  bool failed = false;

  _ByteReader(this._bytes);

  bool get isAtEnd => _offset == _bytes.length;

  int? readU8() {
    if (_offset >= _bytes.length) {
      failed = true;
      return null;
    }
    return _bytes[_offset++];
  }

  Uint8List? readBytes(int length) {
    if (length < 0 || _offset + length > _bytes.length) {
      failed = true;
      return null;
    }

    final value = Uint8List.sublistView(_bytes, _offset, _offset + length);
    _offset += length;
    return value;
  }

  int? readMinimalI64() {
    final byteCount = readU8();
    if (byteCount == null) {
      return null;
    }

    return readMinimalI64WithKnownByteCount(byteCount);
  }

  int? readMinimalI64WithKnownByteCount(int byteCount) {
    if (byteCount != 1 && byteCount != 2 && byteCount != 4 && byteCount != 8) {
      failed = true;
      return null;
    }

    final dataBytes = readBytes(byteCount);
    if (dataBytes == null) {
      return null;
    }

    final data = ByteData.sublistView(dataBytes);
    return switch (byteCount) {
      1 => data.getInt8(0),
      2 => data.getInt16(0, Endian.little),
      4 => data.getInt32(0, Endian.little),
      8 => data.getInt64(0, Endian.little),
      _ => null,
    };
  }
}
