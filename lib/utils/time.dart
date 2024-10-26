

import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

class WantedWaitingTimeManager {
  final int wantedDurationMillis;
  final DateTime startTime = DateTime.now();

  WantedWaitingTimeManager({this.wantedDurationMillis = 500});

  Future<void> waitIfNeeded() async {
    final remainingTime = wantedDurationMillis - DateTime.now().difference(startTime).inMilliseconds;
    if (remainingTime > 0) {
      await Future.delayed(Duration(milliseconds: remainingTime), () => null);
    }
  }
}

String timeString(UtcDateTime messageTime) {
  final currentLocalTime = UtcDateTime.now().dateTime.toLocal();
  final localTime = messageTime.dateTime.toLocal();
  if (localTime.year == currentLocalTime.year) {
    if (
      localTime.month == currentLocalTime.month &&
      localTime.day == currentLocalTime.day
    ) {
      // Time
      return DateFormat.Hm().format(localTime);
    } else {
      // Month and day
      return DateFormat.Md().format(localTime);
    }
  } else {
    // Full date
    return DateFormat.yMd().format(localTime);
  }
}

String fullTimeString(UtcDateTime messageTime) {
  final localTime = messageTime.dateTime.toLocal();
  return DateFormat.yMd().add_Hm().format(localTime);
}
