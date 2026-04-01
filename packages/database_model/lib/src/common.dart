import 'package:utils/utils.dart';

class ServerMaintenanceInfo {
  final UtcDateTime? startTime;
  final UtcDateTime? endTime;
  final bool showBadge;
  final bool adminBotOffline;

  const ServerMaintenanceInfo({
    required this.startTime,
    required this.endTime,
    required this.showBadge,
    required this.adminBotOffline,
  });

  ServerMaintenanceInfo.empty()
    : startTime = null,
      endTime = null,
      showBadge = false,
      adminBotOffline = false;

  @override
  bool operator ==(Object other) {
    return other is ServerMaintenanceInfo &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        showBadge == other.showBadge &&
        adminBotOffline == other.adminBotOffline;
  }

  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, showBadge, adminBotOffline);
}

class InfoBannerDismissState {
  final String bannerKey;
  final int bannerVersion;
  final bool dismissed;

  const InfoBannerDismissState({
    required this.bannerKey,
    required this.bannerVersion,
    required this.dismissed,
  });

  @override
  bool operator ==(Object other) {
    return other is InfoBannerDismissState &&
        bannerKey == other.bannerKey &&
        bannerVersion == other.bannerVersion &&
        dismissed == other.dismissed;
  }

  @override
  int get hashCode => Object.hash(runtimeType, bannerKey, bannerVersion, dismissed);
}
