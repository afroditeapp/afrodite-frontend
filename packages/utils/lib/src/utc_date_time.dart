

class UtcDateTime {
  final DateTime dateTime;

  UtcDateTime._(this.dateTime);

  factory UtcDateTime.now() {
    return UtcDateTime._(DateTime.now().toUtc());
  }

  factory UtcDateTime.fromUnixEpochMilliseconds(int milliseconds) {
    return UtcDateTime._(DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true));
  }

  factory UtcDateTime.fromDateTime(DateTime time) {
    return UtcDateTime._(time.toUtc());
  }

  int toUnixEpochMilliseconds() {
    return dateTime.millisecondsSinceEpoch;
  }

  /// This duration must be newer than [other] to avoid negative values.
  Duration difference(UtcDateTime other) {
    return dateTime.difference(other.dateTime);
  }

  UtcDateTime add(Duration duration) {
    return UtcDateTime._(dateTime.add(duration));
  }

  UtcDateTime substract(Duration duration) {
    return UtcDateTime._(dateTime.subtract(duration));
  }
}
