

import 'package:app/utils/list.dart';
import 'package:device_info_plus/device_info_plus.dart';

class IosVersion {
  final int major;
  final int minor;
  IosVersion._(this.major, this.minor);

  static IosVersion? parse(IosDeviceInfo info) {
    final numbers = info.systemVersion.split(".");
    final majorString = numbers.getAtOrNull(0);
    final majorInt = majorString != null ? int.tryParse(majorString) : null;
    final minorString = numbers.getAtOrNull(1);
    final minorInt = minorString != null ? int.tryParse(minorString) : null;
    if (majorInt != null) {
      return IosVersion._(majorInt, minorInt ?? 0);
    } else {
      return null;
    }
  }
}
