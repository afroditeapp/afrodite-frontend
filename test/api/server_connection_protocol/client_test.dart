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
}
