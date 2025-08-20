import "package:app/api/api_manager.dart";
import "package:app/model/freezed/logic/settings/data_export.dart";
import "package:app/utils/result.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_file_saver/flutter_file_saver.dart";
import "package:openapi/api.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";
import "package:openapi/manual_additions.dart";

sealed class DataExportEvent {}

class DownloadDataExport extends DataExportEvent {
  final AccountId account;
  final DataExportType dataExportType;
  DownloadDataExport(this.account, this.dataExportType);
}

class DeleteCurrentDataExport extends DataExportEvent {}

class SaveDataExport extends DataExportEvent {
  final DataExportNameAndData data;
  SaveDataExport(this.data);
}

class DataExportBloc extends Bloc<DataExportEvent, DataExportData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  DataExportBloc() : super(DataExportData()) {
    on<DownloadDataExport>((data, emit) async {
      await runOnce(() async {
        emit(DataExportData(isLoading: true));

        final deleteResult = await api.commonAction((api) => api.deleteDataExport());
        if (deleteResult.isErr()) {
          emit(state.copyWith(isError: true, isLoading: false));
          return;
        }

        final startDataExportResult = await api.commonWrapper().requestAction(
          (api) => api.postStartDataExport(
            PostStartDataExport(source_: data.account, dataExportType: data.dataExportType),
          ),
          logError: false,
        );
        if (startDataExportResult case Err()) {
          if (startDataExportResult.e.isTooManyRequests()) {
            showSnackBar(R.strings.data_export_screen_api_limit_error);
          }
          emit(state.copyWith(isError: true, isLoading: false));
          return;
        }

        String name = "";
        while (true) {
          await Future<void>.delayed(Duration(seconds: 1));
          final stateResult = await api.common((api) => api.getDataExportState()).ok();
          if (stateResult == null) {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }
          final stateResultName = stateResult.name;
          if (stateResult.state == DataExportStateType.inProgress) {
            continue;
          } else if (stateResult.state == DataExportStateType.done && stateResultName != null) {
            name = stateResultName.name;
            break;
          } else {
            emit(state.copyWith(isError: true, isLoading: false));
            return;
          }
        }

        final downloadResult = await api.common((api) => api.getDataExportArchiveFixed(name)).ok();
        if (downloadResult == null) {
          emit(state.copyWith(isError: true, isLoading: false));
          return;
        }

        emit(
          state.copyWith(isLoading: false, dataExport: DataExportNameAndData(name, downloadResult)),
        );
      });
    });
    on<DeleteCurrentDataExport>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        final deleteResult = await api.commonAction((api) => api.deleteDataExport());
        if (deleteResult.isErr()) {
          emit(state.copyWith(isError: true, isLoading: false));
          return;
        }

        emit(DataExportData());
      });
    });
    on<SaveDataExport>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));

        try {
          await FlutterFileSaver().writeFileAsBytes(
            fileName: data.data.name,
            bytes: data.data.data,
          );
        } catch (_) {
          emit(state.copyWith(isLoading: false));
          return;
        }

        await api.commonAction((api) => api.deleteDataExport());

        emit(DataExportData());
      });
    });
  }
}
