# openapi.api.CommonApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getConnectWebsocket**](CommonApi.md#getconnectwebsocket) | **GET** /common_api/connect | Connect to server using WebSocket after getting refresh and access tokens.
[**getVersion**](CommonApi.md#getversion) | **GET** /common_api/version | Get backend version.


# **getConnectWebsocket**
> getConnectWebsocket()

Connect to server using WebSocket after getting refresh and access tokens.

Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.  Send the current refersh token as Binary. The server will send the next refresh token (Binary) and after that the new access token (Text). After that API can be used.  The access token is valid until this WebSocket is closed. Server might send events as Text which is JSON. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = CommonApi();

try {
    api_instance.getConnectWebsocket();
} catch (e) {
    print('Exception when calling CommonApi->getConnectWebsocket: $e\n');
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

# **getVersion**
> BackendVersion getVersion()

Get backend version.

Get backend version.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = CommonApi();

try {
    final result = api_instance.getVersion();
    print(result);
} catch (e) {
    print('Exception when calling CommonApi->getVersion: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BackendVersion**](BackendVersion.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

