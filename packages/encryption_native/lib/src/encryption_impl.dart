

import 'dart:convert';

import 'package:encryption_common/encryption_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:utils/utils.dart';

final log = Logger("SecureStorageManager");

// The key is from this cmd: openssl rand -base64 12
const RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY = "SxxccCgbFSMkdaho";
const RAW_STORAGE_KEY_FOR_BACKGROUND_DB_ENCRYPTION_KEY = "Aeq5gGUHgn6IVqaK";

Future<String> _getStorageKeyForDbEncryptionKey(
  {
    required bool backgroundDb,
  }
) async {
  final String keyRaw;
  if (backgroundDb) {
    keyRaw = RAW_STORAGE_KEY_FOR_BACKGROUND_DB_ENCRYPTION_KEY;
  } else {
    keyRaw = RAW_STORAGE_KEY_FOR_DB_ENCRYPTION_KEY;
  }
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

    const androidOptions = AndroidOptions(
      encryptedSharedPreferences: true,
    );

    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.unlocked,
    );

    storage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );

    _testEncryptionSupport();
  }

  Future<String> getDbEncryptionKeyOrCreateNewKeyAndRecreateDatabasesDir(
    {
      required bool backgroundDb,
      required DatabaseRemover remover,
    }
  ) async {
    if (kIsWeb) {
      throw UnsupportedError("Encryption is not supported on web");
    }

    final IOSOptions iosOptions;
    if (backgroundDb) {
      iosOptions = const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );
    } else {
      iosOptions = const IOSOptions(
        accessibility: KeychainAccessibility.unlocked,
      );
    }

    final key = await _getStorageKeyForDbEncryptionKey(backgroundDb: backgroundDb);
    final value = await storage.read(key: key, iOptions: iosOptions);
    if (value == null) {
      final newValue = _generateDbEncryptionKey();
      await storage.write(key: key, value: newValue, iOptions: iosOptions);
      final newValueReadingTest = await storage.read(key: key, iOptions: iosOptions);
      if (newValueReadingTest != newValue) {
        throw Exception("Failed to read the value that was just written");
      }

      await remover.recreateDatabasesDir(backgroundDb: backgroundDb);

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

void _testEncryptionSupport() {
  final key = Uint8List(16); // 128 bits
  final data = Uint8List(1);
  const plaintext = 123;
  data[0] = plaintext;
  final (encrypted, result) = encryptContentData(data, key);
  if (encrypted == null) {
    final msg = "Encryption test failed with error: $result";
    log.error(msg);
    throw Exception(msg);
  }

  final (decrypted, result2) = decryptContentData(encrypted, key);
  if (decrypted == null) {
    final msg = "Decryption test failed with error: $result2";
    log.error(msg);
    throw Exception(msg);
  }

  if (decrypted[0] != plaintext) {
    const msg = "Encryption support test failed: original data is not equal to decrypted data";
    log.error(msg);
    throw Exception(msg);
  }
}
