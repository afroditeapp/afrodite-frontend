import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:flutter/foundation.dart";

part 'info_banners.freezed.dart';

@freezed
class InfoBannersData with _$InfoBannersData {
  const InfoBannersData._();

  factory InfoBannersData({
    required Map<String, InfoBannerDismissState> dismissStates,
    required ServerMaintenanceInfo maintenanceInfo,
  }) = _InfoBannersData;
}
