# openapi.api.AccountinternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkApiKey**](AccountinternalApi.md#checkapikey) | **GET** /internal/check_api_key | 
[**internalGetAccountState**](AccountinternalApi.md#internalgetaccountstate) | **GET** /internal/get_account_state/{account_id} | 


# **checkApiKey**
> AccountIdLight checkApiKey(apiKey)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountinternalApi();
final apiKey = ApiKey(); // ApiKey | 

try {
    final result = api_instance.checkApiKey(apiKey);
    print(result);
} catch (e) {
    print('Exception when calling AccountinternalApi->checkApiKey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **apiKey** | [**ApiKey**](ApiKey.md)|  | 

### Return type

[**AccountIdLight**](AccountIdLight.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **internalGetAccountState**
> Account internalGetAccountState(accountId)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountinternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.internalGetAccountState(accountId);
    print(result);
} catch (e) {
    print('Exception when calling AccountinternalApi->internalGetAccountState: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**Account**](Account.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

