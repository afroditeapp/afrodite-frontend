# openapi.api.MediaInternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**internalGetCheckModerationRequestForAccount**](MediaInternalApi.md#internalgetcheckmoderationrequestforaccount) | **GET** /internal/media_api/moderation/request/{account_id} | Check that media server has correct state for completing initial setup.


# **internalGetCheckModerationRequestForAccount**
> internalGetCheckModerationRequestForAccount(accountId)

Check that media server has correct state for completing initial setup.

Check that media server has correct state for completing initial setup. 

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = MediaInternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.internalGetCheckModerationRequestForAccount(accountId);
} catch (e) {
    print('Exception when calling MediaInternalApi->internalGetCheckModerationRequestForAccount: $e\n');
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

