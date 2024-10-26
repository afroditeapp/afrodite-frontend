

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'profile_statistics.freezed.dart';

@freezed
class ProfileStatisticsData with _$ProfileStatisticsData {
  factory ProfileStatisticsData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    GetProfileStatisticsResult? item,
  }) = _ProfileStatisticsData;
}
