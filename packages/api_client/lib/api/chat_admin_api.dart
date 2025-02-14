//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ChatAdminApi {
  ChatAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /chat_api/admin/chat_report_pending_processing' operation and returns the [Response].
  Future<Response> getChatReportPendingProcessingListWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/admin/chat_report_pending_processing';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<GetChatReportList?> getChatReportPendingProcessingList() async {
    final response = await getChatReportPendingProcessingListWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetChatReportList',) as GetChatReportList;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /chat_api/admin/process_chat_report' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProcessChatReport] processChatReport (required):
  Future<Response> postProcessChatReportWithHttpInfo(ProcessChatReport processChatReport,) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/admin/process_chat_report';

    // ignore: prefer_final_locals
    Object? postBody = processChatReport;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [ProcessChatReport] processChatReport (required):
  Future<void> postProcessChatReport(ProcessChatReport processChatReport,) async {
    final response = await postProcessChatReportWithHttpInfo(processChatReport,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
