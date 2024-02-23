# openapi.api.MediaApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteContent**](MediaApi.md#deletecontent) | **DELETE** /media_api/content/{account_id}/{content_id} | Delete content data. Content can be removed after specific time has passed
[**deletePendingSecurityContentInfo**](MediaApi.md#deletependingsecuritycontentinfo) | **DELETE** /media_api/pending_security_content_info | Delete pending security content for current account.
[**getAllAccountMediaContent**](MediaApi.md#getallaccountmediacontent) | **GET** /media_api/all_account_media_content/{account_id} | Get list of all media content on the server for one account.
[**getContent**](MediaApi.md#getcontent) | **GET** /media_api/content/{account_id}/{content_id} | Get content data
[**getContentSlotState**](MediaApi.md#getcontentslotstate) | **GET** /media_api/content_slot/{slot_id} | Get state of content slot.
[**getMapTile**](MediaApi.md#getmaptile) | **GET** /media_api/map_tile/{z}/{x}/{y} | Get map tile PNG file.
[**getModerationRequest**](MediaApi.md#getmoderationrequest) | **GET** /media_api/moderation/request | Get current moderation request.
[**getPendingProfileContentInfo**](MediaApi.md#getpendingprofilecontentinfo) | **GET** /media_api/pending_profile_content_info/{account_id} | Get pending profile content for selected profile
[**getPendingSecurityContentInfo**](MediaApi.md#getpendingsecuritycontentinfo) | **GET** /media_api/pending_security_content_info/{account_id} | Get pending security content for selected profile.
[**getProfileContentInfo**](MediaApi.md#getprofilecontentinfo) | **GET** /media_api/profile_content_info/{account_id} | Get current profile content for selected profile
[**getSecurityContentInfo**](MediaApi.md#getsecuritycontentinfo) | **GET** /media_api/security_content_info/{account_id} | Get current security content for selected profile.
[**putContentToContentSlot**](MediaApi.md#putcontenttocontentslot) | **PUT** /media_api/content_slot/{slot_id} | Set content to content processing slot.
[**putModerationRequest**](MediaApi.md#putmoderationrequest) | **PUT** /media_api/moderation/request | Create new or override old moderation request.
[**putPendingProfileContent**](MediaApi.md#putpendingprofilecontent) | **PUT** /media_api/pending_profile_content | Set new pending profile content for current account.
[**putPendingSecurityContentInfo**](MediaApi.md#putpendingsecuritycontentinfo) | **PUT** /media_api/pending_security_content_info | Set pending security content for current account.
[**putProfileContent**](MediaApi.md#putprofilecontent) | **PUT** /media_api/profile_content | Set new profile content for current account.
[**putSecurityContentInfo**](MediaApi.md#putsecuritycontentinfo) | **PUT** /media_api/security_content_info | Set current security content content for current account.


# **deleteContent**
> deleteContent(accountId, contentId)

Delete content data. Content can be removed after specific time has passed

Delete content data. Content can be removed after specific time has passed since removing all usage from it (content is not a security image or profile content).

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

try {
    api_instance.deleteContent(accountId, contentId);
} catch (e) {
    print('Exception when calling MediaApi->deleteContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **contentId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePendingSecurityContentInfo**
> deletePendingSecurityContentInfo()

Delete pending security content for current account.

Delete pending security content for current account. Server will not change the security content when next moderation request is moderated as accepted.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();

try {
    api_instance.deletePendingSecurityContentInfo();
} catch (e) {
    print('Exception when calling MediaApi->deletePendingSecurityContentInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllAccountMediaContent**
> AccountContent getAllAccountMediaContent(accountId)

Get list of all media content on the server for one account.

Get list of all media content on the server for one account.

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
    final result = api_instance.getAllAccountMediaContent(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getAllAccountMediaContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**AccountContent**](AccountContent.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContent**
> MultipartFile getContent(accountId, contentId, isMatch)

Get content data

Get content data

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
final isMatch = true; // bool | If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.

try {
    final result = api_instance.getContent(accountId, contentId, isMatch);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **contentId** | **String**|  | 
 **isMatch** | **bool**| If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match. | 

### Return type

[**MultipartFile**](MultipartFile.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContentSlotState**
> ContentProcessingState getContentSlotState(slotId)

Get state of content slot.

Get state of content slot.  Slots from 0 to 6 are available. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final slotId = 56; // int | 

try {
    final result = api_instance.getContentSlotState(slotId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getContentSlotState: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slotId** | **int**|  | 

### Return type

[**ContentProcessingState**](ContentProcessingState.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

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

# **getPendingProfileContentInfo**
> PendingProfileContent getPendingProfileContentInfo(accountId)

Get pending profile content for selected profile

Get pending profile content for selected profile

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
    final result = api_instance.getPendingProfileContentInfo(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getPendingProfileContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**PendingProfileContent**](PendingProfileContent.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingSecurityContentInfo**
> PendingSecurityContent getPendingSecurityContentInfo(accountId)

Get pending security content for selected profile.

Get pending security content for selected profile.

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
    final result = api_instance.getPendingSecurityContentInfo(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getPendingSecurityContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**PendingSecurityContent**](PendingSecurityContent.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfileContentInfo**
> ProfileContent getProfileContentInfo(accountId, isMatch)

Get current profile content for selected profile

Get current profile content for selected profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final isMatch = true; // bool | If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match.

try {
    final result = api_instance.getProfileContentInfo(accountId, isMatch);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getProfileContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **isMatch** | **bool**| If false media content access is allowed when profile is set as public. If true media content access is allowed when users are a match. | 

### Return type

[**ProfileContent**](ProfileContent.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSecurityContentInfo**
> SecurityContent getSecurityContentInfo(accountId)

Get current security content for selected profile.

Get current security content for selected profile.

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
    final result = api_instance.getSecurityContentInfo(accountId);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->getSecurityContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**SecurityContent**](SecurityContent.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putContentToContentSlot**
> ContentProcessingId putContentToContentSlot(slotId, secureCapture, contentType, body)

Set content to content processing slot.

Set content to content processing slot. Processing ID will be returned and processing of the content will begin. Events about the content processing will be sent to the client.  The state of the processing can be also queired. The querying is required to receive the content ID.  Slots from 0 to 6 are available.  One account can only have one content in upload or processing state. New upload might potentially delete the previous if processing of it is not complete. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final slotId = 56; // int | 
final secureCapture = true; // bool | Client captured this content.
final contentType = ; // MediaContentType | 
final body = MultipartFile(); // MultipartFile | 

try {
    final result = api_instance.putContentToContentSlot(slotId, secureCapture, contentType, body);
    print(result);
} catch (e) {
    print('Exception when calling MediaApi->putContentToContentSlot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slotId** | **int**|  | 
 **secureCapture** | **bool**| Client captured this content. | 
 **contentType** | [**MediaContentType**](.md)|  | 
 **body** | **MultipartFile**|  | 

### Return type

[**ContentProcessingId**](ContentProcessingId.md)

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

# **putPendingProfileContent**
> putPendingProfileContent(setProfileContent)

Set new pending profile content for current account.

Set new pending profile content for current account. Server will switch to pending content when next moderation request is accepted.  # Restrictions - All content must not be moderated as denied. - All content must be owned by the account. - All content must be images.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final setProfileContent = SetProfileContent(); // SetProfileContent | 

try {
    api_instance.putPendingProfileContent(setProfileContent);
} catch (e) {
    print('Exception when calling MediaApi->putPendingProfileContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setProfileContent** | [**SetProfileContent**](SetProfileContent.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putPendingSecurityContentInfo**
> putPendingSecurityContentInfo(contentId)

Set pending security content for current account.

Set pending security content for current account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final contentId = ContentId(); // ContentId | 

try {
    api_instance.putPendingSecurityContentInfo(contentId);
} catch (e) {
    print('Exception when calling MediaApi->putPendingSecurityContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contentId** | [**ContentId**](ContentId.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putProfileContent**
> putProfileContent(setProfileContent)

Set new profile content for current account.

Set new profile content for current account.  # Restrictions - All content must be moderated as accepted. - All content must be owned by the account. - All content must be images.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final setProfileContent = SetProfileContent(); // SetProfileContent | 

try {
    api_instance.putProfileContent(setProfileContent);
} catch (e) {
    print('Exception when calling MediaApi->putProfileContent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setProfileContent** | [**SetProfileContent**](SetProfileContent.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putSecurityContentInfo**
> putSecurityContentInfo(contentId)

Set current security content content for current account.

Set current security content content for current account.  # Restrictions - The content must be moderated as accepted. - The content must be owned by the account. - The content must be an image. - The content must be captured by client.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = MediaApi();
final contentId = ContentId(); // ContentId | 

try {
    api_instance.putSecurityContentInfo(contentId);
} catch (e) {
    print('Exception when calling MediaApi->putSecurityContentInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contentId** | [**ContentId**](ContentId.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

