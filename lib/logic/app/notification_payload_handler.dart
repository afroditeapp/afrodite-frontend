import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/general/notification/utils/notification_payload.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/model/freezed/logic/main/notification_payload_handler.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

abstract class NotificationPayloadHandlerEvent {}

/// UI navigation payloads require access to Blocs through BuildContext.
/// To avoid making more Blocs global, UI side creates a callback which handles
/// the payloads. It is assumed that the callback always succeeds, so make
/// sure that there will not be errors. The payload is removed from the queue
/// after the callback completes.
///
/// The handling is implemented like this to avoid handling payloads more than
/// once.
class HandleFirstPayload extends NotificationPayloadHandlerEvent {
  final Future<void> Function(NotificationPayload) handlePayloadCallback;
  HandleFirstPayload(this.handlePayloadCallback);
}

class AddNewPayload extends NotificationPayloadHandlerEvent {
  final NotificationPayload payload;
  AddNewPayload(this.payload);
}

class NotificationPayloadHandlerBloc extends Bloc<NotificationPayloadHandlerEvent, NotificationPayloadHandlerData> {

  StreamSubscription<NotificationPayload>? _payloadSubscription;

  NotificationPayloadHandlerBloc() : super(NotificationPayloadHandlerData()) {
    on<HandleFirstPayload>((data, emit) async {
      NotificationPayload? firstPayload;
      final List<NotificationPayload> otherPayloads = [];
      for (final payload in state.toBeHandled) {
        if (firstPayload == null) {
          firstPayload = payload;
        } else {
          otherPayloads.add(payload);
        }
      }

      if (firstPayload != null) {
        await data.handlePayloadCallback(firstPayload);
      }

      emit(state.copyWith(
        toBeHandled: UnmodifiableList(otherPayloads),
      ));
    });
    on<AddNewPayload>((data, emit) async {
      emit(state.copyWith(
        toBeHandled: state.toBeHandled.add(data.payload)
      ));
    });

    _payloadSubscription = NotificationManager.getInstance().onReceivedPayload.listen((state) {
      add(AddNewPayload(state));
    });
  }

  @override
  Future<void> close() async {
    await _payloadSubscription?.cancel();
    await super.close();
  }
}
