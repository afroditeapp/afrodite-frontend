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
  Future<Uint8List?> getDataExportArchiveFixed(String name) async {
    final response = await getDataExportArchiveWithHttpInfo(name);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Data export downloading failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;
    }
    return null;
  }
}

sealed class ContentQualityResult {}

class ContentQualityData extends ContentQualityResult {
  final Uint8List data;
  final String etag;
  final Duration cacheControlMaxAge;
  ContentQualityData(this.data, {required this.etag, required this.cacheControlMaxAge});
}

class ContentQualityNotModified extends ContentQualityResult {
  final Uint8List? data;
  final String etag;
  final Duration cacheControlMaxAge;
  ContentQualityNotModified({this.data, required this.etag, required this.cacheControlMaxAge});
}

sealed class MapTileContentResult {}

class MapTileContentData extends MapTileContentResult {
  final Uint8List data;
  final String etag;
  final Duration cacheControlMaxAge;
  MapTileContentData(this.data, {required this.etag, required this.cacheControlMaxAge});
}

class MapTileContentNotModified extends MapTileContentResult {
  final Uint8List? data;
  final String etag;
  final Duration cacheControlMaxAge;
  MapTileContentNotModified({this.data, required this.etag, required this.cacheControlMaxAge});
}

Duration? _parseCacheControlMaxAge(String? cacheControl) {
  if (cacheControl == null) return null;
  final regex = RegExp(r'max-age=(\d+)');
  final match = regex.firstMatch(cacheControl);
  if (match == null) return null;
  final age = match.group(1);
  if (age == null) return null;
  final seconds = int.tryParse(age);
  if (seconds == null) return null;
  return Duration(seconds: seconds);
}

extension MediaManualAdditions on MediaApi {
  /// Get content with optional conditional request via If-None-Match.
  Future<ContentQualityResult> getContentFixed(
    String accountId,
    String contentId,
    bool isMatch,
    String quality, {
    String? ifNoneMatch,
  }) async {
    final path = r'/media_api/content/{aid}/{cid}'
        .replaceAll('{aid}', accountId)
        .replaceAll('{cid}', contentId);

    final queryParams = <QueryParam>[
      QueryParam('is_match', isMatch.toString()),
      QueryParam('q', quality),
    ];
    final headerParams = <String, String>{};
    if (ifNoneMatch != null) {
      headerParams['If-None-Match'] = '"$ifNoneMatch"';
    }

    final response = await apiClient.invokeAPI(
      path, 'GET', queryParams, null, headerParams, {}, null,
    );

    if (response.statusCode == HttpStatus.notModified) {
      // 304 Not Modified — cached data is still valid
      // Browser may return cached data body on web even with 304.
      final etag = response.headers['etag']?.replaceAll('"', '');
      final cacheControl = _parseCacheControlMaxAge(response.headers['cache-control']);
      final data = response.body.isNotEmpty ? response.bodyBytes : null;
      if (etag != null && cacheControl != null) {
        return ContentQualityNotModified(data: data, etag: etag, cacheControlMaxAge: cacheControl);
      }
      throw ApiException(response.statusCode, "Invalid response");
    }

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Image loading failed");
    }

    final data = response.body.isNotEmpty &&
            response.statusCode != HttpStatus.noContent
        ? response.bodyBytes
        : null;
    final etag = response.headers['etag']?.replaceAll('"', '');
    final cacheControl = _parseCacheControlMaxAge(response.headers['cache-control']);
    if (data != null && etag != null && cacheControl != null) {
      return ContentQualityData(data, etag: etag, cacheControlMaxAge: cacheControl);
    }
    throw ApiException(response.statusCode, "Invalid response");
  }

  /// Get map tile PNG with optional conditional request via If-None-Match.
  Future<MapTileContentResult> getMapTileFixed(
    int z,
    int x,
    String y,
    int version, {
    String? ifNoneMatch,
  }) async {
    final path = r'/media_api/map_tile/{z}/{x}/{y}'
        .replaceAll('{z}', z.toString())
        .replaceAll('{x}', x.toString())
        .replaceAll('{y}', y);

    final queryParams = <QueryParam>[
      QueryParam('v', version.toString()),
    ];
    final headerParams = <String, String>{};
    if (ifNoneMatch != null) {
      headerParams['If-None-Match'] = '"$ifNoneMatch"';
    }

    final response = await apiClient.invokeAPI(
      path, 'GET', queryParams, null, headerParams, {}, null,
    );

    if (response.statusCode == HttpStatus.notModified) {
      // 304 Not Modified — cached data is still valid
      // Browser may return cached data body on web even with 304.
      final etag = response.headers['etag']?.replaceAll('"', '');
      final cacheControl = _parseCacheControlMaxAge(response.headers['cache-control']);
      final data = response.body.isNotEmpty ? response.bodyBytes : null;
      if (etag != null && cacheControl != null) {
        return MapTileContentNotModified(data: data, etag: etag, cacheControlMaxAge: cacheControl);
      }
      throw ApiException(response.statusCode, "Invalid response");
    }

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Map tile loading failed");
    }

    final data = response.body.isNotEmpty &&
            response.statusCode != HttpStatus.noContent
        ? response.bodyBytes
        : null;
    final etag = response.headers['etag']?.replaceAll('"', '');
    final cacheControl = _parseCacheControlMaxAge(response.headers['cache-control']);
    if (data != null && etag != null && cacheControl != null) {
      return MapTileContentData(data, etag: etag, cacheControlMaxAge: cacheControl);
    }
    throw ApiException(response.statusCode, "Invalid response");
  }

  /// Get current profile content for selected profile as compact binary payload.
  ///
  /// See [getProfileContentInfoBinary] for more documentation.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] version:
  ///
  /// * [bool] isMatch:
  Future<Uint8List?> getProfileContentInfoBinaryFixed(
    String aid, {
    String? version,
    bool? isMatch,
  }) async {
    final response = await getProfileContentInfoBinaryWithHttpInfo(
      aid,
      version: version,
      isMatch: isMatch,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
        response.statusCode,
        "Profile content download failed",
      );
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;
    }
    return null;
  }
}

extension ProfileManualAdditions on ProfileApi {
  /// Get account's current profile as compact binary payload.
  ///
  /// See [getProfileBinary] for more documentation.
  ///
  /// Parameters:
  ///
  /// * [String] aid (required):
  ///
  /// * [String] v:
  ///
  /// * [bool] isMatch:
  Future<Uint8List?> getProfileBinaryFixed(
    String aid, {
    String? v,
    bool? isMatch,
  }) async {
    final response = await getProfileBinaryWithHttpInfo(
      aid,
      v: v,
      isMatch: isMatch,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Profile download failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;
    }
    return null;
  }
}

extension ChatManualAdditions on ChatApi {
  /// Get list of pending messages.
  ///
  /// The returned bytes is list of objects with following data: - Binary data length as minimal i64 - Binary data  Minimal i64 has this format: - i64 byte count (u8, values: 1, 2, 3, 4, 5, 6, 7, 8) - i64 bytes (little-endian)  Binary data is binary PGP message which contains backend signed binary data. The binary data contains: - Version (u8, values: 1) - Sender AccountId UUID big-endian bytes (16 bytes) - Recipient AccountId UUID big-endian bytes (16 bytes) - Sender public key ID (minimal i64) - Recipient public key ID (minimal i64) - Message number (minimal i64) - Unix time (minimal i64) - Message data
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
  Future<Uint8List?> getPublicKeyFixed(String aid, int id) async {
    final response = await getPublicKeyWithHttpInfo(aid, id);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, "Get public key failed");
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return response.bodyBytes;
    }
    return null;
  }
}
