import 'dart:typed_data';

import 'package:database_model/src/chat/message.dart';
import 'package:openapi/api.dart';
import 'package:test/test.dart';

void main() {
  group('Message roundtrip', () {
    test('TextMessage', () {
      final message = TextMessage.create('Hello world!');
      expect(message, isNotNull);

      final parsed = Message.parseFromBytes(message!.toMessagePacket());
      expect(parsed, isA<TextMessage>());
      expect((parsed as TextMessage).text, message.text);
    });

    test('VideoCallInvitation', () {
      final message = VideoCallInvitation();

      final parsed = Message.parseFromBytes(message.toMessagePacket());
      expect(parsed, isA<VideoCallInvitation>());
    });

    test('MessageWithReference', () {
      final message = MessageWithReference.create('Reply text', 'referenced-message-id');
      expect(message, isNotNull);

      final parsed = Message.parseFromBytes(message!.toMessagePacket());
      expect(parsed, isA<MessageWithReference>());
      expect((parsed as MessageWithReference).text, message.text);
      expect(parsed.messageId, message.messageId);
    });

    test('ResentMessage wrapping TextMessage', () {
      final original = TextMessage.create('Original message')!;
      final message = ResentMessage(
        original,
        MessageNumber(mn: 1234567890123456789),
        MessageId(id: 'message-id-1'),
        UnixTime(ut: 1733443200000),
      );

      final parsed = Message.parseFromBytes(message.toMessagePacket());
      expect(parsed, isA<ResentMessage>());
      final resent = parsed as ResentMessage;
      expect(resent.messageNumber.mn, message.messageNumber.mn);
      expect(resent.sentUnixTime.ut, message.sentUnixTime.ut);
      expect(resent.messageId.id, message.messageId.id);
      expect(resent.message, isA<TextMessage>());
      expect((resent.message as TextMessage).text, original.text);
    });

    test('ResentMessage wrapping MessageWithReference', () {
      final original = MessageWithReference.create('Original reply', 'ref-id')!;
      final message = ResentMessage(
        original,
        MessageNumber(mn: -987654321),
        MessageId(id: 'message-id-2'),
        UnixTime(ut: -1),
      );

      final parsed = Message.parseFromBytes(message.toMessagePacket());
      expect(parsed, isA<ResentMessage>());
      final resent = parsed as ResentMessage;
      expect(resent.messageNumber.mn, message.messageNumber.mn);
      expect(resent.sentUnixTime.ut, message.sentUnixTime.ut);
      expect(resent.messageId.id, message.messageId.id);
      expect(resent.message, isA<MessageWithReference>());
      final parsedOriginal = resent.message as MessageWithReference;
      expect(parsedOriginal.text, original.text);
      expect(parsedOriginal.messageId, original.messageId);
    });

    test('ResentMessage wrapping ResentMessage', () {
      final inner = ResentMessage(
        TextMessage.create('Innermost')!,
        MessageNumber(mn: 1),
        MessageId(id: 'inner-id'),
        UnixTime(ut: 2),
      );
      final message = ResentMessage(
        inner,
        MessageNumber(mn: 3),
        MessageId(id: 'outer-id'),
        UnixTime(ut: 4),
      );

      final parsed = Message.parseFromBytes(message.toMessagePacket());
      expect(parsed, isA<ResentMessage>());
      final resent = parsed as ResentMessage;
      expect(resent.message, isA<ResentMessage>());
      expect((resent.message as ResentMessage).message, isA<TextMessage>());
    });

    test('Minimal i64 boundary values in ResentMessage', () {
      const values = <int>[
        -0x8000000000000000,
        -0x8000000000000,
        -0x80000000000,
        -0x800000000,
        -0x80000000,
        -0x800000,
        -0x8000,
        -0x80,
        0,
        0x7F,
        0x7FFF,
        0x7FFFFF,
        0x7FFFFFFF,
        0x7FFFFFFFF,
        0x7FFFFFFFFFF,
        0x7FFFFFFFFFFFF,
        0x7FFFFFFFFFFFFFFF,
      ];

      for (final value in values) {
        final message = ResentMessage(
          TextMessage.create('x')!,
          MessageNumber(mn: value),
          MessageId(id: 'id'),
          UnixTime(ut: value),
        );

        final parsed = Message.parseFromBytes(message.toMessagePacket());
        final resent = parsed as ResentMessage;
        expect(resent.messageNumber.mn, value);
        expect(resent.sentUnixTime.ut, value);
      }
    });

    test('UnsupportedMessage roundtrip', () {
      final bytes = Uint8List.fromList([0xFF, 0x01, 0x02]);
      final message = UnsupportedMessage(bytes);

      final parsed = Message.parseFromBytes(message.toMessagePacket());
      expect(parsed, isA<UnsupportedMessage>());
      expect((parsed as UnsupportedMessage).messageBytes, bytes);
    });
  });
}
