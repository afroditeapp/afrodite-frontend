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
/// - [ClientMessageType.typingStart] (120): payload is exactly 16 bytes account
///   UUID in big-endian byte order.
/// - [ClientMessageType.typingStop] (121): payload is empty.
/// - [ClientMessageType.checkOnlineStatus] (122): payload is 16 bytes account
///   UUID. Optional 17th byte can be included for online status hint
///   (0 = false, non-zero = true).
enum ClientMessageType {
  syncVersionList(0),
  clearMaintenanceStatusIfPossible(1),
  typingStart(120),
  typingStop(121),
  checkOnlineStatus(122);

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
      return ClientMessage._(type: ClientMessageType.checkOnlineStatus, payload: accountIdBytes);
    }

    final payload = Uint8List(17);
    payload.setRange(0, 16, accountIdBytes);
    payload[16] = isOnlineHint ? 1 : 0;
    return ClientMessage._(type: ClientMessageType.checkOnlineStatus, payload: payload);
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
