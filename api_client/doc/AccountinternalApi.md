# openapi.api.AccountInternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkAccessToken**](AccountInternalApi.md#checkaccesstoken) | **GET** /internal/check_access_token | 
[**internalGetAccountState**](AccountInternalApi.md#internalgetaccountstate) | **GET** /internal/get_account_state/{account_id} | 


# **checkAccessToken**
> AccountId checkAccessToken(accessToken)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountInternalApi();
final accessToken = AccessToken(); // AccessToken | 

try {
    final result = api_instance.checkAccessToken(accessToken);
    print(result);
} catch (e) {
    print('Exception when calling AccountInternalApi->checkAccessToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accessToken** | [**AccessToken**](AccessToken.md)|  | 

### Return type

[**AccountId**](AccountId.md)

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

final api_instance = AccountInternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.internalGetAccountState(accountId);
    print(result);
} catch (e) {
    print('Exception when calling AccountInternalApi->internalGetAccountState: $e\n');
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

