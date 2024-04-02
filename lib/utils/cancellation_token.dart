
import 'package:rxdart/rxdart.dart';

class CancellationToken {
  final _isCancelled = BehaviorSubject<bool>.seeded(false);
  bool get isCancelled => _isCancelled.value;
  Stream<bool> get cancellationStatusStream => _isCancelled;

  void cancel() {
    _isCancelled.add(true);
  }
}
