import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/common_repository.dart";
import "package:pihka_frontend/data/notification_manager.dart";

extension type NotificationPermissionAsked(bool? notificationPermissionAsked) {}

abstract class NotificationPermissionEvent {}

class SetNotificationPermissionAskedValue extends NotificationPermissionEvent {
  final bool value;
  SetNotificationPermissionAskedValue(this.value);
}
class DenyPermissions extends NotificationPermissionEvent {}
class AcceptPermissions extends NotificationPermissionEvent {}

class NotificationPermissionBloc extends Bloc<NotificationPermissionEvent, NotificationPermissionAsked> {
  NotificationPermissionBloc() : super(NotificationPermissionAsked(null)) {
    on<SetNotificationPermissionAskedValue>((data, emit) =>
      emit(NotificationPermissionAsked(data.value)
    ));
    on<DenyPermissions>((_, emit) async {
      await CommonRepository.getInstance().setNotificationPermissionAsked(true);
    });
    on<AcceptPermissions>((_, emit) async {
      await CommonRepository.getInstance().setNotificationPermissionAsked(true);
      await NotificationManager.getInstance().askPermissions();
    });

    CommonRepository.getInstance().notificationPermissionAsked.listen((state) {
      add(SetNotificationPermissionAskedValue(state));
    });
  }
}
