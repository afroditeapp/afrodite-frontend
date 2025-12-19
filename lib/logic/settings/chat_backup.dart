import "dart:io";
import "dart:typed_data";
import "package:app/data/chat/message_manager.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/logic/settings/chat_backup/chat_backup.dart";
import "package:app/model/freezed/logic/settings/chat_backup.dart";
import "package:app/utils/result.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_file_saver/flutter_file_saver.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:intl/intl.dart";

sealed class ChatBackupEvent {}

class CreateAndSaveChatBackup extends ChatBackupEvent {}

class ShareChatBackup extends ChatBackupEvent {}

class ImportChatBackup extends ChatBackupEvent {
  final String filePath;
  ImportChatBackup(this.filePath);
}

class ChatBackupBloc extends Bloc<ChatBackupEvent, ChatBackupData> with ActionRunner {
  final ChatRepository chat;

  ChatBackupBloc(RepositoryInstances r) : chat = r.chat, super(ChatBackupData()) {
    on<CreateAndSaveChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatBackupData(isLoading: true));

        try {
          final backup = await _createBackup();
          if (backup == null) {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }

          await FlutterFileSaver().writeFileAsBytes(fileName: backup.fileName, bytes: backup.bytes);
          emit(ChatBackupData());
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
        }
      });
    });

    on<ShareChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatBackupData(isLoading: true));

        try {
          final backup = await _createBackup();
          if (backup == null) {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }

          await shareBackupFile(backup.fileName, backup.bytes);
          emit(ChatBackupData());
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
}
