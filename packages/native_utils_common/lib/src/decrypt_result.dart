import 'package:flutter/services.dart';

class DecryptResult {
  final Uint8List messageData;
  final Uint8List sessionKey;
  DecryptResult({required this.messageData, required this.sessionKey});
}
