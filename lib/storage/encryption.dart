
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:pihka_frontend/database/database_manager.dart';
import 'package:utils/utils.dart';

final log = Logger("ImageEncryptionManager");

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
        log.info("Generating a new image encryption key");
        final newKey = await _generateImageEncryptionKey();
        await DatabaseManager.getInstance().commonAction((db) => db.updateImageEncryptionKey(newKey));
        final dbKey = await DatabaseManager.getInstance().commonStreamSingle((db) => db.watchImageEncryptionKey());
        if (!listEquals(newKey, dbKey)) {
          throw Exception("Failed to read the key that was just written");
        }
        _imageEncryptionKey = newKey;
        return newKey;
      } else {
        log.info("Image encryption key already exists");
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
