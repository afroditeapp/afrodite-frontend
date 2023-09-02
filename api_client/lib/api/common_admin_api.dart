//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonAdminApi {
  CommonAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get latest software build information available for update from manager
  ///
  /// Get latest software build information available for update from manager instance.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  Future<Response> getLatestBuildInfoWithHttpInfo(SoftwareOptions softwareOptions,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/get_latest_build_info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'software_options', softwareOptions));

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

  /// Get latest software build information available for update from manager
  ///
  /// Get latest software build information available for update from manager instance.
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  Future<BuildInfo?> getLatestBuildInfo(SoftwareOptions softwareOptions,) async {
    final response = await getLatestBuildInfoWithHttpInfo(softwareOptions,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BuildInfo',) as BuildInfo;
    
    }
    return null;
  }

  /// Get software version information from manager instance.
  ///
  /// Get software version information from manager instance.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSoftwareInfoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/software_info';

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

  /// Get software version information from manager instance.
  ///
  /// Get software version information from manager instance.
  Future<SoftwareInfo?> getSoftwareInfo() async {
    final response = await getSoftwareInfoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SoftwareInfo',) as SoftwareInfo;
    
    }
    return null;
  }

  /// Get system information from manager instance.
  ///
  /// Get system information from manager instance.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSystemInfoWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/system_info';

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

  /// Get system information from manager instance.
  ///
  /// Get system information from manager instance.
  Future<SystemInfoList?> getSystemInfo() async {
    final response = await getSystemInfoWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemInfoList',) as SystemInfoList;
    
    }
    return null;
  }

  /// Save dynamic backend config.
  ///
  /// Save dynamic backend config.  # Capabilities Requires admin_server_maintentance_save_backend_settings.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BackendConfig] backendConfig (required):
  Future<Response> postBackendConfigWithHttpInfo(BackendConfig backendConfig,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/backend_config';

    // ignore: prefer_final_locals
    Object? postBody = backendConfig;

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

  /// Save dynamic backend config.
  ///
  /// Save dynamic backend config.  # Capabilities Requires admin_server_maintentance_save_backend_settings.
  ///
  /// Parameters:
  ///
  /// * [BackendConfig] backendConfig (required):
  Future<void> postBackendConfig(BackendConfig backendConfig,) async {
    final response = await postBackendConfigWithHttpInfo(backendConfig,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Request building new software from manager instance.
  ///
  /// Request building new software from manager instance.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  Future<Response> postRequestBuildSoftwareWithHttpInfo(SoftwareOptions softwareOptions,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/request_build_software';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'software_options', softwareOptions));

    const contentTypes = <String>[];


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

  /// Request building new software from manager instance.
  ///
  /// Request building new software from manager instance.
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  Future<void> postRequestBuildSoftware(SoftwareOptions softwareOptions,) async {
    final response = await postRequestBuildSoftwareWithHttpInfo(softwareOptions,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Request restarting or reseting backend through app-manager instance.
  ///
  /// Request restarting or reseting backend through app-manager instance.  # Capabilities Requires admin_server_maintentance_restart_backend. Also requires admin_server_maintentance_reset_data if reset_data is true.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [bool] resetData (required):
  Future<Response> postRequestRestartOrResetBackendWithHttpInfo(bool resetData,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/request_restart_or_reset_backend';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'reset_data', resetData));

    const contentTypes = <String>[];


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

  /// Request restarting or reseting backend through app-manager instance.
  ///
  /// Request restarting or reseting backend through app-manager instance.  # Capabilities Requires admin_server_maintentance_restart_backend. Also requires admin_server_maintentance_reset_data if reset_data is true.
  ///
  /// Parameters:
  ///
  /// * [bool] resetData (required):
  Future<void> postRequestRestartOrResetBackend(bool resetData,) async {
    final response = await postRequestRestartOrResetBackendWithHttpInfo(resetData,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Request updating new software from manager instance.
  ///
  /// Request updating new software from manager instance.  Reboot query parameter will force reboot of the server after update. If it is off, the server will be rebooted when the usual reboot check is done.  Reset data query parameter will reset data like defined in current app-manager version. If this is true then specific capability is needed for completing this request.  # Capablities Requires admin_server_maintentance_update_software. Also requires admin_server_maintentance_reset_data if reset_data is true.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  ///
  /// * [bool] reboot (required):
  ///
  /// * [bool] resetData (required):
  Future<Response> postRequestUpdateSoftwareWithHttpInfo(SoftwareOptions softwareOptions, bool reboot, bool resetData,) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/request_update_software';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'software_options', softwareOptions));
      queryParams.addAll(_queryParams('', 'reboot', reboot));
      queryParams.addAll(_queryParams('', 'reset_data', resetData));

    const contentTypes = <String>[];


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

  /// Request updating new software from manager instance.
  ///
  /// Request updating new software from manager instance.  Reboot query parameter will force reboot of the server after update. If it is off, the server will be rebooted when the usual reboot check is done.  Reset data query parameter will reset data like defined in current app-manager version. If this is true then specific capability is needed for completing this request.  # Capablities Requires admin_server_maintentance_update_software. Also requires admin_server_maintentance_reset_data if reset_data is true.
  ///
  /// Parameters:
  ///
  /// * [SoftwareOptions] softwareOptions (required):
  ///
  /// * [bool] reboot (required):
  ///
  /// * [bool] resetData (required):
  Future<void> postRequestUpdateSoftware(SoftwareOptions softwareOptions, bool reboot, bool resetData,) async {
    final response = await postRequestUpdateSoftwareWithHttpInfo(softwareOptions, reboot, resetData,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
