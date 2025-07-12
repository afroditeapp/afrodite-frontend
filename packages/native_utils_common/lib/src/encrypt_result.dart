import 'dart:typed_data';

class EncryptResult {
  final Uint8List pgpMessage;
  final Uint8List sessionKey;
  EncryptResult({required this.pgpMessage, required this.sessionKey});
}
