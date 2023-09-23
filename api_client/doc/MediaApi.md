# openapi.api.MediaApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllNormalImages**](MediaApi.md#getallnormalimages) | **GET** /media_api/all_normal_images/{account_id} | Get list of all normal images on the server for one account.
[**getImage**](MediaApi.md#getimage) | **GET** /media_api/image/{account_id}/{content_id} | Get profile image
[**getMapTile**](MediaApi.md#getmaptile) | **GET** /media_api/map_tile/{z}/{x}/{y} | Get map tile PNG file.
[**getModerationRequest**](MediaApi.md#getmoderationrequest) | **GET** /media_api/moderation/request | Get current moderation request.
[**getPrimaryImageInfo**](MediaApi.md#getprimaryimageinfo) | **GET** /media_api/primary_image_info/{account_id} | Get current public image for selected profile
[**putImageToModerationSlot**](MediaApi.md#putimagetomoderationslot) | **PUT** /media_api/moderation/request/slot/{slot_id} | Set image to moderation request slot.
[**putModerationRequest**](MediaApi.md#putmoderationrequest) | **PUT** /media_api/moderation/request | Create new or override old moderation request.
[**putPrimaryImage**](MediaApi.md#putprimaryimage) | **PUT** /media_api/primary_image | Set primary image for account. Image content ID can not be empty.


# **getAllNormalImages**
> NormalImages getAllNormalImages(accountId)

Get list of all normal images on the server for one account.

Get list of all normal images on the server for one account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getAllNormalImages(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getAllNormalImages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**NormalImages**](NormalImages.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getImage**
> MultipartFile getImage(accountId, contentId, isMatch)

Get profile image

Get profile image

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final contentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final isMatch = true; // bool | If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.

try {
    final result = api_instance.getImage(accountId, contentId, isMatch);
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
 **isMatch** | **bool**| If false image access is allowed when profile is set as public. If true image access is allowed when users are a match. | 

### Return type

[**MultipartFile**](MultipartFile.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/jpeg

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMapTile**
> MultipartFile getMapTile(z, x, y)

Get map tile PNG file.

Get map tile PNG file.  Returns a .png even if the URL does not have it.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final z = 56; // int | 
final x = 56; // int | 
final y = y_example; // String | 

try {
    final result = api_instance.getMapTile(z, x, y);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getMapTile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **z** | **int**|  | 
 **x** | **int**|  | 
 **y** | **String**|  | 

### Return type

[**MultipartFile**](MultipartFile.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/png

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getModerationRequest**
> ModerationRequest getModerationRequest()

Get current moderation request.

Get current moderation request. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

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

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPrimaryImageInfo**
> PrimaryImage getPrimaryImageInfo(accountId, isMatch)

Get current public image for selected profile

Get current public image for selected profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final isMatch = true; // bool | If false image access is allowed when profile is set as public. If true image access is allowed when users are a match.

try {
    final result = api_instance.getPrimaryImageInfo(accountId, isMatch);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getPrimaryImageInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **isMatch** | **bool**| If false image access is allowed when profile is set as public. If true image access is allowed when users are a match. | 

### Return type

[**PrimaryImage**](PrimaryImage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putImageToModerationSlot**
> ContentId putImageToModerationSlot(slotId, body)

Set image to moderation request slot.

Set image to moderation request slot.  Slots from 0 to 2 are available.  TODO: resize and check images at some point 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

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

[access_token](../README.md#access_token)

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
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

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

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putPrimaryImage**
> putPrimaryImage(primaryImage)

Set primary image for account. Image content ID can not be empty.

Set primary image for account. Image content ID can not be empty.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final primaryImage = PrimaryImage(); // PrimaryImage | 

try {
    api_instance.putPrimaryImage(primaryImage);
} catch (e) {
    print('Exception when calling MediaApi->putPrimaryImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **primaryImage** | [**PrimaryImage**](PrimaryImage.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

