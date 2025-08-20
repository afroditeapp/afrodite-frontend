import 'package:utils/utils.dart';

class ServerMaintenanceInfo {
  final UtcDateTime? maintenanceLatest;
  final UtcDateTime? maintenanceViewed;

  const ServerMaintenanceInfo({required this.maintenanceLatest, required this.maintenanceViewed});

  ServerMaintenanceInfo.empty() : maintenanceLatest = null, maintenanceViewed = null;

  int uiBadgeCount() {
    final latest = maintenanceLatest?.toUnixEpochMilliseconds();
    final viewed = maintenanceViewed?.toUnixEpochMilliseconds() ?? 0;
    if (latest != null && latest > viewed) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is ServerMaintenanceInfo &&
        maintenanceLatest == other.maintenanceLatest &&
        maintenanceViewed == other.maintenanceViewed;
  }

  @override
  int get hashCode => Object.hash(runtimeType, maintenanceLatest, maintenanceViewed);
}
