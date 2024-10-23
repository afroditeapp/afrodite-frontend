import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'news_count.freezed.dart';

@freezed
class NewsCountData with _$NewsCountData {
  const NewsCountData._();

  factory NewsCountData({
    @Default(0) int newsCount,
    @Default(0) int newsCountUserViewed,
  }) = _NewsCountData;

  int newsCountForUi() {
    return newsCount - newsCountUserViewed;
  }
}
