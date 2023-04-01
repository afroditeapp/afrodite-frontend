# openapi.api.AccountinternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkApiKey**](AccountinternalApi.md#checkapikey) | **GET** /internal/check_api_key | 


# **checkApiKey**
> AccountId checkApiKey()



### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = AccountinternalApi();

try {
    final result = api_instance.checkApiKey();
    print(result);
} catch (e) {
    print('Exception when calling AccountinternalApi->checkApiKey: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountId**](AccountId.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

