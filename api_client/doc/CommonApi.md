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

Connect to server using WebSocket after getting refresh and access tokens. Connection is required as API access is allowed for connected clients.  Protocol: 1. Client sends version information as Binary message, where - u8: Client WebSocket protocol version (currently 0). - u8: Client type number. (0 = Android, 1 = iOS, 255 = Test mode bot) - u16: Client Major version. - u16: Client Minor version. - u16: Client Patch version.  The u16 values are in little endian byte order. 2. Client sends current refresh token as Binary message. 3. If server supports the client, the server sends next refresh token as Binary message. If server does not support the client, the server sends Text message and closes the connection. 4. Server sends new access token as Text message. (At this point API can be used.) 5. Client sends list of current data sync versions as Binary message, where items are [u8; 2] and the first u8 of an item is the data type number and the second u8 of an item is the sync version number for that data. If client does not have any version of the data, the client should send 255 as the version number.  Available data types: - 0: Account 6. Server starts to send JSON events as Text messages.  The new access token is valid until this WebSocket is closed. 

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

