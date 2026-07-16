import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:app/assets.dart';

Future<Client> nonWebHttpClient(String serverAddress) async {
  if (kIsWeb) {
    return Client();
  }
  return IOClient(
    HttpClient(context: await createSecurityContextForBackendConnection(serverAddress)),
  );
}
