# openapi.api.ChatApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteLike**](ChatApi.md#deletelike) | **DELETE** /chat_api/delete_like | Delete sent like.
[**deletePendingMessages**](ChatApi.md#deletependingmessages) | **DELETE** /chat_api/pending_messages | Delete list of pending messages
[**getMatches**](ChatApi.md#getmatches) | **GET** /chat_api/matches | Get matches
[**getMessageNumberOfLatestViewedMessage**](ChatApi.md#getmessagenumberoflatestviewedmessage) | **GET** /chat_api/message_number_of_latest_viewed_message | Get message number of the most recent message that the recipient has viewed.
[**getPendingMessages**](ChatApi.md#getpendingmessages) | **GET** /chat_api/pending_messages | Get list of pending messages
[**getReceivedBlocks**](ChatApi.md#getreceivedblocks) | **GET** /chat_api/received_blocks | Get list of received blocks
[**getReceivedLikes**](ChatApi.md#getreceivedlikes) | **GET** /chat_api/received_likes | Get received likes.
[**getSentBlocks**](ChatApi.md#getsentblocks) | **GET** /chat_api/sent_blocks | Get list of sent blocks
[**getSentLikes**](ChatApi.md#getsentlikes) | **GET** /chat_api/sent_likes | Get sent likes.
[**postBlockProfile**](ChatApi.md#postblockprofile) | **POST** /chat_api/block_profile | Block profile
[**postMessageNumberOfLatestViewedMessage**](ChatApi.md#postmessagenumberoflatestviewedmessage) | **POST** /chat_api/message_number_of_latest_viewed_message | Update message number of the most recent message that the recipient has viewed.
[**postSendLike**](ChatApi.md#postsendlike) | **POST** /chat_api/send_like | Send a like to some account. If both will like each other, then
[**postSendMessage**](ChatApi.md#postsendmessage) | **POST** /chat_api/send_message | Send message to a match
[**postUnblockProfile**](ChatApi.md#postunblockprofile) | **POST** /chat_api/unblock_profile | Unblock profile


# **deleteLike**
> deleteLike(accountId)

Delete sent like.

Delete sent like.  Delete will not work if profile is a match.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.deleteLike(accountId);
} catch (e) {
    print('Exception when calling ChatApi->deleteLike: $e\n');
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

# **deletePendingMessages**
> deletePendingMessages(pendingMessageDeleteList)

Delete list of pending messages

Delete list of pending messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final pendingMessageDeleteList = PendingMessageDeleteList(); // PendingMessageDeleteList | 

try {
    api_instance.deletePendingMessages(pendingMessageDeleteList);
} catch (e) {
    print('Exception when calling ChatApi->deletePendingMessages: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pendingMessageDeleteList** | [**PendingMessageDeleteList**](PendingMessageDeleteList.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMatches**
> MatchesPage getMatches()

Get matches

Get matches

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getMatches();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getMatches: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MatchesPage**](MatchesPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessageNumberOfLatestViewedMessage**
> MessageNumber getMessageNumberOfLatestViewedMessage(accountId)

Get message number of the most recent message that the recipient has viewed.

Get message number of the most recent message that the recipient has viewed.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final accountId = AccountId(); // AccountId | 

try {
    final result = api_instance.getMessageNumberOfLatestViewedMessage(accountId);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getMessageNumberOfLatestViewedMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | [**AccountId**](AccountId.md)|  | 

### Return type

[**MessageNumber**](MessageNumber.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPendingMessages**
> PendingMessagesPage getPendingMessages()

Get list of pending messages

Get list of pending messages

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getPendingMessages();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getPendingMessages: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PendingMessagesPage**](PendingMessagesPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReceivedBlocks**
> ReceivedBlocksPage getReceivedBlocks()

Get list of received blocks

Get list of received blocks

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getReceivedBlocks();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getReceivedBlocks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ReceivedBlocksPage**](ReceivedBlocksPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReceivedLikes**
> ReceivedLikesPage getReceivedLikes()

Get received likes.

Get received likes.  Profile will not be returned if: - Profile is blocked - Profile is a match

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getReceivedLikes();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getReceivedLikes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ReceivedLikesPage**](ReceivedLikesPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSentBlocks**
> SentBlocksPage getSentBlocks()

Get list of sent blocks

Get list of sent blocks

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getSentBlocks();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getSentBlocks: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SentBlocksPage**](SentBlocksPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSentLikes**
> SentLikesPage getSentLikes()

Get sent likes.

Get sent likes.  Profile will not be returned if:  - Profile is hidden (not public) - Profile is blocked - Profile is a match

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();

try {
    final result = api_instance.getSentLikes();
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getSentLikes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SentLikesPage**](SentLikesPage.md)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postBlockProfile**
> postBlockProfile(accountId)

Block profile

Block profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.postBlockProfile(accountId);
} catch (e) {
    print('Exception when calling ChatApi->postBlockProfile: $e\n');
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

# **postMessageNumberOfLatestViewedMessage**
> postMessageNumberOfLatestViewedMessage(updateMessageViewStatus)

Update message number of the most recent message that the recipient has viewed.

Update message number of the most recent message that the recipient has viewed.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final updateMessageViewStatus = UpdateMessageViewStatus(); // UpdateMessageViewStatus | 

try {
    api_instance.postMessageNumberOfLatestViewedMessage(updateMessageViewStatus);
} catch (e) {
    print('Exception when calling ChatApi->postMessageNumberOfLatestViewedMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMessageViewStatus** | [**UpdateMessageViewStatus**](UpdateMessageViewStatus.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postSendLike**
> postSendLike(accountId)

Send a like to some account. If both will like each other, then

Send a like to some account. If both will like each other, then the accounts will be a match.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.postSendLike(accountId);
} catch (e) {
    print('Exception when calling ChatApi->postSendLike: $e\n');
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

# **postSendMessage**
> postSendMessage(sendMessageToAccount)

Send message to a match

Send message to a match

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final sendMessageToAccount = SendMessageToAccount(); // SendMessageToAccount | 

try {
    api_instance.postSendMessage(sendMessageToAccount);
} catch (e) {
    print('Exception when calling ChatApi->postSendMessage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendMessageToAccount** | [**SendMessageToAccount**](SendMessageToAccount.md)|  | 

### Return type

void (empty response body)

### Authorization

[access_token](../README.md#access_token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postUnblockProfile**
> postUnblockProfile(accountId)

Unblock profile

Unblock profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: access_token
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('access_token').apiKeyPrefix = 'Bearer';

final api_instance = ChatApi();
final accountId = AccountId(); // AccountId | 

try {
    api_instance.postUnblockProfile(accountId);
} catch (e) {
    print('Exception when calling ChatApi->postUnblockProfile: $e\n');
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

