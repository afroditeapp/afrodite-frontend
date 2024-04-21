

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
