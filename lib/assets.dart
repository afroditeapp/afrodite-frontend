


import 'dart:io';

import 'package:flutter/services.dart';

Future<Uint8List> loadServerRootCert() async {
  final data = await rootBundle.load("assets_not_in_git/server_root.crt");
  return data.buffer.asUint8List();
}

Future<SecurityContext> createSecurityContextForBackendConnection() async {
    final context = SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(await loadServerRootCert());
    context.allowLegacyUnsafeRenegotiation = false;
    return context;
}
