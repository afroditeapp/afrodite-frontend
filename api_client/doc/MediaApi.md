# openapi.api.MediaApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getImage**](MediaApi.md#getimage) | **GET** /media_api/image/{account_id}/{content_id} | Get profile image
[**getModerationRequest**](MediaApi.md#getmoderationrequest) | **GET** /media_api/moderation/request | Get current moderation request.
[**patchModerationRequestList**](MediaApi.md#patchmoderationrequestlist) | **PATCH** /media_api/admin/moderation/page/next | Get current list of moderation requests in my moderation queue.
[**postHandleModerationRequest**](MediaApi.md#posthandlemoderationrequest) | **POST** /media_api/admin/moderation/handle_request/{account_id} | Handle moderation request of some account.
[**putImageToModerationSlot**](MediaApi.md#putimagetomoderationslot) | **PUT** /media_api/moderation/request/slot/{slot_id} | Set image to moderation request slot.
[**putModerationRequest**](MediaApi.md#putmoderationrequest) | **PUT** /media_api/moderation/request | Create new or override old moderation request.


# **getImage**
> MultipartFile getImage(accountId, contentId)

Get profile image

Get profile image

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final contentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getImage(accountId, contentId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **contentId** | **String**|  | 

### Return type

[**MultipartFile**](MultipartFile.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/jpeg

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getModerationRequest**
> ModerationRequest getModerationRequest()

Get current moderation request.

Get current moderation request. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();

try {
    final result = api_instance.getModerationRequest();
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getModerationRequest: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ModerationRequest**](ModerationRequest.md)

### Authorization

[api_key](../README.md#api_key)

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
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();

try {
    final result = api_instance.patchModerationRequestList();
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->patchModerationRequestList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ModerationList**](ModerationList.md)

### Authorization

[api_key](../README.md#api_key)

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
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final handleModerationRequest = HandleModerationRequest(); // HandleModerationRequest | 

try {
    api_instance.postHandleModerationRequest(accountId, handleModerationRequest);
} catch (e) {
    print('Exception when calling MediaApi->postHandleModerationRequest: $e\n');
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

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putImageToModerationSlot**
> ContentId putImageToModerationSlot(slotId, body)

Set image to moderation request slot.

Set image to moderation request slot.  Slots from 0 to 2 are available.  TODO: resize and check images at some point 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final slotId = 56; // int | 
final body = MultipartFile(); // MultipartFile | 

try {
    final result = api_instance.putImageToModerationSlot(slotId, body);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->putImageToModerationSlot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slotId** | **int**|  | 
 **body** | **MultipartFile**|  | 

### Return type

[**ContentId**](ContentId.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: image/jpeg
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putModerationRequest**
> putModerationRequest(moderationRequestContent)

Create new or override old moderation request.

Create new or override old moderation request.  Make sure that moderation request has content IDs which points to your own image slots. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final moderationRequestContent = ModerationRequestContent(); // ModerationRequestContent | 

try {
    api_instance.putModerationRequest(moderationRequestContent);
} catch (e) {
    print('Exception when calling MediaApi->putModerationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **moderationRequestContent** | [**ModerationRequestContent**](ModerationRequestContent.md)|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

