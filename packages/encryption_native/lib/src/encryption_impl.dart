import 'dart:convert';

import 'package:encryption_common/encryption_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:utils/utils.dart';

// The key is from this cmd: openssl rand -base64 12
const RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY = "SxxccCgbFSMkdaho";

Future<String> _getStorageKeyForDbEncryptionKey() async {
  final keyRaw = RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY;
  // Basic obfuscation about what the key is for
  final keyBytes = utf8.encode(keyRaw);
  final base64String = base64.encode(keyBytes);
  final key = base64String.substring(0, 10);
  return key;
}

class SecureStorageManager extends AppSingleton {
  static final _instance = SecureStorageManager._private();
  SecureStorageManager._private();
  factory SecureStorageManager.getInstance() {
    return _instance;
  }

  late final FlutterSecureStorage storage;

  bool initDone = false;

  @override
  Future<void> init() async {
    if (initDone) {
      return;
    }
    initDone = true;

    const androidOptions = AndroidOptions(encryptedSharedPreferences: true);

    const iosOptions = IOSOptions(accessibility: KeychainAccessibility.unlocked);

    storage = const FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  }

  Future<String> getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir({
    required DatabaseRemover remover,
  }) async {
    if (kIsWeb) {
      throw UnsupportedError("Encryption is not supported on web");
    }

    const iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

    final key = await _getStorageKeyForDbEncryptionKey();
    final value = await storage.read(key: key, iOptions: iosOptions);
    if (value == null) {
      final newValue = _generateDbEncryptionKey();
      await storage.write(key: key, value: newValue, iOptions: iosOptions);
      final newValueReadingTest = await storage.read(key: key, iOptions: iosOptions);
      if (newValueReadingTest != newValue) {
        throw Exception("Failed to read the value that was just written");
      }

      await remover.recreateDatabasesDir();

      return newValue;
    } else {
      return value;
    }
  }

  String _generateDbEncryptionKey() {
    final key = generate256BitRandomValue();
    return base64.encode(key);
  }
}
