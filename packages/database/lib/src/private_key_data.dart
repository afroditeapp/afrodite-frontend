

import 'package:openapi/api.dart';

class PrivateKeyData {
  final String data;
  const PrivateKeyData({required this.data});
}

class AllKeyData {
  final PrivateKeyData private;
  final PublicKey public;
  const AllKeyData({required this.private, required this.public});
}
