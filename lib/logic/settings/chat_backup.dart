import "dart:async";
import "dart:io";
import "dart:typed_data";
import "package:app/data/chat/message_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
import "package:app/model/freezed/logic/settings/chat_backup.dart";
import "package:app/utils/result.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_file_saver/flutter_file_saver.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:intl/intl.dart";
import "package:utils/utils.dart";

sealed class ChatBackupEvent {}

class _UpdateFromDatabase extends ChatBackupEvent {
  final int? reminderIntervalDays;
  final UtcDateTime? lastBackupTime;
  final UtcDateTime? lastDialogOpenedTime;
  _UpdateFromDatabase({this.reminderIntervalDays, this.lastBackupTime, this.lastDialogOpenedTime});
}

class UpdateReminderInterval extends ChatBackupEvent {
  final int? days;
  UpdateReminderInterval(this.days);
}

class HandleReminderDialogOpening extends ChatBackupEvent {}

class CheckDialogShouldOpen extends ChatBackupEvent {}

class CreateAndSaveChatBackup extends ChatBackupEvent {}

class ImportChatBackup extends ChatBackupEvent {
  final String filePath;
  ImportChatBackup(this.filePath);
}

class ChatBackupBloc extends Bloc<ChatBackupEvent, ChatBackupData> with ActionRunner {
  final ChatRepository chat;
  final AccountDatabaseManager accountDb;
  StreamSubscription<void>? _reminderSubscription;
  Timer? _dailyTimer;

  ChatBackupBloc(RepositoryInstances r)
    : chat = r.chat,
      accountDb = r.accountDb,
      super(ChatBackupData()) {
    on<_UpdateFromDatabase>((data, emit) {
      emit(
        state.copyWith(
          reminderIntervalDays: data.reminderIntervalDays,
          lastBackupTime: data.lastBackupTime,
          lastDialogOpenedTime: data.lastDialogOpenedTime,
        ),
      );
    });

    on<CheckDialogShouldOpen>((data, emit) {
      final reminderInterval = state.valueReminderIntervalDays();
      if (reminderInterval == 0) {
        // Reminder disabled, ensure no dialog is triggered
        emit(state.copyWith(dialogTrigger: null));
        return;
      }

      final now = UtcDateTime.now();
      final lastDialogOpened = state.lastDialogOpenedTime;
      final lastBackup = state.lastBackupTime;

      if (lastDialogOpened == null) {
        // Init lastDialogOpened with current time
        add(HandleReminderDialogOpening());
        return;
      }

      // Check if we should show the dialog
      DialogTrigger? trigger;

      if (lastBackup == null) {
        // No backup created yet
        final daysSinceDialog = now.difference(lastDialogOpened).inDays;
        if (daysSinceDialog >= reminderInterval) {
          trigger = const NoPreviousBackup();
        }
      } else {
        // Backup exists, check if it's old
        final daysSinceBackup = now.difference(lastBackup).inDays;
        if (daysSinceBackup >= reminderInterval) {
          final daysSinceDialog = now.difference(lastDialogOpened).inDays;
          if (daysSinceDialog >= reminderInterval) {
            trigger = OldBackup(daysSinceBackup);
          }
        }
      }

      emit(state.copyWith(dialogTrigger: trigger));
    });

    on<UpdateReminderInterval>((data, emit) async {
      await r.accountDb.accountAction((db) => db.app.updateChatBackupReminderInterval(data.days));
      emit(state.copyWith(reminderIntervalDays: data.days));
    });

    on<HandleReminderDialogOpening>((data, emit) async {
      final now = UtcDateTime.now();
      await r.accountDb.accountAction((db) => db.app.updateChatBackupLastDialogOpenedTime(now));
      emit(state.copyWith(lastDialogOpenedTime: now, dialogTrigger: null));
    });

    on<CreateAndSaveChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        try {
          final backup = await _createBackup();
          if (backup == null) {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }

          await FlutterFileSaver().writeFileAsBytes(fileName: backup.fileName, bytes: backup.bytes);

          final now = UtcDateTime.now();
          await r.accountDb.accountAction((db) => db.app.updateChatBackupLastBackupTime(now));

          emit(state.copyWith(isError: false, isLoading: false, lastBackupTime: now));
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
        }
      });
    });

    on<ImportChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        try {
          final file = File(data.filePath);
          final bytes = await file.readAsBytes();
          final result = await chat.importChatBackup(bytes);
          switch (result) {
            case Ok():
              showSnackBar(R.strings.generic_action_completed);
              emit(state.copyWith(isLoading: false));
            case Err(:final e):
              emit(state.copyWith(isError: true, isLoading: false));
              switch (e) {
                case InvalidBackupFile():
                  showSnackBar(R.strings.chat_backup_screen_import_error_invalid_backup_file);
                case UnsupportedBackupVersion():
                  showSnackBar(R.strings.chat_backup_screen_import_error_unsupported_version);
                case WrongAccount():
                  showSnackBar(R.strings.chat_backup_screen_import_error_wrong_account);
                case OtherImportError():
                  showSnackBar(R.strings.generic_error);
              }
          }
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
          showSnackBar(R.strings.generic_error);
        }
      });
    });

    _reminderSubscription = accountDb
        .accountStream((db) => db.app.watchChatBackupReminder())
        .listen((reminderData) {
          if (reminderData != null) {
            add(
              _UpdateFromDatabase(
                reminderIntervalDays: reminderData.reminderIntervalDays,
                lastBackupTime: reminderData.lastBackupTime,
                lastDialogOpenedTime: reminderData.lastDialogOpenedTime,
              ),
            );
          }
        });

    // Check immediately on initialization
    add(CheckDialogShouldOpen());

    // Set up daily timer (24 hours)
    _dailyTimer = Timer.periodic(const Duration(hours: 24), (_) {
      add(CheckDialogShouldOpen());
    });
  }

  Future<({String fileName, Uint8List bytes})?> _createBackup() async {
    final backupDataResult = await chat.createChatBackup();
    final backupData = backupDataResult.ok();
    if (backupData == null) {
      return null;
    }

    final backupFile = backupData.compress();
    final bytes = Uint8List.fromList(backupFile.toBytes());

    final appName = R.strings.app_name.toLowerCase();
    final timestamp = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());
    final fileName = "${appName}_$timestamp.backup";

    return (fileName: fileName, bytes: bytes);
  }

  @override
  Future<void> close() {
    _reminderSubscription?.cancel();
    _dailyTimer?.cancel();
    return super.close();
  }
}
