import 'dart:convert';
import 'dart:typed_data';

import 'package:app/api/server_connection_protocol/client.dart';
import 'package:app/api/server_connection_protocol/server.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/api.dart';

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

      final bytes = Uint8List.fromList([3, 1, ...minimalI64Bytes(start), ...minimalI64Bytes(end)]);

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

    test('parses content processing completed payload', () {
      final contentIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 255 - index));
      final expectedContentId = base64UrlEncode(contentIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([90, ...minimalI64Bytes(42), 3, ...contentIdUuid, 1]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final stateChanged = parsed!.contentProcessingStateChanged;
      expect(stateChanged, isNotNull);
      expect(stateChanged!.id.id, 42);
      expect(stateChanged.newState.state, ContentProcessingStateType.completed);
      expect(stateChanged.newState.cid!.cid, expectedContentId);
      expect(stateChanged.newState.fd, isTrue);
    });

    test('parses content processing in queue payload', () {
      final bytes = Uint8List.fromList([90, ...minimalI64Bytes(11), 1, ...minimalI64Bytes(7)]);

      final parsed = ServerMessage.fromBytes(bytes);

      expect(parsed, isNotNull);
      final stateChanged = parsed!.contentProcessingStateChanged;
      expect(stateChanged, isNotNull);
      expect(stateChanged!.id.id, 11);
      expect(stateChanged.newState.state, ContentProcessingStateType.inQueue);
      expect(stateChanged.newState.waitQueuePosition, 7);
      expect(stateChanged.newState.cid, isNull);
      expect(stateChanged.newState.fd, isNull);
    });

    test('parses check online status response with last seen', () {
      final accountIdUuid = Uint8List.fromList(List<int>.generate(16, (index) => 100 + index));
      final expectedAid = base64UrlEncode(accountIdUuid).replaceAll('=', '');

      final bytes = Uint8List.fromList([126, ...accountIdUuid, ...minimalI64Bytes(-1)]);

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

    test('parses reset profile paging response with session id', () {
      final parsed = ServerMessage.fromBytes(
        Uint8List.fromList([61, 7, 0, ...minimalI64Bytes(12)]),
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
    });

    test('parses next profile page response with invalid session status', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([62, 9, 1]));

      expect(parsed, isNotNull);
      expect(parsed!.type, ServerMessageTypeCode.responseNextProfilePage);
      expect(parsed.responseId, 9);
      expect(parsed.responseNextProfilePage, isNotNull);
      expect(parsed.responseNextProfilePage!.errorInvalidIteratorSessionId, isTrue);
    });

    test('returns null for malformed reset profile paging response payload', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([61, 1, 1, 0]));
      expect(parsed, isNull);
    });

    test('returns null for invalid payload for no-payload type', () {
      final parsed = ServerMessage.fromBytes(Uint8List.fromList([120, 1]));
      expect(parsed, isNull);
    });
  });
}
