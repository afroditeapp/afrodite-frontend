# openapi.model.AttributeValue

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**editable** | **bool** |  | [optional] [default to true]
**groupValues** | [**GroupValues**](GroupValues.md) |  | [optional] 
**icon** | [**IconResource**](IconResource.md) |  | [optional] 
**id** | **int** | Numeric unique identifier for the attribute value. Note that the value must only be unique within a group of values, so value in top level group A, sub level group C and sub level group B can have the same ID. | 
**key** | **String** | Unique string identifier for the attribute value. | 
**orderNumber** | **int** | Order number for client to determine in what order the values should be displayed. | 
**value** | **String** | English text for the attribute value. | 
**visible** | **bool** |  | [optional] [default to true]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


