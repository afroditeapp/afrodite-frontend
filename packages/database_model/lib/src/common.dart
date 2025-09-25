import 'package:utils/utils.dart';

class ServerMaintenanceInfo {
  final UtcDateTime? startTime;
  final UtcDateTime? endTime;
  final UtcDateTime? infoViewed;

  const ServerMaintenanceInfo({
    required this.startTime,
    required this.endTime,
    required this.infoViewed,
  });

  ServerMaintenanceInfo.empty() : startTime = null, endTime = null, infoViewed = null;

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
        infoViewed == other.infoViewed;
  }

  @override
  int get hashCode => Object.hash(runtimeType, startTime, endTime, infoViewed);
}
