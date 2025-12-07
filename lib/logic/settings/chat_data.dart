import "dart:io";
import "package:app/data/chat_repository.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/model/freezed/logic/settings/chat_data.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_file_saver/flutter_file_saver.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:intl/intl.dart";

sealed class ChatDataEvent {}

class CreateChatBackup extends ChatDataEvent {}

class DeleteCurrentChatBackup extends ChatDataEvent {}

class SaveChatBackup extends ChatDataEvent {
  final ChatDataBackup data;
  SaveChatBackup(this.data);
}

class ImportChatBackup extends ChatDataEvent {
  final String filePath;
  ImportChatBackup(this.filePath);
}

class ChatDataBloc extends Bloc<ChatDataEvent, ChatDataData> with ActionRunner {
  final ChatRepository chat;

  ChatDataBloc(RepositoryInstances r) : chat = r.chat, super(ChatDataData()) {
    on<CreateChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatDataData(isLoading: true));

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
          final fileName = "${appName}_chat_data_$timestamp.backup";

          emit(state.copyWith(isLoading: false, backup: ChatDataBackup(fileName, bytes)));
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
        }
      });
    });

    on<DeleteCurrentChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(ChatDataData());
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
          emit(ChatDataData());
        } catch (_) {
          emit(state.copyWith(isLoading: false));
        }
      });
    });

    on<ImportChatBackup>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        try {
          // Read file and decompress
          final file = File(data.filePath);
          final bytes = await file.readAsBytes();
          final backupFile = ChatBackupFile.fromBytes(bytes);
          final backupData = backupFile.decompress();

          // Restore backup using ChatRepository
          await chat.importChatBackup(backupData);

          showSnackBar(R.strings.generic_action_completed);
          emit(ChatDataData());
        } catch (e) {
          emit(state.copyWith(isError: true, isLoading: false));
          showSnackBar(R.strings.generic_error);
        }
      });
    });
  }
}
