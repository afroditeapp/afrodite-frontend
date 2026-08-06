//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonAdminApi {
  CommonAdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get admin notification settings.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAdminNotificationSettingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/admin_notification_settings';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get admin notification settings.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  Future<AdminNotificationSettings?> getAdminNotificationSettings({ Future<void>? abortTrigger, }) async {
    final response = await getAdminNotificationSettingsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminNotificationSettings',) as AdminNotificationSettings;
    
    }
    return null;
  }

  /// Get admin notification subscriptions.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAdminNotificationSubscriptionsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/admin_notification_subscriptions';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get admin notification subscriptions.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  Future<AdminNotification?> getAdminNotificationSubscriptions({ Future<void>? abortTrigger, }) async {
    final response = await getAdminNotificationSubscriptionsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AdminNotification',) as AdminNotification;
    
    }
    return null;
  }

  /// Get bot config.
  ///
  /// # Access * [Permissions::admin_server_view_bot_config] * Bot account
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getBotConfigWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/bot_config';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get bot config.
  ///
  /// # Access * [Permissions::admin_server_view_bot_config] * Bot account
  Future<BotConfig?> getBotConfig({ Future<void>? abortTrigger, }) async {
    final response = await getBotConfigWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BotConfig',) as BotConfig;
    
    }
    return null;
  }

  /// Get server config.
  ///
  /// # Access * [Permissions::admin_server_view_server_config]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getDynamicServerConfigWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/dynamic_server_config';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get server config.
  ///
  /// # Access * [Permissions::admin_server_view_server_config]
  Future<DynamicServerConfig?> getDynamicServerConfig({ Future<void>? abortTrigger, }) async {
    final response = await getDynamicServerConfigWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DynamicServerConfig',) as DynamicServerConfig;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /common_api/latest_report_iterator_start_position' operation and returns the [Response].
  Future<Response> getLatestReportIteratorStartPositionWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/latest_report_iterator_start_position';

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
      abortTrigger: abortTrigger,
    );
  }

  Future<UnixTime?> getLatestReportIteratorStartPosition({ Future<void>? abortTrigger, }) async {
    final response = await getLatestReportIteratorStartPositionWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'UnixTime',) as UnixTime;
    
    }
    return null;
  }

  /// Get maintenance notification.
  ///
  /// # Permissions Requires admin_server_edit_maintenance_notification.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMaintenanceNotificationWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/maintenance_notification';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get maintenance notification.
  ///
  /// # Permissions Requires admin_server_edit_maintenance_notification.
  Future<ServerMaintenanceStatus?> getMaintenanceNotification({ Future<void>? abortTrigger, }) async {
    final response = await getMaintenanceNotificationWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServerMaintenanceStatus',) as ServerMaintenanceStatus;
    
    }
    return null;
  }

  /// Get available manager instances.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info] * Permission [model::Permissions::admin_server_software_update] * Permission [model::Permissions::admin_server_data_reset] * Permission [model::Permissions::admin_server_restart] * Permission [model::Permissions::admin_server_reboot] * Permission [model::Permissions::admin_server_shutdown] * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getManagerInstanceNamesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/manager_instance_names';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get available manager instances.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info] * Permission [model::Permissions::admin_server_software_update] * Permission [model::Permissions::admin_server_data_reset] * Permission [model::Permissions::admin_server_restart] * Permission [model::Permissions::admin_server_reboot] * Permission [model::Permissions::admin_server_shutdown] * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  Future<ManagerInstanceNameList?> getManagerInstanceNames({ Future<void>? abortTrigger, }) async {
    final response = await getManagerInstanceNamesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ManagerInstanceNameList',) as ManagerInstanceNameList;
    
    }
    return null;
  }

  /// Get scheduled tasks status from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getScheduledTasksStatusWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/scheduled_tasks_status';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get scheduled tasks status from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<ScheduledTaskStatus?> getScheduledTasksStatus(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await getScheduledTasksStatusWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ScheduledTaskStatus',) as ScheduledTaskStatus;
    
    }
    return null;
  }

  /// Get server version.
  ///
  /// # Permissions Requires admin_server_view_info.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getServerVersionWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/server_version';

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get server version.
  ///
  /// # Permissions Requires admin_server_view_info.
  Future<ServerVersion?> getServerVersion({ Future<void>? abortTrigger, }) async {
    final response = await getServerVersionWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServerVersion',) as ServerVersion;
    
    }
    return null;
  }

  /// Get software version information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getSoftwareUpdateStatusWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/software_info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get software version information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<SoftwareUpdateStatus?> getSoftwareUpdateStatus(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await getSoftwareUpdateStatusWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SoftwareUpdateStatus',) as SoftwareUpdateStatus;
    
    }
    return null;
  }

  /// Get system information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> getSystemInfoWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/system_info';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Get system information from manager instance.
  ///
  /// # Access * Permission [model::Permissions::admin_server_view_info]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<SystemInfo?> getSystemInfo(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await getSystemInfoWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SystemInfo',) as SystemInfo;
    
    }
    return null;
  }

  /// Save admin notification settings.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminNotificationSettings] adminNotificationSettings (required):
  Future<Response> postAdminNotificationSettingsWithHttpInfo(AdminNotificationSettings adminNotificationSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/admin_notification_settings';

    // ignore: prefer_final_locals
    Object? postBody = adminNotificationSettings;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Save admin notification settings.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Parameters:
  ///
  /// * [AdminNotificationSettings] adminNotificationSettings (required):
  Future<void> postAdminNotificationSettings(AdminNotificationSettings adminNotificationSettings, { Future<void>? abortTrigger, }) async {
    final response = await postAdminNotificationSettingsWithHttpInfo(adminNotificationSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save admin notification subscriptions.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminNotification] adminNotification (required):
  Future<Response> postAdminNotificationSubscriptionsWithHttpInfo(AdminNotification adminNotification, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/admin_notification_subscriptions';

    // ignore: prefer_final_locals
    Object? postBody = adminNotification;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Save admin notification subscriptions.
  ///
  /// # Access Requires [Permissions::admin_subscribe_admin_notifications].
  ///
  /// Parameters:
  ///
  /// * [AdminNotification] adminNotification (required):
  Future<void> postAdminNotificationSubscriptions(AdminNotification adminNotification, { Future<void>? abortTrigger, }) async {
    final response = await postAdminNotificationSubscriptionsWithHttpInfo(adminNotification, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save bot config.
  ///
  /// # Validation The following fields must contain exactly one `{text}` placeholder: * `profile_name_moderation.llm.user_text_template` * `profile_text_moderation.llm.user_text_template` * `report_processing.profile_name.llm.user_text_template` * `report_processing.profile_text.llm.user_text_template` * `report_processing.messages.llm.user_text_template` * `report_processing.messages.llm.report_creator_message_template` * `report_processing.messages.llm.report_target_message_template`  # Access * [Permissions::admin_server_edit_bot_config]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BotConfig] botConfig (required):
  Future<Response> postBotConfigWithHttpInfo(BotConfig botConfig, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/bot_config';

    // ignore: prefer_final_locals
    Object? postBody = botConfig;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Save bot config.
  ///
  /// # Validation The following fields must contain exactly one `{text}` placeholder: * `profile_name_moderation.llm.user_text_template` * `profile_text_moderation.llm.user_text_template` * `report_processing.profile_name.llm.user_text_template` * `report_processing.profile_text.llm.user_text_template` * `report_processing.messages.llm.user_text_template` * `report_processing.messages.llm.report_creator_message_template` * `report_processing.messages.llm.report_target_message_template`  # Access * [Permissions::admin_server_edit_bot_config]
  ///
  /// Parameters:
  ///
  /// * [BotConfig] botConfig (required):
  Future<void> postBotConfig(BotConfig botConfig, { Future<void>? abortTrigger, }) async {
    final response = await postBotConfigWithHttpInfo(botConfig, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save server config.
  ///
  /// # Access * [Permissions::admin_server_edit_server_config]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DynamicServerConfig] dynamicServerConfig (required):
  Future<Response> postDynamicServerConfigWithHttpInfo(DynamicServerConfig dynamicServerConfig, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/dynamic_server_config';

    // ignore: prefer_final_locals
    Object? postBody = dynamicServerConfig;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Save server config.
  ///
  /// # Access * [Permissions::admin_server_edit_server_config]
  ///
  /// Parameters:
  ///
  /// * [DynamicServerConfig] dynamicServerConfig (required):
  Future<void> postDynamicServerConfig(DynamicServerConfig dynamicServerConfig, { Future<void>? abortTrigger, }) async {
    final response = await postDynamicServerConfigWithHttpInfo(dynamicServerConfig, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Edit maintenance notification
  ///
  /// # Permissions Requires admin_server_edit_maintenance_notification.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ServerMaintenanceStatus] serverMaintenanceStatus (required):
  Future<Response> postEditMaintenanceNotificationWithHttpInfo(ServerMaintenanceStatus serverMaintenanceStatus, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/edit_maintenance_notification';

    // ignore: prefer_final_locals
    Object? postBody = serverMaintenanceStatus;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Edit maintenance notification
  ///
  /// # Permissions Requires admin_server_edit_maintenance_notification.
  ///
  /// Parameters:
  ///
  /// * [ServerMaintenanceStatus] serverMaintenanceStatus (required):
  Future<void> postEditMaintenanceNotification(ServerMaintenanceStatus serverMaintenanceStatus, { Future<void>? abortTrigger, }) async {
    final response = await postEditMaintenanceNotificationWithHttpInfo(serverMaintenanceStatus, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get API usage data for account
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires [Permissions::admin_view_account_api_usage].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetApiUsageStatisticsSettings] getApiUsageStatisticsSettings (required):
  Future<Response> postGetApiUsageDataWithHttpInfo(GetApiUsageStatisticsSettings getApiUsageStatisticsSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/api_usage_data';

    // ignore: prefer_final_locals
    Object? postBody = getApiUsageStatisticsSettings;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get API usage data for account
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires [Permissions::admin_view_account_api_usage].
  ///
  /// Parameters:
  ///
  /// * [GetApiUsageStatisticsSettings] getApiUsageStatisticsSettings (required):
  Future<GetApiUsageStatisticsResult?> postGetApiUsageData(GetApiUsageStatisticsSettings getApiUsageStatisticsSettings, { Future<void>? abortTrigger, }) async {
    final response = await postGetApiUsageDataWithHttpInfo(getApiUsageStatisticsSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetApiUsageStatisticsResult',) as GetApiUsageStatisticsResult;
    
    }
    return null;
  }

  /// Get all chat message reports. The reports are ordered by message sending order from oldest to latest.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetChatMessageReports] getChatMessageReports (required):
  Future<Response> postGetChatMessageReportsWithHttpInfo(GetChatMessageReports getChatMessageReports, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/chat_api/get_chat_message_reports';

    // ignore: prefer_final_locals
    Object? postBody = getChatMessageReports;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get all chat message reports. The reports are ordered by message sending order from oldest to latest.
  ///
  /// Parameters:
  ///
  /// * [GetChatMessageReports] getChatMessageReports (required):
  Future<GetReportList?> postGetChatMessageReports(GetChatMessageReports getChatMessageReports, { Future<void>? abortTrigger, }) async {
    final response = await postGetChatMessageReportsWithHttpInfo(getChatMessageReports, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetReportList',) as GetReportList;
    
    }
    return null;
  }

  /// Get IP address usage data for account
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires [Permissions::admin_view_account_ip_address_usage].
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetIpAddressStatisticsSettings] getIpAddressStatisticsSettings (required):
  Future<Response> postGetIpAddressUsageDataWithHttpInfo(GetIpAddressStatisticsSettings getIpAddressStatisticsSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/ip_address_usage_data';

    // ignore: prefer_final_locals
    Object? postBody = getIpAddressStatisticsSettings;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get IP address usage data for account
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires [Permissions::admin_view_account_ip_address_usage].
  ///
  /// Parameters:
  ///
  /// * [GetIpAddressStatisticsSettings] getIpAddressStatisticsSettings (required):
  Future<GetIpAddressStatisticsResult?> postGetIpAddressUsageData(GetIpAddressStatisticsSettings getIpAddressStatisticsSettings, { Future<void>? abortTrigger, }) async {
    final response = await postGetIpAddressUsageDataWithHttpInfo(getIpAddressStatisticsSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetIpAddressStatisticsResult',) as GetIpAddressStatisticsResult;
    
    }
    return null;
  }

  /// Get IP country statistics.
  ///
  /// HTTP method is POST to allow JSON request body.  # Permissions Requires admin_server_view_info.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetIpCountryStatisticsSettings] getIpCountryStatisticsSettings (required):
  Future<Response> postGetIpCountryStatisticsWithHttpInfo(GetIpCountryStatisticsSettings getIpCountryStatisticsSettings, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/ip_country_statistics';

    // ignore: prefer_final_locals
    Object? postBody = getIpCountryStatisticsSettings;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get IP country statistics.
  ///
  /// HTTP method is POST to allow JSON request body.  # Permissions Requires admin_server_view_info.
  ///
  /// Parameters:
  ///
  /// * [GetIpCountryStatisticsSettings] getIpCountryStatisticsSettings (required):
  Future<GetIpCountryStatisticsResult?> postGetIpCountryStatistics(GetIpCountryStatisticsSettings getIpCountryStatisticsSettings, { Future<void>? abortTrigger, }) async {
    final response = await postGetIpCountryStatisticsWithHttpInfo(getIpCountryStatisticsSettings, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetIpCountryStatisticsResult',) as GetIpCountryStatisticsResult;
    
    }
    return null;
  }

  /// Get performance data
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires admin_server_view_info.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PerfMetricQuery] perfMetricQuery (required):
  Future<Response> postGetPerfDataWithHttpInfo(PerfMetricQuery perfMetricQuery, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/perf_data';

    // ignore: prefer_final_locals
    Object? postBody = perfMetricQuery;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get performance data
  ///
  /// HTTP method is POST because JSON request body requires it.  # Permissions Requires admin_server_view_info.
  ///
  /// Parameters:
  ///
  /// * [PerfMetricQuery] perfMetricQuery (required):
  Future<PerfMetricQueryResult?> postGetPerfData(PerfMetricQuery perfMetricQuery, { Future<void>? abortTrigger, }) async {
    final response = await postGetPerfDataWithHttpInfo(perfMetricQuery, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PerfMetricQueryResult',) as PerfMetricQueryResult;
    
    }
    return null;
  }

  /// Get report iterator page.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ReportIteratorQuery] reportIteratorQuery (required):
  Future<Response> postGetReportIteratorPageWithHttpInfo(ReportIteratorQuery reportIteratorQuery, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/report_iterator_page';

    // ignore: prefer_final_locals
    Object? postBody = reportIteratorQuery;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get report iterator page.
  ///
  /// The HTTP method is POST because HTTP GET does not allow request body.
  ///
  /// Parameters:
  ///
  /// * [ReportIteratorQuery] reportIteratorQuery (required):
  Future<GetReportList?> postGetReportIteratorPage(ReportIteratorQuery reportIteratorQuery, { Future<void>? abortTrigger, }) async {
    final response = await postGetReportIteratorPageWithHttpInfo(reportIteratorQuery, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetReportList',) as GetReportList;
    
    }
    return null;
  }

  /// Get max 25 reports from the report queue. Returns reports from oldest to newest.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetReportQueuePage] getReportQueuePage (required):
  Future<Response> postGetReportQueuePageWithHttpInfo(GetReportQueuePage getReportQueuePage, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/report_queue_page';

    // ignore: prefer_final_locals
    Object? postBody = getReportQueuePage;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Get max 25 reports from the report queue. Returns reports from oldest to newest.
  ///
  /// Parameters:
  ///
  /// * [GetReportQueuePage] getReportQueuePage (required):
  Future<GetReportList?> postGetReportQueuePage(GetReportQueuePage getReportQueuePage, { Future<void>? abortTrigger, }) async {
    final response = await postGetReportQueuePageWithHttpInfo(getReportQueuePage, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetReportList',) as GetReportList;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /common_api/process_reports' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ProcessReports] processReports (required):
  Future<Response> postProcessReportsWithHttpInfo(ProcessReports processReports, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/process_reports';

    // ignore: prefer_final_locals
    Object? postBody = processReports;

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
      abortTrigger: abortTrigger,
    );
  }

  /// Parameters:
  ///
  /// * [ProcessReports] processReports (required):
  Future<void> postProcessReports(ProcessReports processReports, { Future<void>? abortTrigger, }) async {
    final response = await postProcessReportsWithHttpInfo(processReports, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Schedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  ///
  /// * [bool] notifyServer (required):
  Future<Response> postScheduleTaskWithHttpInfo(String managerName, ScheduledTaskType scheduledTaskType, bool notifyServer, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/schedule_task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'scheduled_task_type', scheduledTaskType));
      queryParams.addAll(_queryParams('', 'notify_server', notifyServer));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Schedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  ///
  /// * [bool] notifyServer (required):
  Future<void> postScheduleTask(String managerName, ScheduledTaskType scheduledTaskType, bool notifyServer, { Future<void>? abortTrigger, }) async {
    final response = await postScheduleTaskWithHttpInfo(managerName, scheduledTaskType, notifyServer, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger server data reset.
  ///
  /// This API route will fail if server config file field debug_allow_backend_data_reset is not true.  Registering new accounts will be prevented and all accounts will be deleted. After that manager will stop the server, delete server's data directory and start the server.  This can be requested only once per server process.  Account registering prevention is process specific, so restarting server will disable that.  # Access * Permission [model::Permissions::admin_server_data_reset]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerServerDataResetWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_server_data_reset';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger server data reset.
  ///
  /// This API route will fail if server config file field debug_allow_backend_data_reset is not true.  Registering new accounts will be prevented and all accounts will be deleted. After that manager will stop the server, delete server's data directory and start the server.  This can be requested only once per server process.  Account registering prevention is process specific, so restarting server will disable that.  # Access * Permission [model::Permissions::admin_server_data_reset]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerServerDataReset(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerServerDataResetWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger server restart.
  ///
  /// # Access * Permission [model::Permissions::admin_server_restart]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerServerRestartWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_server_restart';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger server restart.
  ///
  /// # Access * Permission [model::Permissions::admin_server_restart]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerServerRestart(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerServerRestartWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger software update download.
  ///
  /// # Access * Permission [model::Permissions::admin_server_software_update]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerSoftwareUpdateDownloadWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_software_update_download';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger software update download.
  ///
  /// # Access * Permission [model::Permissions::admin_server_software_update]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerSoftwareUpdateDownload(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerSoftwareUpdateDownloadWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger software update install.
  ///
  /// # Access * Permission [model::Permissions::admin_server_software_update]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [String] name (required):
  ///
  /// * [String] sha256 (required):
  Future<Response> postTriggerSoftwareUpdateInstallWithHttpInfo(String managerName, String name, String sha256, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_software_update_install';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'name', name));
      queryParams.addAll(_queryParams('', 'sha256', sha256));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger software update install.
  ///
  /// # Access * Permission [model::Permissions::admin_server_software_update]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [String] name (required):
  ///
  /// * [String] sha256 (required):
  Future<void> postTriggerSoftwareUpdateInstall(String managerName, String name, String sha256, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerSoftwareUpdateInstallWithHttpInfo(managerName, name, sha256, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger system reboot.
  ///
  /// # Access * Permission [model::Permissions::admin_server_reboot]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerSystemRebootWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_system_reboot';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger system reboot.
  ///
  /// # Access * Permission [model::Permissions::admin_server_reboot]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerSystemReboot(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerSystemRebootWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Trigger system shutdown.
  ///
  /// # Access * Permission [model::Permissions::admin_server_shutdown]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<Response> postTriggerSystemShutdownWithHttpInfo(String managerName, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/trigger_system_shutdown';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Trigger system shutdown.
  ///
  /// # Access * Permission [model::Permissions::admin_server_shutdown]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  Future<void> postTriggerSystemShutdown(String managerName, { Future<void>? abortTrigger, }) async {
    final response = await postTriggerSystemShutdownWithHttpInfo(managerName, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Unschedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  Future<Response> postUnscheduleTaskWithHttpInfo(String managerName, ScheduledTaskType scheduledTaskType, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/common_api/unschedule_task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'manager_name', managerName));
      queryParams.addAll(_queryParams('', 'scheduled_task_type', scheduledTaskType));

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Unschedule task.
  ///
  /// # Access * Permission [model::Permissions::admin_server_scheduled_restart] * Permission [model::Permissions::admin_server_scheduled_reboot]
  ///
  /// Parameters:
  ///
  /// * [String] managerName (required):
  ///
  /// * [ScheduledTaskType] scheduledTaskType (required):
  Future<void> postUnscheduleTask(String managerName, ScheduledTaskType scheduledTaskType, { Future<void>? abortTrigger, }) async {
    final response = await postUnscheduleTaskWithHttpInfo(managerName, scheduledTaskType, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
