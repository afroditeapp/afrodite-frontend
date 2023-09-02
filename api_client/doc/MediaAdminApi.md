# openapi.api.MediaAdminApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getSecurityImageInfo**](MediaAdminApi.md#getsecurityimageinfo) | **GET** /media_api/security_image_info/{account_id} | Get current security image for selected profile. Only for admins.
[**patchModerationRequestList**](MediaAdminApi.md#patchmoderationrequestlist) | **PATCH** /media_api/admin/moderation/page/next | Get current list of moderation requests in my moderation queue.
[**postHandleModerationRequest**](MediaAdminApi.md#posthandlemoderationrequest) | **POST** /media_api/admin/moderation/handle_request/{account_id} | Handle moderation request of some account.


# **getSecurityImageInfo**
> SecurityImage getSecurityImageInfo(accountId)

Get current security image for selected profile. Only for admins.

Get current security image for selected profile. Only for admins.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaAdminApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getSecurityImageInfo(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaAdminApi->getSecurityImageInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**SecurityImage**](SecurityImage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **patchModerationRequestList**
> ModerationList patchModerationRequestList()

Get current list of moderation requests in my moderation queue.

Get current list of moderation requests in my moderation queue. Additional requests will be added to my queue if necessary.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaAdminApi();

try {
    final result = api_instance.patchModerationRequestList();
    print(result);
} catch (e) {
    print('Exception when calling MediaAdminApi->patchModerationRequestList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ModerationList**](ModerationList.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postHandleModerationRequest**
> postHandleModerationRequest(accountId, handleModerationRequest)

Handle moderation request of some account.

Handle moderation request of some account.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaAdminApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final handleModerationRequest = HandleModerationRequest(); // HandleModerationRequest | 

try {
    api_instance.postHandleModerationRequest(accountId, handleModerationRequest);
} catch (e) {
    print('Exception when calling MediaAdminApi->postHandleModerationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **handleModerationRequest** | [**HandleModerationRequest**](HandleModerationRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

