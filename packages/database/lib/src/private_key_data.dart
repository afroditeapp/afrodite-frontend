

import 'dart:typed_data';

import 'package:openapi/api.dart';

class PrivateKeyData {
  final Uint8List data;
  const PrivateKeyData({required this.data});
}

class PublicKeyData {
  final Uint8List data;
  const PublicKeyData({required this.data});
}

class AllKeyData {
  final PrivateKeyData private;
  final PublicKeyData public;
  final PublicKeyId id;
  const AllKeyData({required this.private, required this.public, required this.id});
}

class ForeignPublicKey {
  final Uint8List data;
  final PublicKeyId id;
  const ForeignPublicKey({required this.data, required this.id});
}
