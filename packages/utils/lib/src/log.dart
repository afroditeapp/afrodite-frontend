import 'package:logging/logging.dart';

extension LogUtils on Logger {
  void error(Object? message, [Object? error, StackTrace? stackTrace]) {
    severe(message, error, stackTrace);
  }
}
