import 'package:utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class AppVisibilityProvider extends AppSingletonNoInit {
  static final _instance = AppVisibilityProvider._();
  AppVisibilityProvider._();
  factory AppVisibilityProvider.getInstance() {
    return _instance;
  }

  final BehaviorSubject<bool> _isForeground = BehaviorSubject.seeded(false);

  bool get isForeground => _isForeground.value;

  Stream<bool> get isForegroundStream => _isForeground;

  void setForeground(bool value) {
    _isForeground.add(value);
  }
}
