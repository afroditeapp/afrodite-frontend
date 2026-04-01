import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:flutter/foundation.dart";
import "package:openapi/api.dart";

part 'info_banners.freezed.dart';

@freezed
class InfoBannersData with _$InfoBannersData {
  const InfoBannersData._();

  factory InfoBannersData({
    required Map<String, InfoBannerDismissState> dismissStates,
    required ServerMaintenanceInfo maintenanceInfo,
  }) = _InfoBannersData;

  int serverMaintenanceUiBadgeCount(DynamicClientFeaturesConfig clientFeaturesConfig) {
    if (!maintenanceInfo.showBadge) {
      return 0;
    }

    final hasServerMaintenance = maintenanceInfo.startTime != null;
    final hasAdminBotOffline = maintenanceInfo.adminBotOffline;
    if (!hasServerMaintenance && !hasAdminBotOffline) {
      return 0;
    }

    final allBanners = clientFeaturesConfig.infoBanners?.banners ?? const <String, InfoBanner>{};

    final hasServerMaintenanceOverride = allBanners.values.any(
      (banner) =>
          banner.overridePredefinedBanner == PredefinedBanner.serverMaintenance &&
          banner.visibility.menu,
    );
    if (hasServerMaintenance && !hasServerMaintenanceOverride) {
      return 1;
    }

    final hasAdminBotOfflineOverride = allBanners.values.any(
      (banner) =>
          banner.overridePredefinedBanner == PredefinedBanner.adminBotOffline &&
          banner.visibility.menu,
    );
    if (hasAdminBotOffline && !hasAdminBotOfflineOverride) {
      return 1;
    }

    return 0;
  }
}
