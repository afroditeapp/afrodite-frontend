import 'dart:convert';
import 'dart:typed_data';

import 'package:app/api/server_connection_protocol/server.dart';
import 'package:utils/src/minimal_i64.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/api.dart';

/// Builds the three UUIDs used in a profile link item.
({Uint8List accountId, Uint8List profileVersion, Uint8List contentVersion}) _profileLinkUuids() {
  return (
    accountId: Uint8List.fromList(List<int>.generate(16, (index) => index)),
    profileVersion: Uint8List.fromList(List<int>.generate(16, (index) => 100 + index)),
    contentVersion: Uint8List.fromList(List<int>.generate(16, (index) => 200 + index)),
  );
}

void main() {
  group('ServerMessage parser', () {
    test('parses no-payload event type', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([120]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.newMessageReceived);
      expect(parsed.payload, isEmpty);
    });

    test('parses typing start account id from uuid bytes', () {
      final uuid = Uint8List.fromList(List<int>.generate(16, (index) => index));
      final expectedAid = base64UrlEncode(uuid).replaceAll('=', '');

      final parsed = ServerMessage.fromBytes(Uint8List.fromList([124, ...uuid]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.typingStart);
      expect(parsed.typingStart, isA<AccountId>());
      expect(parsed.typingStart!.aid, expectedAid);
    });

    test('parses scheduled maintenance status payload', () {
      const start = 1700000000;
      const end = 1700000600;

      final bytes = Uint8List.fromList([
        3,
        1,
        ...encodeMinimalI64(start),
        ...encodeMinimalI64(end),
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final status = parsed!.scheduledMaintenanceStatus;
      expect(status, isNotNull);
      expect(status!.adminBotOffline, isTrue);
      expect(status.start!.ut, start);
      expect(status.end!.ut, end);
    });

    test('parses admin bot notification bitflags payload', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([4, 0x01, 0x02]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.adminBotNotification);
      expect(parsed.adminBotNotification, 513);
    });

    test('parses websocket connection attempts remaining payload', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([7, 9]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.webSocketConnectionAttemptsRemaining);
      expect(parsed.webSocketConnectionAttemptsRemaining, 9);
    });

    test('parses content processing completed payload', () {
      final contentIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 255 - index));
      final expectedContentId = base64UrlEncode(contentIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([90, 42, 2, ...contentIdUuid, 1]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final stateChanged = parsed!.contentProcessingStateChanged;
      expect(stateChanged, isNotNull);
      expect(stateChanged!.newState.processingIdFromClient, 42);
      expect(stateChanged.newState.state, ContentProcessingStateType.completed);
      expect(stateChanged.newState.cid!.cid, expectedContentId);
      expect(stateChanged.newState.faceDetected, isTrue);
    });

    test('parses content processing in queue payload', () {
      final bytes = Uint8List.fromList([90, 11, 0, ...encodeMinimalI64(7)]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final stateChanged = parsed!.contentProcessingStateChanged;
      expect(stateChanged, isNotNull);
      expect(stateChanged!.newState.processingIdFromClient, 11);
      expect(stateChanged.newState.state, ContentProcessingStateType.inQueue);
      expect(stateChanged.newState.waitQueuePosition, 7);
      expect(stateChanged.newState.cid, isNull);
      expect(stateChanged.newState.faceDetected, isNull);
    });

    test('parses check online status response with last seen', () {
      final accountIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 100 + index));
      final expectedAid = base64UrlEncode(accountIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([126, ...accountIdUuid, ...encodeMinimalI64(-1)]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final response = parsed!.checkOnlineStatusResponse;
      expect(response, isNotNull);
      expect(response!.a.aid, expectedAid);
      expect(response.l, -1);
    });

    test('parses check online status response with null last seen', () {
      final accountIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 50 + index));
      final expectedAid = base64UrlEncode(accountIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([126, ...accountIdUuid, 0]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.onlineStatusUpdated);
      final response = parsed.checkOnlineStatusResponse;
      expect(response, isNotNull);
      expect(response!.a.aid, expectedAid);
      expect(response.l, isNull);
    });

    test('parses check online status response with 3-byte minimal i64', () {
      final accountIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 70 + index));
      final expectedAid = base64UrlEncode(accountIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([126, ...accountIdUuid, 3, 0xFF, 0x7F, 0xFF]);
      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final response = parsed!.checkOnlineStatusResponse;
      expect(response, isNotNull);
      expect(response!.a.aid, expectedAid);
      expect(response.l, -32769);
    });

    test('parses reset profile paging response with session id', () {
      final parsed = ServerMessage.fromBytes(
        Uint8List.fromList([61, 7, 0, ...encodeMinimalI64(12)]),
      );

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseResetProfilePaging);
      expect(parsed.responseId, 7);
      expect(parsed.responseResetProfilePaging, isNotNull);
      expect(parsed.responseResetProfilePaging!.id, 12);
    });

    test('parses reset profile paging response with error status', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([61, 8, 1]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseResetProfilePaging);
      expect(parsed.responseId, 8);
      expect(parsed.responseResetProfilePaging, isNull);
      expect(parsed.rateLimited, isTrue);
    });

    test('parses next profile page response with invalid session status', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([62, 9, 1]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseNextProfilePage);
      expect(parsed.responseId, 9);
      expect(parsed.responseNextProfilePage, isNotNull);
      expect(parsed.responseNextProfilePage!.errorInvalidIteratorSessionId, isTrue);
      expect(parsed.rateLimited, isFalse);
    });

    test('parses next profile page response with rate-limited status', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([62, 10, 2]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseNextProfilePage);
      expect(parsed.responseId, 10);
      expect(parsed.responseNextProfilePage, isNotNull);
      expect(parsed.responseNextProfilePage!.error, isTrue);
      expect(parsed.rateLimited, isTrue);
    });

    test('parses next profile page response with profile link items', () {
      final uuids = _profileLinkUuids();

      final bytes = Uint8List.fromList([
        62,
        11,
        0,
        // item type and size byte: 0 = profile link
        0,
        ...uuids.accountId,
        ...uuids.profileVersion,
        ...uuids.contentVersion,
        // null last seen time
        0,
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseNextProfilePage);
      expect(parsed.responseId, 11);
      final page = parsed.responseNextProfilePage;
      expect(page, isNotNull);
      expect(page!.error, isFalse);
      expect(page.items, hasLength(1));
      final item = page.items.single;
      expect(item.profileLink, isNotNull);
      expect(item.profileLink!.a.aid, base64UrlEncode(uuids.accountId).replaceAll('=', ''));
      expect(item.profileLink!.p.v, base64UrlEncode(uuids.profileVersion).replaceAll('=', ''));
      expect(item.profileLink!.c.v, base64UrlEncode(uuids.contentVersion).replaceAll('=', ''));
      expect(item.profileLink!.l, isNull);
    });

    test('parses next profile page response with last seen time', () {
      final uuids = _profileLinkUuids();

      final bytes = Uint8List.fromList([
        62,
        12,
        0,
        0,
        ...uuids.accountId,
        ...uuids.profileVersion,
        ...uuids.contentVersion,
        ...encodeMinimalI64(1700000000),
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final page = parsed!.responseNextProfilePage;
      expect(page, isNotNull);
      expect(page!.items, hasLength(1));
      expect(page.items.single.profileLink!.l, 1700000000);
    });

    test('parses next profile page response skipping unknown item types', () {
      final uuids = _profileLinkUuids();

      final bytes = Uint8List.fromList([
        62,
        13,
        0,
        // unknown item type 3 with 3 bytes of payload
        3,
        0xAA,
        0xBB,
        0xCC,
        // profile link item
        0,
        ...uuids.accountId,
        ...uuids.profileVersion,
        ...uuids.contentVersion,
        0,
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final page = parsed!.responseNextProfilePage;
      expect(page, isNotNull);
      expect(page!.items, hasLength(2));
      expect(page.items[0].profileLink, isNull);
      expect(page.items[1].profileLink, isNotNull);
    });

    test('fails parsing next profile page response with error item', () {
      final bytes = Uint8List.fromList([
        62,
        14,
        0,
        // error item type 200
        200,
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNull);
    });

    test('parses automatic profile search next profile page response', () {
      final uuids = _profileLinkUuids();

      final bytes = Uint8List.fromList([
        64,
        15,
        0,
        0,
        ...uuids.accountId,
        ...uuids.profileVersion,
        ...uuids.contentVersion,
        0,
      ]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseAutomaticProfileSearchNextProfilePage);
      expect(parsed.responseId, 15);
      final page = parsed.responseAutomaticProfileSearchNextProfilePage;
      expect(page, isNotNull);
      expect(page!.items, hasLength(1));
      expect(page.items.single.profileLink, isNotNull);
    });

    test('parses reset profile paging error status with extra bytes', () {
      // Extra trailing bytes are ignored — status 1 (rate limited) with extra byte 0
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([61, 1, 1, 0]));
      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseResetProfilePaging);
      expect(parsed.responseId, 1);
      expect(parsed.responseResetProfilePaging, isNull);
      expect(parsed.rateLimited, isTrue);
    });

    test('returns null for truncated reset profile paging response payload', () {
      // Missing status byte
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([61, 1]));
      expect(parsed, isNull);
    });

    test('returns null for invalid payload for no-payload type', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([120, 1]));
      expect(parsed, isNull);
    });

    test('returns null for malformed websocket attempts payload', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([7, 1, 2]));
      expect(parsed, isNull);
    });
  });
}
