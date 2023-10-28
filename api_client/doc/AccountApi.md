# openapi.api.AccountApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteCancelDeletion**](AccountApi.md#deletecanceldeletion) | **DELETE** /account_api/delete | Cancel account deletion.
[**getAccountData**](AccountApi.md#getaccountdata) | **GET** /account_api/account_data | Get changeable user information to account.
[**getAccountSetup**](AccountApi.md#getaccountsetup) | **GET** /account_api/account_setup | Get non-changeable user information to account.
[**getAccountState**](AccountApi.md#getaccountstate) | **GET** /account_api/state | Get current account state.
[**getDeletionStatus**](AccountApi.md#getdeletionstatus) | **GET** /account_api/delete | Get deletion status.
[**postAccountData**](AccountApi.md#postaccountdata) | **POST** /account_api/account_data | Set changeable user information to account.
[**postAccountSetup**](AccountApi.md#postaccountsetup) | **POST** /account_api/account_setup | Setup non-changeable user information during `initial setup` state.
[**postCompleteSetup**](AccountApi.md#postcompletesetup) | **POST** /account_api/complete_setup | Complete initial setup.
[**postDelete**](AccountApi.md#postdelete) | **PUT** /account_api/delete | Delete account.
[**postLogin**](AccountApi.md#postlogin) | **POST** /account_api/login | Get new AccessToken.
[**postRegister**](AccountApi.md#postregister) | **POST** /account_api/register | Register new account. Returns new account ID which is UUID.
[**postSignInWithLogin**](AccountApi.md#postsigninwithlogin) | **POST** /account_api/sign_in_with_login | Start new session with sign in with Apple or Google. Creates new account if
[**putSettingProfileVisiblity**](AccountApi.md#putsettingprofilevisiblity) | **PUT** /account_api/settings/profile_visibility | Update profile visiblity value.


# **deleteCancelDeletion**
> deleteCancelDeletion()

Cancel account deletion.

Cancel account deletion.  Account state will move to previous state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    api_instance.deleteCancelDeletion();
} catch (e) {
    print('Exception when calling AccountApi->deleteCancelDeletion: $e\n');
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

# **getAccountData**
> AccountData getAccountData()

Get changeable user information to account.

Get changeable user information to account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    final result = api_instance.getAccountData();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->getAccountData: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountData**](AccountData.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAccountSetup**
> AccountSetup getAccountSetup()

Get non-changeable user information to account.

Get non-changeable user information to account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    final result = api_instance.getAccountSetup();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->getAccountSetup: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountSetup**](AccountSetup.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAccountState**
> Account getAccountState()

Get current account state.

Get current account state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    final result = api_instance.getAccountState();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->getAccountState: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Account**](Account.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDeletionStatus**
> DeleteStatus getDeletionStatus()

Get deletion status.

Get deletion status.  Get information when account will be really deleted.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    final result = api_instance.getDeletionStatus();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->getDeletionStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DeleteStatus**](DeleteStatus.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postAccountData**
> postAccountData(accountData)

Set changeable user information to account.

Set changeable user information to account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();
final accountData = AccountData(); // AccountData | 

try {
    api_instance.postAccountData(accountData);
} catch (e) {
    print('Exception when calling AccountApi->postAccountData: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountData** | [**AccountData**](AccountData.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postAccountSetup**
> postAccountSetup(accountSetup)

Setup non-changeable user information during `initial setup` state.

Setup non-changeable user information during `initial setup` state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();
final accountSetup = AccountSetup(); // AccountSetup | 

try {
    api_instance.postAccountSetup(accountSetup);
} catch (e) {
    print('Exception when calling AccountApi->postAccountSetup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountSetup** | [**AccountSetup**](AccountSetup.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postCompleteSetup**
> postCompleteSetup()

Complete initial setup.

Complete initial setup.  Request to this handler will complete if client is in `initial setup`, setup information is set and image moderation request has been made. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    api_instance.postCompleteSetup();
} catch (e) {
    print('Exception when calling AccountApi->postCompleteSetup: $e\n');
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

# **postDelete**
> postDelete()

Delete account.

Delete account.  Changes account state to `pending deletion` from all possible states. Previous state will be saved, so it will be possible to stop automatic deletion process.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    api_instance.postDelete();
} catch (e) {
    print('Exception when calling AccountApi->postDelete: $e\n');
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

# **postLogin**
> LoginResult postLogin(accountId)

Get new AccessToken.

Get new AccessToken.  Available only if server is running in debug mode and bot_login is enabled from config file.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();
final accountId = AccountId(); // AccountId | 

try {
    final result = api_instance.postLogin(accountId);
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | [**AccountId**](AccountId.md)|  | 

### Return type

[**LoginResult**](LoginResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRegister**
> AccountId postRegister()

Register new account. Returns new account ID which is UUID.

Register new account. Returns new account ID which is UUID.  Available only if server is running in debug mode and bot_login is enabled from config file.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();

try {
    final result = api_instance.postRegister();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postRegister: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountId**](AccountId.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postSignInWithLogin**
> LoginResult postSignInWithLogin(signInWithLoginInfo)

Start new session with sign in with Apple or Google. Creates new account if

Start new session with sign in with Apple or Google. Creates new account if it does not exists.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();
final signInWithLoginInfo = SignInWithLoginInfo(); // SignInWithLoginInfo | 

try {
    final result = api_instance.postSignInWithLogin(signInWithLoginInfo);
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postSignInWithLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signInWithLoginInfo** | [**SignInWithLoginInfo**](SignInWithLoginInfo.md)|  | 

### Return type

[**LoginResult**](LoginResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putSettingProfileVisiblity**
> putSettingProfileVisiblity(booleanSetting)

Update profile visiblity value.

Update profile visiblity value.  This will check that the first image moderation request has been moderated before this turns the profile public.  Sets capablity `view_public_profiles` on or off depending on the value.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();
final booleanSetting = BooleanSetting(); // BooleanSetting | 

try {
    api_instance.putSettingProfileVisiblity(booleanSetting);
} catch (e) {
    print('Exception when calling AccountApi->putSettingProfileVisiblity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **booleanSetting** | [**BooleanSetting**](BooleanSetting.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

