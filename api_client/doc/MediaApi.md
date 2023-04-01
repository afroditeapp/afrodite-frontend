# openapi.api.MediaApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getImage**](MediaApi.md#getimage) | **GET** /media_api/image/{account_id}/{image_file} | Get profile image
[**getModerationRequest**](MediaApi.md#getmoderationrequest) | **GET** /media_api/moderation/request | Get current moderation request.
[**getModerationRequestList**](MediaApi.md#getmoderationrequestlist) | **GET** /media_api/admin/moderation/page/next | Get list of next moderation requests in moderation queue.
[**postHandleModerationRequest**](MediaApi.md#posthandlemoderationrequest) | **POST** /media_api/admin/moderation/handle_request/{request_id} | Handle moderation request.
[**putImageToModerationSlot**](MediaApi.md#putimagetomoderationslot) | **PUT** /media_api/moderation/request/slot/{slot_id} | Set image to moderation request slot.
[**putModerationRequest**](MediaApi.md#putmoderationrequest) | **PUT** /media_api/moderation/request | Create new or override old moderation request.


# **getImage**
> getImage(accountId, imageFile)

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
final imageFile = imageFile_example; // String | 

try {
    api_instance.getImage(accountId, imageFile);
} catch (e) {
    print('Exception when calling MediaApi->getImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **imageFile** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

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

# **getModerationRequestList**
> ModerationRequestList getModerationRequestList()

Get list of next moderation requests in moderation queue.

Get list of next moderation requests in moderation queue.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();

try {
    final result = api_instance.getModerationRequestList();
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getModerationRequestList: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ModerationRequestList**](ModerationRequestList.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postHandleModerationRequest**
> postHandleModerationRequest(requestId, handleModerationRequest)

Handle moderation request.

Handle moderation request.  ## Access  Account with `admin_moderate_images` capability is required to access this route. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final requestId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final handleModerationRequest = HandleModerationRequest(); // HandleModerationRequest | 

try {
    api_instance.postHandleModerationRequest(requestId, handleModerationRequest);
} catch (e) {
    print('Exception when calling MediaApi->postHandleModerationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestId** | **String**|  | 
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
> putImageToModerationSlot(slotId, body)

Set image to moderation request slot.

Set image to moderation request slot.  Slots \"camera\" and \"image1\" are available. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final slotId = slotId_example; // String | 
final body = String(); // String | 

try {
    api_instance.putImageToModerationSlot(slotId, body);
} catch (e) {
    print('Exception when calling MediaApi->putImageToModerationSlot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slotId** | **String**|  | 
 **body** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: image/jpeg
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putModerationRequest**
> putModerationRequest(newModerationRequest)

Create new or override old moderation request.

Create new or override old moderation request.  Set images to moderation request slots first. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final newModerationRequest = NewModerationRequest(); // NewModerationRequest | 

try {
    api_instance.putModerationRequest(newModerationRequest);
} catch (e) {
    print('Exception when calling MediaApi->putModerationRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **newModerationRequest** | [**NewModerationRequest**](NewModerationRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

