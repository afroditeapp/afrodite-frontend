import 'dart:io';
import 'dart:typed_data';

import 'backup/blob.dart';
import 'backup/json.dart';

sealed class BackupFileParseResult {
  const BackupFileParseResult();
}

class BackupFileParseSuccess extends BackupFileParseResult {
  final ChatBackupFile file;
  const BackupFileParseSuccess(this.file);
}

class InvalidBackupHeader extends BackupFileParseResult {
  const InvalidBackupHeader();
}

class UnsupportedBackupFileVersion extends BackupFileParseResult {
  final int version;
  const UnsupportedBackupFileVersion(this.version);
}

class FileTooShort extends BackupFileParseResult {
  const FileTooShort();
}

/// Chat backup file format specification:
///
/// 1. Header: 7 bytes ASCII "abackup"
/// 2. Version: 1 byte (currently 0x01)
/// 3. Compressed data: Gzipped payload containing:
///    - JSON length: 4 bytes (32-bit little endian unsigned integer)
///    - JSON data: Backup metadata and message records
///    - Blob store: Binary blobs referenced by JSON
///
/// The JSON contains:
/// - Backup metadata (creation time, account ID, current keys)
/// - Message records with blob indices for binary data
///
/// The blob store contains:
/// - Symmetric encryption keys
/// - Backend signed PGP messages
///
/// Each message record references blobs by index rather than embedding binary data in JSON.
/// All data after the version byte is gzip compressed for efficient storage.

const List<int> backupHeader = [0x61, 0x62, 0x61, 0x63, 0x6b, 0x75, 0x70]; // "abackup"
const int backupVersion1 = 1;

/// Uncompressed backup data structure
class ChatBackupData {
  final BackupJson json;
  final BackupBlobStore blobStore;

  ChatBackupData({required this.json, required this.blobStore});

  /// Compress and create a ChatBackupFile
  ChatBackupFile compress() {
    final buffer = BytesBuilder();

    // Write JSON length and data
    final jsonBytes = json.toBytes();
    buffer.add(_u32ToBytes(jsonBytes.length));
    buffer.add(jsonBytes);

    // Write blob store
    buffer.add(blobStore.toBytes());

    // Compress the entire payload
    final uncompressedData = buffer.toBytes();
    final compressedData = gzip.encode(uncompressedData);

    return ChatBackupFile(compressedData: compressedData);
  }
}

/// Complete compressed backup file structure
class ChatBackupFile {
  final List<int> compressedData;

  ChatBackupFile({required this.compressedData});

  /// Decompress and get ChatBackupData
  ///
  /// This might throw exceptions.
  ChatBackupData decompress() {
    // Decompress the payload
    final uncompressedData = Uint8List.fromList(gzip.decode(compressedData));
    int pos = 0;

    // Read JSON length and data
    final jsonLength = _readU32(uncompressedData, pos);
    pos += 4;
    final jsonBytes = uncompressedData.sublist(pos, pos + jsonLength);
    pos += jsonLength;

    // Read blob store
    final (blobStore, _) = BackupBlobStore.fromBytes(uncompressedData, pos);

    final json = BackupJson.fromBytes(jsonBytes);

    return ChatBackupData(json: json, blobStore: blobStore);
  }

  /// Serialize entire backup to binary format
  Uint8List toBytes() {
    final buffer = BytesBuilder();

    // Header: "abackup"
    buffer.add(backupHeader);

    // Version: 1
    buffer.add([backupVersion1]);

    // Compressed data (extends to end of file)
    buffer.add(compressedData);

    return buffer.toBytes();
  }

  /// Deserialize backup from binary format
  static BackupFileParseResult fromBytes(Uint8List bytes) {
    int pos = 0;

    // Validate header
    if (bytes.length < backupHeader.length + 1) {
      return const FileTooShort();
    }

    for (int i = 0; i < backupHeader.length; i++) {
      if (bytes[i] != backupHeader[i]) {
        return const InvalidBackupHeader();
      }
    }
    pos += backupHeader.length;

    // Check version
    final version = bytes[pos];
    pos += 1;
    if (version != backupVersion1) {
      return UnsupportedBackupFileVersion(version);
    }

    // Read compressed data (all remaining bytes)
    final compressedData = bytes.sublist(pos);

    return BackupFileParseSuccess(ChatBackupFile(compressedData: compressedData));
  }
}

// Helper functions for byte conversion

Uint8List _u32ToBytes(int value) {
  if (value < 0 || value > 0xFFFFFFFF) {
    throw ArgumentError('Value $value out of range for 32-bit unsigned integer');
  }
  final data = ByteData(4);
  data.setUint32(0, value, Endian.little);
  return data.buffer.asUint8List();
}

int _readU32(Uint8List bytes, int offset) {
  final data = ByteData.sublistView(bytes, offset, offset + 4);
  return data.getUint32(0, Endian.little);
}
