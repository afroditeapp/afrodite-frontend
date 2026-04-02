import 'dart:convert';
import 'dart:typed_data';

import 'package:openapi/api.dart';

/// First byte of websocket binary protocol messages sent from client to server.
///
/// Remaining bytes are message payload. Payload format depends on the message
/// type value:
/// - [ClientMessageType.syncVersionList] (0): payload contains list of current
///   data sync versions. Each byte in the payload is a sync version for a data
///   type. The position of the byte defines the data type (see
///   `SyncCheckDataType`). If client does not have any version of the data,
///   version number must be 255.
/// - [ClientMessageType.clearMaintenanceStatusIfPossible] (1): payload is
///   empty.
/// - [ClientMessageType.requestResetProfilePaging] (60): payload is empty.
/// - [ClientMessageType.requestGetNextProfilePage] (61): payload is profile
///   iterator session id as minimal i64.
/// - [ClientMessageType.requestAutomaticProfileSearchResetProfilePaging] (62):
///   payload is empty.
/// - [ClientMessageType.requestAutomaticProfileSearchGetNextProfilePage] (63):
///   payload is automatic profile search iterator session id as minimal i64.
/// - [ClientMessageType.typingStart] (120): payload is exactly 16 bytes account
///   UUID in big-endian byte order.
/// - [ClientMessageType.typingStop] (121): payload is empty.
/// - [ClientMessageType.requestCheckOnlineStatus] (122): payload is 16 bytes
///   account UUID. Optional 17th byte can be included for online status hint
///   (0 = false, non-zero = true).
enum ClientMessageType {
  syncVersionList(0),
  clearMaintenanceStatusIfPossible(1),
  requestResetProfilePaging(60),
  requestGetNextProfilePage(61),
  requestAutomaticProfileSearchResetProfilePaging(62),
  requestAutomaticProfileSearchGetNextProfilePage(63),
  typingStart(120),
  typingStop(121),
  requestCheckOnlineStatus(122);

  final int code;
  const ClientMessageType(this.code);
}

class ClientMessage {
  final ClientMessageType type;
  final Uint8List payload;

  const ClientMessage._({required this.type, required this.payload});

  factory ClientMessage.syncVersionList(Uint8List syncVersions) {
    return ClientMessage._(type: ClientMessageType.syncVersionList, payload: syncVersions);
  }

  factory ClientMessage.clearMaintenanceStatusIfPossible() {
    return ClientMessage._(
      type: ClientMessageType.clearMaintenanceStatusIfPossible,
      payload: Uint8List(0),
    );
  }

  factory ClientMessage.requestResetProfilePaging() {
    return ClientMessage._(
      type: ClientMessageType.requestResetProfilePaging,
      payload: Uint8List(0),
    );
  }

  factory ClientMessage.requestGetNextProfilePage(ProfileIteratorSessionId sessionId) {
    return ClientMessage._(
      type: ClientMessageType.requestGetNextProfilePage,
      payload: _minimalI64Bytes(sessionId.id),
    );
  }

  factory ClientMessage.requestAutomaticProfileSearchResetProfilePaging() {
    return ClientMessage._(
      type: ClientMessageType.requestAutomaticProfileSearchResetProfilePaging,
      payload: Uint8List(0),
    );
  }

  factory ClientMessage.requestAutomaticProfileSearchGetNextProfilePage(
    AutomaticProfileSearchIteratorSessionId sessionId,
  ) {
    return ClientMessage._(
      type: ClientMessageType.requestAutomaticProfileSearchGetNextProfilePage,
      payload: _minimalI64Bytes(sessionId.id),
    );
  }

  factory ClientMessage.typingStart(AccountId accountId) {
    return ClientMessage._(
      type: ClientMessageType.typingStart,
      payload: _uuidBytesFromAccountId(accountId),
    );
  }

  factory ClientMessage.typingStop() {
    return ClientMessage._(type: ClientMessageType.typingStop, payload: Uint8List(0));
  }

  factory ClientMessage.checkOnlineStatus(AccountId accountId, {bool? isOnlineHint}) {
    final accountIdBytes = _uuidBytesFromAccountId(accountId);
    if (isOnlineHint == null) {
      return ClientMessage._(
        type: ClientMessageType.requestCheckOnlineStatus,
        payload: accountIdBytes,
      );
    }

    final payload = Uint8List(17);
    payload.setRange(0, 16, accountIdBytes);
    payload[16] = isOnlineHint ? 1 : 0;
    return ClientMessage._(type: ClientMessageType.requestCheckOnlineStatus, payload: payload);
  }

  Uint8List toBytes() {
    final message = Uint8List(payload.length + 1);
    message[0] = type.code;
    message.setRange(1, message.length, payload);
    return message;
  }
}

Uint8List _uuidBytesFromAccountId(AccountId accountId) {
  final aid = accountId.aid;
  final requiredPadding = (4 - aid.length % 4) % 4;
  final paddedAid = aid.padRight(aid.length + requiredPadding, "=");
  return base64Url.decode(paddedAid);
}

Uint8List _minimalI64Bytes(int value) {
  int byteCount;
  if (value >= -128 && value <= 127) {
    byteCount = 1;
  } else if (value >= -32768 && value <= 32767) {
    byteCount = 2;
  } else if (value >= -2147483648 && value <= 2147483647) {
    byteCount = 4;
  } else {
    byteCount = 8;
  }

  final payload = Uint8List(1 + byteCount);
  payload[0] = byteCount;

  final data = ByteData.sublistView(payload, 1);
  switch (byteCount) {
    case 1:
      data.setInt8(0, value);
    case 2:
      data.setInt16(0, value, Endian.little);
    case 4:
      data.setInt32(0, value, Endian.little);
    case 8:
      data.setInt64(0, value, Endian.little);
  }

  return payload;
}
