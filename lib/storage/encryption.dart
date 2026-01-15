import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:native_utils/native_utils.dart';
import 'package:app/database/common_database_manager.dart';
import 'package:utils/utils.dart';

final _log = Logger("ImageEncryptionManager");

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
    if (!kIsWeb) {
      await _getOrLoadOrGenerateImageEncryptionKey();
    }
  }

  /// The data must not be empty
  Future<Uint8List> encryptImageData(Uint8List data) async {
    if (kIsWeb) {
      throw UnsupportedError("Image data encrypting is not supported on web");
    }

    if (data.isEmpty) {
      throw Exception("Empty data");
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
    if (kIsWeb) {
      throw UnsupportedError("Image data decrypting is not supported on web");
    }

    if (data.isEmpty) {
      _log.warning("Empty data");
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
      final existingKey = await CommonDatabaseManager.getInstance().commonStreamSingle(
        (db) => db.app.watchImageEncryptionKey(),
      );
      if (existingKey == null) {
        _log.info("Generating a new image encryption key");
        final newKey = _generateImageEncryptionKey();
        await CommonDatabaseManager.getInstance().commonAction(
          (db) => db.app.updateImageEncryptionKey(newKey),
        );
        final dbKey = await CommonDatabaseManager.getInstance().commonStreamSingle(
          (db) => db.app.watchImageEncryptionKey(),
        );
        if (!listEquals(newKey, dbKey)) {
          throw Exception("Failed to read the key that was just written");
        }
        _imageEncryptionKey = newKey;
        return newKey;
      } else {
        _log.info("Image encryption key already exists");
        _imageEncryptionKey = existingKey;
        return existingKey;
      }
    } else {
      return currentKey;
    }
  }

  Uint8List _generateImageEncryptionKey() {
    return generate128BitRandomValue();
  }
}
