


import 'dart:io';
import 'dart:typed_data';

import 'package:openapi/api.dart';

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
  Future<Uint8List?> getMapTileFixed(int z, int x, String y,) async {
    final response = await getMapTileWithHttpInfo(z, x, y,);
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
  /// Get list of pending messages.  The returned bytes is list of objects with following data: - UTF-8 text length encoded as 16 bit little endian number. - UTF-8 text which is PendingMessage JSON. - Binary message data length as 16 bit little endian number. - Binary message data
  Future<Uint8List?> getPendingMessagesFixed() async {
    final response = await getPendingMessagesWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Pending message loading failed");
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
