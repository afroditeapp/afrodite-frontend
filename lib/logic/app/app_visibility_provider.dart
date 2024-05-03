


import 'package:pihka_frontend/utils.dart';

class AppVisibilityProvider extends AppSingletonNoInit {
  static final _instance = AppVisibilityProvider._();
  AppVisibilityProvider._();
  factory AppVisibilityProvider.getInstance() {
    return _instance;
  }

  bool _isForeground = false;

  bool get isForeground => _isForeground;

  void setForeground(bool value) {
    _isForeground = value;
  }
}
