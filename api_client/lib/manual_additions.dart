


  import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:openapi/api.dart';




extension MediaManualAdditions on MediaApi {
  /// Get profile image
  ///
  /// Get profile image
  ///
  /// Parameters:
  ///
  /// * [String] accountId (required):
  ///
  /// * [String] contentId (required):
  Future<Uint8List?> getImageFixed(String accountId, String contentId, bool isMatch) async {
    final response = await getImageWithHttpInfo(accountId, contentId, isMatch);
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