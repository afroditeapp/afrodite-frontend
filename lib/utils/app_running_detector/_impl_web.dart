import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:utils/utils.dart';
import 'package:web/web.dart';

const REQUEST = 0;
const RESPONSE = 1;

Future<bool> isAppAlreadyRunning() async {
  final id = generate128BitRandomValue();
  final channel = BroadcastChannel("app_running_detector");
  var resposeReceived = false;
  void eventHandlerDart(MessageEvent event) {
    final data = (event.data as JSUint8Array).toDart;
    final receivedId = data.sublist(1);
    if (data[0] == REQUEST) {
      channel.postMessage(Uint8List.fromList([RESPONSE, ...receivedId]).toJS);
    } else if (data[0] == RESPONSE && listEquals(receivedId, id)) {
      resposeReceived = true;
    }
  }

  channel.onmessage = eventHandlerDart.toJS;
  channel.postMessage(Uint8List.fromList([REQUEST, ...id]).toJS);
  await Future<void>.delayed(Duration(milliseconds: 100));
  return resposeReceived;
}
