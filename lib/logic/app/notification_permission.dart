import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/notification_manager.dart";

extension type NotificationPermissionAsked(bool? notificationPermissionAsked) {}

abstract class NotificationPermissionEvent {}

class SetNotificationPermissionAskedValue extends NotificationPermissionEvent {
  final bool value;
  SetNotificationPermissionAskedValue(this.value);
}
class DenyPermissions extends NotificationPermissionEvent {}
class AcceptPermissions extends NotificationPermissionEvent {}

class NotificationPermissionBloc extends Bloc<NotificationPermissionEvent, NotificationPermissionAsked> {
  final common = LoginRepository.getInstance().repositories.common;
  StreamSubscription<bool?>? _notificationPermissionAskedSubscription;

  NotificationPermissionBloc() : super(NotificationPermissionAsked(null)) {
    on<SetNotificationPermissionAskedValue>((data, emit) =>
      emit(NotificationPermissionAsked(data.value)
    ));
    on<DenyPermissions>((_, emit) async {
      await common.setNotificationPermissionAsked(true);
    });
    on<AcceptPermissions>((_, emit) async {
      await common.setNotificationPermissionAsked(true);
      await NotificationManager.getInstance().askPermissions();
    });

    _notificationPermissionAskedSubscription = common.notificationPermissionAsked.listen((state) {
      add(SetNotificationPermissionAskedValue(state));
    });
  }

  @override
  Future<void> close() async {
    await _notificationPermissionAskedSubscription?.cancel();
    await super.close();
  }
}
