import "dart:io";
import "package:app/data/chat/message_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/model/freezed/logic/settings/chat_backup.dart";
import "package:app/utils/result.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_file_saver/flutter_file_saver.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:intl/intl.dart";

sealed class ChatBackupEvent {}

class CreateChatBackup extends ChatBackupEvent {}

class DeleteCurrentChatBackup extends ChatBackupEvent {}

class SaveChatBackup extends ChatBackupEvent {
  final ChatBackupInfo data;
  SaveChatBackup(this.data);
}

class ImportChatBackup extends ChatBackupEvent {
  final String filePath;
  ImportChatBackup(this.filePath);
}

class ChatBackupBloc extends Bloc<ChatBackupEvent, ChatBackupData> with ActionRunner {
  final ChatRepository chat;

  ChatBackupBloc(RepositoryInstances r) : chat = r.chat, super(ChatBackupData()) {
    on<CreateChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatBackupData(isLoading: true));

        try {
          // Create backup using ChatRepository
          final backupDataResult = await chat.createChatBackup();
          final backupData = backupDataResult.ok();
          if (backupData == null) {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }

          // Compress the backup
          final backupFile = backupData.compress();
          final bytes = backupFile.toBytes();

          // Generate filename with timestamp
          final appName = R.strings.app_name.toLowerCase();
          final timestamp = DateFormat('yyyy-MM-dd_HH-mm').format(DateTime.now());
          final fileName = "${appName}_chat_backup_$timestamp.backup";

          emit(state.copyWith(isLoading: false, backup: ChatBackupInfo(fileName, bytes)));
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
        }
      });
    });

    on<DeleteCurrentChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatBackupData());
      });
    });

    on<SaveChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        try {
          await FlutterFileSaver().writeFileAsBytes(
            fileName: data.data.fileName,
            bytes: data.data.data,
          );
          emit(ChatBackupData());
        } catch (_) {
          emit(state.copyWith(isLoading: false));
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
              emit(ChatBackupData());
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
  }
}
