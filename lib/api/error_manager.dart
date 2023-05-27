

import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

enum Error {
  api,
}

class ErrorManager extends AppSingleton {
  static final _instance = ErrorManager();

  final PublishSubject<Error> _errors = PublishSubject();

  ErrorManager();

  factory ErrorManager.getInstance() {
    return _instance;
  }

  Stream<Error> listen() {
    return _errors.stream;
  }

  void send(Error e) {
    _errors.add(e);
  }

  @override
  Future<void> init() async {
    // nothing to do
  }
}
