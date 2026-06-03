import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

String timeString(UtcDateTime messageTime, String localeString) {
  final currentLocalTime = UtcDateTime.now().dateTime.toLocal();
  final localTime = messageTime.dateTime.toLocal();
  if (localTime.year == currentLocalTime.year) {
    if (localTime.month == currentLocalTime.month && localTime.day == currentLocalTime.day) {
      // Time
      return DateFormat.Hm(localeString).format(localTime);
    } else {
      // Month and day
      return DateFormat.Md(localeString).format(localTime);
    }
  } else {
    // Full date
    return DateFormat.yMd(localeString).format(localTime);
  }
}

String fullTimeString(UtcDateTime messageTime, String localeString) {
  final localTime = messageTime.dateTime.toLocal();
  return DateFormat.yMd(localeString).add_Hm().format(localTime);
}

String fullTimeWithSecondsString(UtcDateTime messageTime, String localeString) {
  final localTime = messageTime.dateTime.toLocal();
  return DateFormat.yMd(localeString).add_Hms().format(localTime);
}
