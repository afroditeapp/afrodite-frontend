# openapi.api.CommonadminApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getLatestBuildInfo**](CommonadminApi.md#getlatestbuildinfo) | **GET** /common_api/get_latest_build_info | Get latest software build information available for update from manager
[**getSoftwareInfo**](CommonadminApi.md#getsoftwareinfo) | **GET** /common_api/software_info | Get software version information from manager instance.
[**getSystemInfo**](CommonadminApi.md#getsysteminfo) | **GET** /common_api/system_info | Get system information from manager instance.
[**postRequestBuildSoftware**](CommonadminApi.md#postrequestbuildsoftware) | **POST** /common_api/request_build_software | Request building new software from manager instance.
[**postRequestUpdateSoftware**](CommonadminApi.md#postrequestupdatesoftware) | **POST** /common_api/request_update_software | Request updating new software from manager instance.


# **getLatestBuildInfo**
> BuildInfo getLatestBuildInfo(softwareOptions)

Get latest software build information available for update from manager

Get latest software build information available for update from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CommonadminApi();
final softwareOptions = ; // SoftwareOptions | 

try {
    final result = api_instance.getLatestBuildInfo(softwareOptions);
    print(result);
} catch (e) {
    print('Exception when calling CommonadminApi->getLatestBuildInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 

### Return type

[**BuildInfo**](BuildInfo.md)

### Authorization

[api_key](../README.md#api_key)

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
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CommonadminApi();

try {
    final result = api_instance.getSoftwareInfo();
    print(result);
} catch (e) {
    print('Exception when calling CommonadminApi->getSoftwareInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SoftwareInfo**](SoftwareInfo.md)

### Authorization

[api_key](../README.md#api_key)

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
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CommonadminApi();

try {
    final result = api_instance.getSystemInfo();
    print(result);
} catch (e) {
    print('Exception when calling CommonadminApi->getSystemInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SystemInfoList**](SystemInfoList.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRequestBuildSoftware**
> postRequestBuildSoftware(softwareOptions)

Request building new software from manager instance.

Request building new software from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CommonadminApi();
final softwareOptions = ; // SoftwareOptions | 

try {
    api_instance.postRequestBuildSoftware(softwareOptions);
} catch (e) {
    print('Exception when calling CommonadminApi->postRequestBuildSoftware: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRequestUpdateSoftware**
> postRequestUpdateSoftware(softwareOptions, reboot)

Request updating new software from manager instance.

Request updating new software from manager instance.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CommonadminApi();
final softwareOptions = ; // SoftwareOptions | 
final reboot = true; // bool | 

try {
    api_instance.postRequestUpdateSoftware(softwareOptions, reboot);
} catch (e) {
    print('Exception when calling CommonadminApi->postRequestUpdateSoftware: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **softwareOptions** | [**SoftwareOptions**](.md)|  | 
 **reboot** | **bool**|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

