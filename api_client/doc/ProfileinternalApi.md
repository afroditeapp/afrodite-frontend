# openapi.api.ProfileinternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**internalPostUpdateProfileVisibility**](ProfileinternalApi.md#internalpostupdateprofilevisibility) | **POST** /internal/profile_api/visiblity/{account_id}/{value} | 


# **internalPostUpdateProfileVisibility**
> internalPostUpdateProfileVisibility(accountId, value)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = ProfileinternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final value = true; // bool | 

try {
    api_instance.internalPostUpdateProfileVisibility(accountId, value);
} catch (e) {
    print('Exception when calling ProfileinternalApi->internalPostUpdateProfileVisibility: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **value** | **bool**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

