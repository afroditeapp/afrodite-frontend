





import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/db_dir.dart';

// The key is from this cmd: openssl rand -base64 12
const RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY = "SxxccCgbFSMkdaho";

Future<String> _getStorageKeyForDbEncryptionKey() async {
  // Basic obfuscation about what the key is for
  final keyBytes = utf8.encode(RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY);
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

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );

    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device,
    );

    storage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );

    await _getStorageKeyForDbEncryptionKey();
  }

  Future<String> getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir() async {
    final key = await _getStorageKeyForDbEncryptionKey();
    final value = await storage.read(key: key);
    if (value == null) {
      final newValue = await _generateDbEncryptionKey();
      await storage.write(key: key, value: newValue);
      final newValueReadingTest = await storage.read(key: key);
      if (newValueReadingTest != newValue) {
        throw Exception("Failed to read the value that was just written");
      }

      await DbDirUtils.recreateDatabasesDir();

      return newValue;
    } else {
      return value;
    }
  }

  Future<String> _generateDbEncryptionKey() async {
    // TODO(prod): replace with real key generation
    return "test";
  }
}
