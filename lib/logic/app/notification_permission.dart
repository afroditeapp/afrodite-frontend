import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/notification_manager.dart";
import "package:pihka_frontend/storage/kv.dart";

extension type NotificationPermissionAsked(bool notificationPermissionAsked) {}

abstract class NotificationPermissionEvent {}

class SetNotificationPermissionAskedValue extends NotificationPermissionEvent {
  final bool value;
  SetNotificationPermissionAskedValue(this.value);
}
class DenyPermissions extends NotificationPermissionEvent {}
class AcceptPermissions extends NotificationPermissionEvent {}

/// Get current main state of the account/app
class NotificationPermissionBloc extends Bloc<NotificationPermissionEvent, NotificationPermissionAsked> {
  NotificationPermissionBloc() : super(NotificationPermissionAsked(false)) {
    on<SetNotificationPermissionAskedValue>((data, emit) =>
      emit(NotificationPermissionAsked(data.value)
    ));
    on<DenyPermissions>((_, emit) async {
      await KvBooleanManager.getInstance().setValue(KvBoolean.accountNotificationPermissionAsked, true);
    });
    on<AcceptPermissions>((_, emit) async {
      await KvBooleanManager.getInstance().setValue(KvBoolean.accountNotificationPermissionAsked, true);
      await NotificationManager.getInstance().askPermissions();
    });

    AccountRepository.getInstance().notificationPermissionAsked.listen((state) {
      add(SetNotificationPermissionAskedValue(state));
    });
  }
}
