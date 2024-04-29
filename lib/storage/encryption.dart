

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:pihka_frontend/utils/db_dir.dart';

final log = Logger("Encryption");

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

    testEncryptionSupport();
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
    final (key, result) = generate256BitSecretKey();
    if (key == null) {
      throw Exception("Failed to generate a key. Error: $result");
    } else {
      return base64.encode(key);
    }
  }
}

class ImageEncryptionManager extends AppSingleton {
  static final _instance = ImageEncryptionManager._private();
  ImageEncryptionManager._private();
  factory ImageEncryptionManager.getInstance() {
    return _instance;
  }

  // The key is frequently used so keep it in RAM.
  Uint8List? _imageEncryptionKey;

  @override
  Future<void> init() async {
    await _getOrLoadOrGenerateImageEncryptionKey();
  }

  Future<Uint8List> encryptImageData(Uint8List data) async {
    if (data.isEmpty) {
      log.warning("Empty data");
      return data;
    }

    final key = await _getOrLoadOrGenerateImageEncryptionKey();
    final (encrypted, result) = encryptContentData(data, key);

    if (encrypted == null) {
      throw Exception("Data encryption failed with error: $result");
    } else {
      return encrypted;
    }
  }

  Future<Uint8List> decryptImageData(Uint8List data) async {
    if (data.isEmpty) {
      log.warning("Empty data");
      return data;
    }

    final key = await _getOrLoadOrGenerateImageEncryptionKey();
    final (decrypted, result) = decryptContentData(data, key);
    if (decrypted == null) {
      throw Exception("Data encryption failed with error: $result");
    } else {
      return decrypted;
    }
  }

  Future<Uint8List> _getOrLoadOrGenerateImageEncryptionKey() async {
    final currentKey = _imageEncryptionKey;
    if (currentKey == null) {
      final existingKey = await DatabaseManager.getInstance().commonStreamSingle((db) => db.watchImageEncryptionKey());
      if (existingKey == null) {
        final newKey = await _generateImageEncryptionKey();
        await DatabaseManager.getInstance().commonAction((db) => db.updateImageEncryptionKey(newKey));
        final dbKey = await DatabaseManager.getInstance().commonStreamSingle((db) => db.watchImageEncryptionKey());
        if (!listEquals(newKey, dbKey)) {
          throw Exception("Failed to read the key that was just written");
        }
        _imageEncryptionKey = newKey;
        return newKey;
      } else {
        _imageEncryptionKey = existingKey;
        return existingKey;
      }
    } else {
      return currentKey;
    }
  }

  Future<Uint8List> _generateImageEncryptionKey() async {
    final (key, result) = generate256BitSecretKey();
    if (key == null) {
      throw Exception("Failed to generate a key. Error: $result");
    } else {
      return key;
    }
  }
}


void testEncryptionSupport() {
  final key = Uint8List(32); // 256 bits
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
