# openapi.model.Attribute

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**editable** | **bool** | Client should show this attribute when editing a profile. | [optional] [default to true]
**icon** | **String** | Icon for the attribute. | 
**id** | **int** | Numeric unique identifier for the attribute. | 
**key** | **String** | String unique identifier for the attribute. | 
**mode** | [**AttributeMode**](AttributeMode.md) |  | 
**name** | **String** | English text for the attribute. | 
**orderNumber** | **int** | Attribute order number. | 
**required_** | **bool** | Client should ask this attribute when doing account initial setup. | [optional] [default to false]
**translations** | [**List<Language>**](Language.md) | Translations for attribute name and attribute values. | [optional] [default to const []]
**valueOrder** | [**AttributeValueOrderMode**](AttributeValueOrderMode.md) |  | 
**values** | [**List<AttributeValue>**](AttributeValue.md) | Top level values for the attribute.  Values are sorted by AttributeValue ID. Indexing with it is not possible as ID might be a bitflag value. | [default to const []]
**visible** | **bool** | Client should show this attribute when viewing a profile. | [optional] [default to true]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


