# openapi.api.ProfileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteFavoriteProfile**](ProfileApi.md#deletefavoriteprofile) | **DELETE** /profile_api/favorite_profile | Delete favorite profile
[**getAvailableProfileAttributes**](ProfileApi.md#getavailableprofileattributes) | **GET** /profile_api/available_profile_attributes | Get info what profile attributes server supports.
[**getFavoriteProfiles**](ProfileApi.md#getfavoriteprofiles) | **GET** /profile_api/favorite_profiles | Get list of all favorite profiles.
[**getLocation**](ProfileApi.md#getlocation) | **GET** /profile_api/location | Get location for account which makes this request.
[**getProfile**](ProfileApi.md#getprofile) | **GET** /profile_api/profile/{account_id} | Get account's current profile.
[**getProfileAttributeFilters**](ProfileApi.md#getprofileattributefilters) | **GET** /profile_api/profile_attribute_filters | Get current profile attribute filter values.
[**getProfileFromDatabaseDebugModeBenchmark**](ProfileApi.md#getprofilefromdatabasedebugmodebenchmark) | **GET** /profile_api/benchmark/profile/{account_id} | Get account's current profile from database. Debug mode must be enabled
[**getSearchAgeRange**](ProfileApi.md#getsearchagerange) | **GET** /profile_api/search_age_range | Get account's current search age range
[**getSearchGroups**](ProfileApi.md#getsearchgroups) | **GET** /profile_api/search_groups | Get account's current search groups
[**postFavoriteProfile**](ProfileApi.md#postfavoriteprofile) | **POST** /profile_api/favorite_profile | Add new favorite profile
[**postGetNextProfilePage**](ProfileApi.md#postgetnextprofilepage) | **POST** /profile_api/page/next | Post (updates iterator) to get next page of profile list.
[**postProfile**](ProfileApi.md#postprofile) | **POST** /profile_api/profile | Update profile information.
[**postProfileAttributeFilters**](ProfileApi.md#postprofileattributefilters) | **POST** /profile_api/profile_attribute_filters | Set profile attribute filter values.
[**postProfileToDatabaseDebugModeBenchmark**](ProfileApi.md#postprofiletodatabasedebugmodebenchmark) | **POST** /profile_api/benchmark/profile | Post account's current profile directly to database. Debug mode must be enabled
[**postResetProfilePaging**](ProfileApi.md#postresetprofilepaging) | **POST** /profile_api/page/reset | Reset profile paging.
[**postSearchAgeRange**](ProfileApi.md#postsearchagerange) | **POST** /profile_api/search_age_range | Set account's current search age range
[**postSearchGroups**](ProfileApi.md#postsearchgroups) | **POST** /profile_api/search_groups | Set account's current search groups
[**putLocation**](ProfileApi.md#putlocation) | **PUT** /profile_api/location | Update location for account which makes this request.


# **deleteFavoriteProfile**
> deleteFavoriteProfile(accountId)

Delete favorite profile

Delete favorite profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.deleteFavoriteProfile(accountId);
} catch (e) {
    print('Exception when calling ProfileApi->deleteFavoriteProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | [**AccountId**](AccountId.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAvailableProfileAttributes**
> AvailableProfileAttributes getAvailableProfileAttributes()

Get info what profile attributes server supports.

Get info what profile attributes server supports.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getAvailableProfileAttributes();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getAvailableProfileAttributes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AvailableProfileAttributes**](AvailableProfileAttributes.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFavoriteProfiles**
> FavoriteProfilesPage getFavoriteProfiles()

Get list of all favorite profiles.

Get list of all favorite profiles.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getFavoriteProfiles();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getFavoriteProfiles: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**FavoriteProfilesPage**](FavoriteProfilesPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLocation**
> Location getLocation()

Get location for account which makes this request.

Get location for account which makes this request.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getLocation();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getLocation: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Location**](Location.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfile**
> Profile getProfile(accountId)

Get account's current profile.

Get account's current profile.  Profile can include version UUID which can be used for caching.  # Access Public profile access requires `view_public_profiles` capability. Public and private profile access requires `admin_view_all_profiles` capablility.  # Microservice notes If account feature is set as external service then cached capability information from account service is used for access checks.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getProfile(accountId);
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**Profile**](Profile.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfileAttributeFilters**
> ProfileAttributeFilterList getProfileAttributeFilters()

Get current profile attribute filter values.

Get current profile attribute filter values.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getProfileAttributeFilters();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getProfileAttributeFilters: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProfileAttributeFilterList**](ProfileAttributeFilterList.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfileFromDatabaseDebugModeBenchmark**
> Profile getProfileFromDatabaseDebugModeBenchmark(accountId)

Get account's current profile from database. Debug mode must be enabled

Get account's current profile from database. Debug mode must be enabled that route can be used.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getProfileFromDatabaseDebugModeBenchmark(accountId);
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getProfileFromDatabaseDebugModeBenchmark: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

[**Profile**](Profile.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSearchAgeRange**
> ProfileSearchAgeRange getSearchAgeRange()

Get account's current search age range

Get account's current search age range

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getSearchAgeRange();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getSearchAgeRange: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProfileSearchAgeRange**](ProfileSearchAgeRange.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSearchGroups**
> SearchGroups getSearchGroups()

Get account's current search groups

Get account's current search groups (gender and what gender user is looking for)

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.getSearchGroups();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->getSearchGroups: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SearchGroups**](SearchGroups.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postFavoriteProfile**
> postFavoriteProfile(accountId)

Add new favorite profile

Add new favorite profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.postFavoriteProfile(accountId);
} catch (e) {
    print('Exception when calling ProfileApi->postFavoriteProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | [**AccountId**](AccountId.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postGetNextProfilePage**
> ProfilePage postGetNextProfilePage()

Post (updates iterator) to get next page of profile list.

Post (updates iterator) to get next page of profile list.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    final result = api_instance.postGetNextProfilePage();
    print(result);
} catch (e) {
    print('Exception when calling ProfileApi->postGetNextProfilePage: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProfilePage**](ProfilePage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postProfile**
> postProfile(profileUpdate)

Update profile information.

Update profile information.  Writes the profile to the database only if it is changed.  TODO: string lenght validation, limit saving new profiles TODO: return the new proifle. Edit: is this really needed?

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final profileUpdate = ProfileUpdate(); // ProfileUpdate | 

try {
    api_instance.postProfile(profileUpdate);
} catch (e) {
    print('Exception when calling ProfileApi->postProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profileUpdate** | [**ProfileUpdate**](ProfileUpdate.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postProfileAttributeFilters**
> postProfileAttributeFilters(profileAttributeFilterListUpdate)

Set profile attribute filter values.

Set profile attribute filter values.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final profileAttributeFilterListUpdate = ProfileAttributeFilterListUpdate(); // ProfileAttributeFilterListUpdate | 

try {
    api_instance.postProfileAttributeFilters(profileAttributeFilterListUpdate);
} catch (e) {
    print('Exception when calling ProfileApi->postProfileAttributeFilters: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profileAttributeFilterListUpdate** | [**ProfileAttributeFilterListUpdate**](ProfileAttributeFilterListUpdate.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postProfileToDatabaseDebugModeBenchmark**
> postProfileToDatabaseDebugModeBenchmark(profileUpdate)

Post account's current profile directly to database. Debug mode must be enabled

Post account's current profile directly to database. Debug mode must be enabled that route can be used.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final profileUpdate = ProfileUpdate(); // ProfileUpdate | 

try {
    api_instance.postProfileToDatabaseDebugModeBenchmark(profileUpdate);
} catch (e) {
    print('Exception when calling ProfileApi->postProfileToDatabaseDebugModeBenchmark: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profileUpdate** | [**ProfileUpdate**](ProfileUpdate.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postResetProfilePaging**
> postResetProfilePaging()

Reset profile paging.

Reset profile paging.  After this request getting next profiles will continue from the nearest profiles.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();

try {
    api_instance.postResetProfilePaging();
} catch (e) {
    print('Exception when calling ProfileApi->postResetProfilePaging: $e\n');
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

# **postSearchAgeRange**
> postSearchAgeRange(profileSearchAgeRange)

Set account's current search age range

Set account's current search age range

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final profileSearchAgeRange = ProfileSearchAgeRange(); // ProfileSearchAgeRange | 

try {
    api_instance.postSearchAgeRange(profileSearchAgeRange);
} catch (e) {
    print('Exception when calling ProfileApi->postSearchAgeRange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **profileSearchAgeRange** | [**ProfileSearchAgeRange**](ProfileSearchAgeRange.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postSearchGroups**
> postSearchGroups(searchGroups)

Set account's current search groups

Set account's current search groups (gender and what gender user is looking for)

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final searchGroups = SearchGroups(); // SearchGroups | 

try {
    api_instance.postSearchGroups(searchGroups);
} catch (e) {
    print('Exception when calling ProfileApi->postSearchGroups: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchGroups** | [**SearchGroups**](SearchGroups.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putLocation**
> putLocation(location)

Update location for account which makes this request.

Update location for account which makes this request.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ProfileApi();
final location = Location(); // Location | 

try {
    api_instance.putLocation(location);
} catch (e) {
    print('Exception when calling ProfileApi->putLocation: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **location** | [**Location**](Location.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

