import "package:app/api/server_connection_manager.dart";
import "package:app/data/utils/repository_instances.dart";
import "package:app/localizations.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/media/select_content.dart";
import "package:app/utils.dart";
import "package:app/utils/immutable_list.dart";
import "package:app/utils/result.dart";
import "package:openapi/api.dart";

sealed class SelectContentEvent {}

class ReloadAvailableContent extends SelectContentEvent {}

class DeleteContent extends SelectContentEvent {
  final AccountId account;
  final ContentId content;
  DeleteContent(this.account, this.content);
}

class SelectContentBloc extends Bloc<SelectContentEvent, SelectContentData> with ActionRunner {
  final ApiManager api;
  final AccountId currentUser;

  SelectContentBloc(RepositoryInstances r)
    : api = r.api,
      currentUser = r.accountId,
      super(SelectContentData()) {
    on<ReloadAvailableContent>((data, emit) async {
      await runOnce(() async {
        await reload(emit, true);
      });
    });
    on<DeleteContent>((data, emit) async {
      await runOnce(() async {
        final value = await api.mediaAction(
          (api) => api.deleteContent(data.account.aid, data.content.cid),
        );
        if (value.isErr()) {
          showSnackBar(R.strings.generic_error_occurred);
        }
        await reload(emit, false);
      });
    });
  }

  Future<void> reload(Emitter<SelectContentData> emit, bool stateResetAndShowLoadingState) async {
    if (stateResetAndShowLoadingState) {
      // Reset to loading state
      emit(SelectContentData().copyWith(isLoading: true));
    }

    final value = await api.media((api) => api.getAllAccountMediaContent(currentUser.aid)).ok();
    if (value == null) {
      emit(state.copyWith(isLoading: false, isError: true));
      return;
    }

    final allContentList = UnmodifiableList(value.data);

    emit(
      state.copyWith(
        isLoading: false,
        maxContent: value.maxContentCount,
        accountContent: value,
        showAddNewContent: value.data.length < value.maxContentCount,
        availableContent: allContentList,
      ),
    );
  }
}
