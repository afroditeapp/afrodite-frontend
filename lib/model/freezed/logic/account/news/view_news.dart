

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'view_news.freezed.dart';

@freezed
class ViewNewsData with _$ViewNewsData {
  factory ViewNewsData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    NewsItem? item,
  }) = _ViewNewsData;
}
