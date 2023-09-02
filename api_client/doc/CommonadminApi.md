# openapi.api.CommonAdminApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getLatestBuildInfo**](CommonAdminApi.md#getlatestbuildinfo) | **GET** /common_api/get_latest_build_info | Get latest software build information available for update from manager
[**getSoftwareInfo**](CommonAdminApi.md#getsoftwareinfo) | **GET** /common_api/software_info | Get software version information from manager instance.
[**getSystemInfo**](CommonAdminApi.md#getsysteminfo) | **GET** /common_api/system_info | Get system information from manager instance.
[**postBackendConfig**](CommonAdminApi.md#postbackendconfig) | **POST** /common_api/backend_config | Save dynamic backend config.
[**postRequestBuildSoftware**](CommonAdminApi.md#postrequestbuildsoftware) | **POST** /common_api/request_build_software | Request building new software from manager instance.
[**postRequestRestartOrResetBackend**](CommonAdminApi.md#postrequestrestartorresetbackend) | **POST** /common_api/request_restart_or_reset_backend | Request restarting or reseting backend through app-manager instance.
[**postRequestUpdateSoftware**](CommonAdminApi.md#postrequestupdatesoftware) | **POST** /common_api/request_update_software | Request updating new software from manager instance.


# **getLatestBuildInfo**
> BuildInfo getLatestBuildInfo(softwareOptions)

Get latest software build information available for update from manager

Get latest software build information available for update from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();
final softwareOptions = ; // SoftwareOptions | 

try {
    final result = api_instance.getLatestBuildInfo(softwareOptions);
    print(result);
} catch (e) {
    print('Exception when calling CommonAdminApi->getLatestBuildInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 

### Return type

[**BuildInfo**](BuildInfo.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSoftwareInfo**
> SoftwareInfo getSoftwareInfo()

Get software version information from manager instance.

Get software version information from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();

try {
    final result = api_instance.getSoftwareInfo();
    print(result);
} catch (e) {
    print('Exception when calling CommonAdminApi->getSoftwareInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SoftwareInfo**](SoftwareInfo.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSystemInfo**
> SystemInfoList getSystemInfo()

Get system information from manager instance.

Get system information from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();

try {
    final result = api_instance.getSystemInfo();
    print(result);
} catch (e) {
    print('Exception when calling CommonAdminApi->getSystemInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SystemInfoList**](SystemInfoList.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postBackendConfig**
> postBackendConfig(backendConfig)

Save dynamic backend config.

Save dynamic backend config.  # Capabilities Requires admin_server_maintentance_save_backend_settings.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();
final backendConfig = BackendConfig(); // BackendConfig | 

try {
    api_instance.postBackendConfig(backendConfig);
} catch (e) {
    print('Exception when calling CommonAdminApi->postBackendConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **backendConfig** | [**BackendConfig**](BackendConfig.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRequestBuildSoftware**
> postRequestBuildSoftware(softwareOptions)

Request building new software from manager instance.

Request building new software from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();
final softwareOptions = ; // SoftwareOptions | 

try {
    api_instance.postRequestBuildSoftware(softwareOptions);
} catch (e) {
    print('Exception when calling CommonAdminApi->postRequestBuildSoftware: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRequestRestartOrResetBackend**
> postRequestRestartOrResetBackend(resetData)

Request restarting or reseting backend through app-manager instance.

Request restarting or reseting backend through app-manager instance.  # Capabilities Requires admin_server_maintentance_restart_backend. Also requires admin_server_maintentance_reset_data if reset_data is true.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();
final resetData = true; // bool | 

try {
    api_instance.postRequestRestartOrResetBackend(resetData);
} catch (e) {
    print('Exception when calling CommonAdminApi->postRequestRestartOrResetBackend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetData** | **bool**|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRequestUpdateSoftware**
> postRequestUpdateSoftware(softwareOptions, reboot, resetData)

Request updating new software from manager instance.

Request updating new software from manager instance.  Reboot query parameter will force reboot of the server after update. If it is off, the server will be rebooted when the usual reboot check is done.  Reset data query parameter will reset data like defined in current app-manager version. If this is true then specific capability is needed for completing this request.  # Capablities Requires admin_server_maintentance_update_software. Also requires admin_server_maintentance_reset_data if reset_data is true.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonAdminApi();
final softwareOptions = ; // SoftwareOptions | 
final reboot = true; // bool | 
final resetData = true; // bool | 

try {
    api_instance.postRequestUpdateSoftware(softwareOptions, reboot, resetData);
} catch (e) {
    print('Exception when calling CommonAdminApi->postRequestUpdateSoftware: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 
 **reboot** | **bool**|  | 
 **resetData** | **bool**|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

