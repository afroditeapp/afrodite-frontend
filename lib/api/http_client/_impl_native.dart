import 'dart:io';

import 'package:app/data/notification_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:app/assets.dart';
import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:google_api_availability/google_api_availability.dart';

// Global CronetEngine instance - only one instance should exist
CronetEngine? _cronetEngine;

Future<Client> nonWebHttpClient(String serverAddress) async {
  // Allow HTTP connections on Android and iOS
  final isHttps = serverAddress.startsWith("https");
  final Client client;
  if (kIsWeb) {
    client = Client();
  } else if (Platform.isAndroid && isHttps) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final androidVersion = androidInfo.version.sdkInt;
    if (androidVersion >= ANDROID_8_API_LEVEL) {
      final availability = await GoogleApiAvailability.instance
          .checkGooglePlayServicesAvailability();
      if (availability == GooglePlayServicesAvailability.success) {
        _cronetEngine ??= CronetEngine.build(
          cacheMode: CacheMode.memory,
          cacheMaxSize: 2 * 1024 * 1024, // 2MB cache
          enableBrotli: true,
          enableHttp2: true,
          enableQuic: false,
        );
        client = CronetClient.fromCronetEngine(_cronetEngine!);
      } else {
        // Fall back to IOClient if Google Play Services is not available
        client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
      }
    } else {
      // Use IOClient on Android versions older than 8.0 because
      // Let's Encrypt certificate must be added in that case.
      client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    }
  } else if (Platform.isIOS && isHttps) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..cache = URLCache.withCapacity(memoryCapacity: 2 * 1024 * 1024);
    client = CupertinoClient.fromSessionConfiguration(config);
  } else {
    client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
  }
  return client;
}
