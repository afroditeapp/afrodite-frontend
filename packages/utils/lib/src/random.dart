
import 'dart:math';
import 'dart:typed_data';

/// 32 bytes
Uint8List generate256BitRandomValue() {
  return _generateRandomBytes(32);
}

Uint8List _generateRandomBytes(int byteCount) {
  final random = Random.secure();
  final data = Uint8List(byteCount);
  for (var i = 0; i < byteCount; i++) {
    data[i] = random.nextInt(256);
  }
  return data;
}
