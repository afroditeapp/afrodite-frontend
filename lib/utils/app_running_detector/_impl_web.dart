import 'dart:js_interop';

@JS('app_already_running')
external JSPromise<JSBoolean> get _appAlreadyRunning;

Future<bool> isAppAlreadyRunning() async {
  return (await _appAlreadyRunning.toDart).toDart;
}
