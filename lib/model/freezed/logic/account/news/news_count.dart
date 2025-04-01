import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'news_count.freezed.dart';

@freezed
class NewsCountData with _$NewsCountData {
  const NewsCountData._();

  factory NewsCountData({
    @Default(0) int newsCount,
  }) = _NewsCountData;

  int newsCountForUi(ClientFeaturesConfig clientFeatures) {
    if (clientFeatures.features.news) {
      return newsCount;
    } else {
      return 0;
    }
  }
}
