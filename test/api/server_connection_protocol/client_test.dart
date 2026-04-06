import 'dart:convert';
import 'dart:typed_data';

import 'package:app/api/server_connection_protocol/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/api.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ClientMessage account id conversion', () {
    test('typingStart decodes base64url account id without padding', () {
      final uuidBytes = Uint8List.fromList(const Uuid().v4obj().toBytes());
      final aidWithoutPadding = base64UrlEncode(uuidBytes).replaceAll('=', '');

      final message = ClientMessage.typingStart(AccountId(aid: aidWithoutPadding));

      expect(message.payload, equals(uuidBytes));
    });

    test('typingStart decodes base64url account id with padding', () {
      final uuidBytes = Uint8List.fromList(const Uuid().v4obj().toBytes());
      final aidWithPadding = base64UrlEncode(uuidBytes);

      final message = ClientMessage.typingStart(AccountId(aid: aidWithPadding));

      expect(message.payload, equals(uuidBytes));
    });
  });

  group('ClientMessage profile iterator request payloads', () {
    test('requestResetProfilePaging includes request id byte', () {
      final message = ClientMessage.requestResetProfilePaging(17);

      expect(message.payload, equals(Uint8List.fromList([17])));
    });

    test('requestGetNextProfilePage includes request id and session id', () {
      final message = ClientMessage.requestGetNextProfilePage(18, ProfileIteratorSessionId(id: 12));

      expect(message.payload, equals(Uint8List.fromList([18, ...minimalI64Bytes(12)])));
    });

    test('requestAutomaticProfileSearchResetProfilePaging includes request id byte', () {
      final message = ClientMessage.requestAutomaticProfileSearchResetProfilePaging(19);

      expect(message.payload, equals(Uint8List.fromList([19])));
    });

    test('requestAutomaticProfileSearchGetNextProfilePage includes request id and session id', () {
      final message = ClientMessage.requestAutomaticProfileSearchGetNextProfilePage(
        20,
        AutomaticProfileSearchIteratorSessionId(id: 13),
      );

      expect(message.payload, equals(Uint8List.fromList([20, ...minimalI64Bytes(13)])));
    });
  });
}
