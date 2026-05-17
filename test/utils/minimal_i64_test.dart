import 'dart:typed_data';

import 'package:app/utils/minimal_i64.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('encodeMinimalI64', () {
    test('encodes known byte patterns', () {
      final cases = <(int, List<int>)>[
        (0, [1, 0x00]),
        (127, [1, 0x7F]),
        (128, [2, 0x80, 0x00]),
        (-1, [1, 0xFF]),
        (-128, [1, 0x80]),
        (-129, [2, 0x7F, 0xFF]),
        (32767, [2, 0xFF, 0x7F]),
        (32768, [3, 0x00, 0x80, 0x00]),
        (-32769, [3, 0xFF, 0x7F, 0xFF]),
        (8388607, [3, 0xFF, 0xFF, 0x7F]),
        (8388608, [4, 0x00, 0x00, 0x80, 0x00]),
      ];

      for (final c in cases) {
        expect(encodeMinimalI64(c.$1), equals(Uint8List.fromList(c.$2)));
      }
    });

    test('encodes full 8 bytes at i64 extremes', () {
      final max = encodeMinimalI64(0x7FFFFFFFFFFFFFFF);
      final min = encodeMinimalI64(-0x8000000000000000);

      expect(max[0], 8);
      expect(min[0], 8);
    });
  });

  group('decodeMinimalI64FromBytes', () {
    test('decodes valid signed values', () {
      final cases = <(Uint8List, int)>[
        (Uint8List.fromList([0x00]), 0),
        (Uint8List.fromList([0xFF]), -1),
        (Uint8List.fromList([0x80, 0x00]), 128),
        (Uint8List.fromList([0x7F, 0xFF]), -129),
        (Uint8List.fromList([0xFF, 0x7F, 0xFF]), -32769),
        (Uint8List.fromList([0xFF, 0xFF, 0x7F]), 8388607),
      ];

      for (final c in cases) {
        expect(decodeMinimalI64FromBytes(c.$1), c.$2);
      }
    });

    test('returns zero for empty bytes', () {
      expect(decodeMinimalI64FromBytes(Uint8List.fromList([])), 0);
    });
  });

  group('decodeMinimalI64FromIterator', () {
    test('decodes value and advances iterator correctly', () {
      final iter = Uint8List.fromList([3, 0xFF, 0x7F, 0xFF, 0xAA]).iterator;

      final value = decodeMinimalI64FromIterator(iter);

      expect(value, -32769);
      expect(iter.moveNext(), isTrue);
      expect(iter.current, 0xAA);
    });

    test('returns zero for zero marker', () {
      final iter = Uint8List.fromList([0, 0x00]).iterator;
      expect(decodeMinimalI64FromIterator(iter), 0);

      expect(iter.moveNext(), isTrue);
      expect(iter.current, 0x00);
    });

    test('returns null for invalid marker', () {
      final iter = Uint8List.fromList([9, 0x00]).iterator;
      expect(decodeMinimalI64FromIterator(iter), isNull);
    });

    test('returns null for truncated data', () {
      final iter = Uint8List.fromList([3, 0x01, 0x02]).iterator;
      expect(decodeMinimalI64FromIterator(iter), isNull);
    });
  });

  group('roundtrip', () {
    test('encode and decode returns original values', () {
      const values = <int>[
        -0x8000000000000000,
        -2147483649,
        -8388609,
        -32769,
        -129,
        -128,
        -1,
        0,
        1,
        127,
        128,
        32767,
        32768,
        8388607,
        8388608,
        2147483648,
        0x7FFFFFFFFFFFFFFF,
      ];

      for (final v in values) {
        final encoded = encodeMinimalI64(v);
        final payloadByteCount = encoded[0];
        final payload = Uint8List.sublistView(encoded, 1, 1 + payloadByteCount);
        expect(decodeMinimalI64FromBytes(payload), v);
      }
    });
  });
}
