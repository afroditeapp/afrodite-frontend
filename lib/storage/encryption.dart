





import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pihka_frontend/database/database_manager.dart';
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


class ImageEncryptionManager extends AppSingleton {
  static final _instance = ImageEncryptionManager._private();
  ImageEncryptionManager._private();
  factory ImageEncryptionManager.getInstance() {
    return _instance;
  }

  // The key is frequently used so keep it in RAM.
  String? _imageEncryptionKey;

  @override
  Future<void> init() async {
    await _getOrLoadOrGenerateImageEncryptionKey();
  }

  Future<Uint8List> encryptImageData(Uint8List data) async {
    final key = await _getOrLoadOrGenerateImageEncryptionKey();
    // TODO(prod): replace with real encryption

    Uint8List encryptedData = data;
    for (var i = 0; i < key.length; i++) {
      final s = base64.encode(encryptedData);
      encryptedData = utf8.encode(s);
    }

    return encryptedData;
  }

  Future<Uint8List> decryptImageData(Uint8List data) async {
    final key = await _getOrLoadOrGenerateImageEncryptionKey();
    // TODO(prod): replace with real decoding

    Uint8List decodedData = data;
    for (var i = 0; i < key.length; i++) {
      final s = utf8.decode(decodedData.toList());
      decodedData = base64.decode(s);
    }

    return decodedData;
  }

  Future<String> _getOrLoadOrGenerateImageEncryptionKey() async {
    final currentKey = _imageEncryptionKey;
    if (currentKey == null) {
      final existingKey = await DatabaseManager.getInstance().commonStreamSingle((db) => db.watchImageEncryptionKey());
      if (existingKey == null) {
        final newKey = await _generateImageEncryptionKey();
        await DatabaseManager.getInstance().commonAction((db) => db.updateImageEncryptionKey(newKey));
        final testNewKey = await DatabaseManager.getInstance().commonStreamSingle((db) => db.watchImageEncryptionKey());
        if (testNewKey != newKey) {
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

  Future<String> _generateImageEncryptionKey() async {
    // TODO(prod): replace with real key generation
    return "test";
  }
}
