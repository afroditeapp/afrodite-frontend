class WantedWaitingTimeManager {
  final int wantedDurationMillis;
  final DateTime startTime = DateTime.now();

  WantedWaitingTimeManager({this.wantedDurationMillis = 500});

  Future<void> waitIfNeeded() async {
    final remainingTime =
        wantedDurationMillis - DateTime.now().difference(startTime).inMilliseconds;
    if (remainingTime > 0) {
      await Future.delayed(Duration(milliseconds: remainingTime), () => null);
    }
  }
}

/// Formats a duration given in seconds into a compact human readable string,
/// for example "1h 30m", "5m 10s" or "45s".
String formatSeconds(int seconds) {
  final duration = Duration(seconds: seconds);
  if (duration.inHours > 0) {
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
  } else if (duration.inMinutes > 0) {
    return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
  } else {
    return '${duration.inSeconds}s';
  }
}
