


import 'dart:io';
import 'dart:typed_data';

import 'package:openapi/api.dart';

extension CommonManualAdditions on CommonApi {
  /// Download current data export archive
  ///
  /// Requires data export state [DataExportStateType::Done].
  ///
  /// Parameters:
  ///
  /// * [String] name (required):
  Future<Uint8List?> getDataExportArchiveFixed(String name,) async {
    final response = await getDataExportArchiveWithHttpInfo(name,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Data export downloading failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;

    }
    return null;
  }
}

extension MediaManualAdditions on MediaApi {
  /// Get content
  ///
  /// Get content
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [String] contentId (required):
  Future<Uint8List?> getContentFixed(String accountId, String contentId, bool isMatch) async {
    final response = await getContentWithHttpInfo(accountId, contentId, isMatch: isMatch);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Image loading failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;

    }
    return null;
  }

  /// Get map tile PNG file.
  ///
  /// Get map tile PNG file.  Returns a .png even if the URL does not have it.
  ///
  /// Parameters:
  ///
  /// * [int] z (required):
  ///
  /// * [int] x (required):
  ///
  /// * [String] y (required):
  Future<Uint8List?> getMapTileFixed(int z, int x, String y, int version) async {
    final response = await getMapTileWithHttpInfo(z, x, y, version);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Image loading failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;

    }
    return null;
  }
}

extension ChatManualAdditions on ChatApi {
  /// Get list of pending messages.
  ///
  /// The returned bytes is list of objects with following data: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 4, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Receiver AccountId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Receiver public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
  Future<Uint8List?> getPendingMessagesFixed() async {
    final response = await getPendingMessagesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Pending message loading failed");
    }
    return response.bodyBytes;
  }

  /// Get current public key of some account
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [int] id (required):
  Future<Uint8List?> getPublicKeyFixed(String aid, int id,) async {
    final response = await getPublicKeyWithHttpInfo(aid, id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Get public key failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;

    }
    return null;
  }
}
