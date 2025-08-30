import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/general/notification/utils/notification_payload.dart";
import "package:app/data/notification_manager.dart";
import "package:app/model/freezed/logic/main/notification_payload_handler.dart";
import "package:app/utils/immutable_list.dart";

abstract class NotificationPayloadHandlerEvent {}

class HandleFirstPayload extends NotificationPayloadHandlerEvent {
  final NotificationPayload firstPayload;
  HandleFirstPayload(this.firstPayload);
}

class AddNewPayload extends NotificationPayloadHandlerEvent {
  final NotificationPayload payload;
  AddNewPayload(this.payload);
}

class NotificationPayloadHandlerBloc
    extends Bloc<NotificationPayloadHandlerEvent, NotificationPayloadHandlerData> {
  final RepositoryInstances r;
  StreamSubscription<NotificationPayload>? _payloadSubscription;

  NotificationPayloadHandlerBloc(this.r) : super(NotificationPayloadHandlerData()) {
    on<HandleFirstPayload>((data, emit) {
      final currentList = state.toBeHandled;
      final currentFirst = currentList.firstOrNull;
      if (currentFirst == null || data.firstPayload != currentFirst) {
        return;
      }
      emit(state.copyWith(toBeHandled: UnmodifiableList(currentList.skip(1).toList())));
    });
    on<AddNewPayload>((data, emit) {
      emit(state.copyWith(toBeHandled: state.toBeHandled.add(data.payload)));
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
