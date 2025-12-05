import 'dart:typed_data';

/// Binary blob storage for backup data
/// Blobs are referenced by index from JSON structures
class BackupBlob {
  final Uint8List data;

  BackupBlob(this.data);

  /// Serialize blob with 32-bit length prefix
  Uint8List toBytes() {
    final buffer = BytesBuilder();
    buffer.add(_u32ToBytes(data.length));
    buffer.add(data);
    return buffer.toBytes();
  }

  /// Deserialize blob from bytes
  /// Returns the blob and the number of bytes consumed
  static (BackupBlob, int) fromBytes(Uint8List bytes, int offset) {
    final length = _readU32(bytes, offset);
    final data = bytes.sublist(offset + 4, offset + 4 + length);
    return (BackupBlob(data), 4 + length);
  }
}

/// Collection of binary blobs
class BackupBlobStore {
  final List<BackupBlob> blobs;

  BackupBlobStore(this.blobs);

  /// Serialize all blobs
  Uint8List toBytes() {
    final buffer = BytesBuilder();

    // Write blob count
    buffer.add(_u32ToBytes(blobs.length));

    // Write each blob
    for (final blob in blobs) {
      buffer.add(blob.toBytes());
    }

    return buffer.toBytes();
  }

  /// Deserialize blob store from bytes
  /// Returns the store and the number of bytes consumed
  static (BackupBlobStore, int) fromBytes(Uint8List bytes, int offset) {
    int pos = offset;

    // Read blob count
    final blobCount = _readU32(bytes, pos);
    pos += 4;

    // Read blobs
    final blobs = <BackupBlob>[];
    for (int i = 0; i < blobCount; i++) {
      final (blob, bytesRead) = BackupBlob.fromBytes(bytes, pos);
      blobs.add(blob);
      pos += bytesRead;
    }

    return (BackupBlobStore(blobs), pos - offset);
  }

  /// Get blob by index
  Uint8List? get(int? index) {
    if (index == null || index < 0 || index >= blobs.length) {
      return null;
    }
    return blobs[index].data;
  }

  /// Add blob and return its index
  int add(Uint8List? data) {
    if (data == null) {
      throw ArgumentError('Cannot add null blob');
    }
    blobs.add(BackupBlob(data));
    return blobs.length - 1;
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
