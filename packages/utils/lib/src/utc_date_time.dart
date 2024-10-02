

class UtcDateTime {
  final DateTime dateTime;

  UtcDateTime._(this.dateTime);

  factory UtcDateTime.now() {
    return UtcDateTime._(DateTime.now().toUtc());
  }

  factory UtcDateTime.fromUnixEpochMilliseconds(int milliseconds) {
    return UtcDateTime._(DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true));
  }

  int toUnixEpochMilliseconds() {
    return dateTime.millisecondsSinceEpoch;
  }

  /// This duration must be newer than [other] to avoid negative values.
  Duration difference(UtcDateTime other) {
    return dateTime.difference(other.dateTime);
  }
}
