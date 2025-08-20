import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';

part 'profile_statistics_history.freezed.dart';

@freezed
class ProfileStatisticsHistoryData with _$ProfileStatisticsHistoryData {
  factory ProfileStatisticsHistoryData({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    GetProfileStatisticsHistoryResult? item,
  }) = _ProfileStatisticsHistoryData;
}
