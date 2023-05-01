# openapi.api.MediainternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**internalGetCheckModerationRequestForAccount**](MediainternalApi.md#internalgetcheckmoderationrequestforaccount) | **GET** /internal/media_api/moderation/request/{account_id} | Check that current moderation request for account exists. Requires also
[**internalPostUpdateProfileImageVisibility**](MediainternalApi.md#internalpostupdateprofileimagevisibility) | **POST** /internal/media_api/visiblity/{account_id}/{value} | 


# **internalGetCheckModerationRequestForAccount**
> internalGetCheckModerationRequestForAccount(accountId)

Check that current moderation request for account exists. Requires also

Check that current moderation request for account exists. Requires also that request contains camera image. 

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = MediainternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.internalGetCheckModerationRequestForAccount(accountId);
} catch (e) {
    print('Exception when calling MediainternalApi->internalGetCheckModerationRequestForAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **internalPostUpdateProfileImageVisibility**
> internalPostUpdateProfileImageVisibility(accountId, value, profile)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = MediainternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final value = true; // bool | 
final profile = Profile(); // Profile | 

try {
    api_instance.internalPostUpdateProfileImageVisibility(accountId, value, profile);
} catch (e) {
    print('Exception when calling MediainternalApi->internalPostUpdateProfileImageVisibility: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **value** | **bool**|  | 
 **profile** | [**Profile**](Profile.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

