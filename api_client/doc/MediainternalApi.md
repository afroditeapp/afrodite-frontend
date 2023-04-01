# openapi.api.MediainternalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**postImage**](MediainternalApi.md#postimage) | **POST** /internal/image/{account_id}/{image_file} | 


# **postImage**
> postImage(accountId, imageFile, imageFile2)



### Example
```dart
import 'package:openapi/api.dart';

final api_instance = MediainternalApi();
final accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final imageFile = imageFile_example; // String | 
final imageFile2 = ImageFile(); // ImageFile | Upload new image

try {
    api_instance.postImage(accountId, imageFile, imageFile2);
} catch (e) {
    print('Exception when calling MediainternalApi->postImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **imageFile** | **String**|  | 
 **imageFile2** | [**ImageFile**](ImageFile.md)| Upload new image | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: image/jpeg
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

