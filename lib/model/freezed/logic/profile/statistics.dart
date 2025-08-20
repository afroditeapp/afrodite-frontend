import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'statistics.freezed.dart';

@freezed
class StatisticsData with _$StatisticsData {
  factory StatisticsData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    GetProfileStatisticsResult? item,
  }) = _StatisticsData;
}
