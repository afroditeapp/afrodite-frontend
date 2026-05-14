import 'dart:async';

import 'package:app/data/utils/repository_instances.dart';
import 'package:app/database/account_database_manager.dart';
import 'package:database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

const _mandatoryDialogReopenBlockDuration = Duration(minutes: 1);

class AppUpdateAvailableData {
  final bool shouldOpenDialog;

  const AppUpdateAvailableData({required this.shouldOpenDialog});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUpdateAvailableData && other.shouldOpenDialog == shouldOpenDialog);

  @override
  int get hashCode => Object.hash(runtimeType, shouldOpenDialog);
}

sealed class AppUpdateAvailableEvent {}

class _DbUpdate extends AppUpdateAvailableEvent {
  final AppUpdateAvailableDialogState? value;
  _DbUpdate(this.value);
}

class AppUpdateDialogOpened extends AppUpdateAvailableEvent {}

class AppUpdateDialogLaterSelected extends AppUpdateAvailableEvent {}

class AppUpdateAvailableBloc extends Bloc<AppUpdateAvailableEvent, AppUpdateAvailableData> {
  final AccountDatabaseManager db;

  StreamSubscription<AppUpdateAvailableDialogState?>? _stateSubscription;

  AppUpdateAvailableBloc(RepositoryInstances r)
    : db = r.accountDb,
      super(const AppUpdateAvailableData(shouldOpenDialog: false)) {
    on<_DbUpdate>((event, emit) {
      emit(AppUpdateAvailableData(shouldOpenDialog: _shouldDialogOpen(event.value)));
    });

    on<AppUpdateDialogOpened>((event, emit) async {
      final blockUntil = UtcDateTime.now().add(_mandatoryDialogReopenBlockDuration);
      await db.accountAction(
        (db) => db.app.removeAppUpdateDialogEventTimeAndBlockDialogsUntil(blockUntil),
      );
    });

    on<AppUpdateDialogLaterSelected>((_, emit) async {
      final blockUntil = UtcDateTime.now().add(const Duration(hours: 24));
      await db.accountAction((db) => db.app.updateAppUpdateAvailableDialogBlockUntil(blockUntil));
    });

    _stateSubscription = db
        .accountStream((db) => db.app.watchAppUpdateAvailableDialogState())
        .listen((value) {
          add(_DbUpdate(value));
        });
  }

  bool _shouldDialogOpen(AppUpdateAvailableDialogState? value) {
    if (value == null || value.latestEventTime == null) {
      return false;
    }

    final blockUntil = value.blockDialogsUntil;
    if (blockUntil != null && blockUntil.dateTime.isAfter(UtcDateTime.now().dateTime)) {
      return false;
    }

    return true;
  }

  @override
  Future<void> close() async {
    await _stateSubscription?.cancel();
    await super.close();
  }
}
