import 'package:utils/utils.dart';

class ServerMaintenanceInfo {
  final UtcDateTime? startTime;
  final UtcDateTime? endTime;
  final UtcDateTime? infoViewed;
  final bool adminBotOffline;

  const ServerMaintenanceInfo({
    required this.startTime,
    required this.endTime,
    required this.infoViewed,
    required this.adminBotOffline,
  });

  ServerMaintenanceInfo.empty()
    : startTime = null,
      endTime = null,
      infoViewed = null,
      adminBotOffline = false;

  int uiBadgeCount() {
    final latest = startTime?.toUnixEpochMilliseconds();
    final viewed = infoViewed?.toUnixEpochMilliseconds() ?? 0;
    if (latest != null && latest > viewed) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is ServerMaintenanceInfo &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        infoViewed == other.infoViewed &&
        adminBotOffline == other.adminBotOffline;
  }

  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, infoViewed, adminBotOffline);
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
