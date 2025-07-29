import 'package:drift/drift.dart';
import 'package:openapi/api.dart';

class JsonList {
  final List<Object?> jsonList;
  JsonList(this.jsonList);

  Map<int, ProfileAttributeValueUpdate> toProfileAttributes() {
    final attributes = ProfileAttributeValue.listFromJson(jsonList)
      .map((v) => ProfileAttributeValueUpdate(id: v.id, v: v.v));
    return { for (var e in attributes) e.id : e };
  }

  static TypeConverter<JsonList, String> driftConverter = TypeConverter.json2(
    fromJson: (json) => JsonList(json as List<Object?>),
    toJson: (object) => object.jsonList,
  );
}

extension ProfileAttributeValueListJson on List<ProfileAttributeValue> {
  JsonList toJsonList() {
    return JsonList(map((e) => e.toJson()).toList());
  }
}
