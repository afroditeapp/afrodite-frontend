
import "package:app/utils/option.dart";
import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/data/account_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/model/freezed/logic/media/select_content.dart";
import "package:app/utils.dart";
import "package:app/utils/api.dart";
import "package:app/utils/immutable_list.dart";
import "package:app/utils/result.dart";

final log = Logger("SelectContentBloc");

sealed class SelectContentEvent {}
class ReloadAvailableContent extends SelectContentEvent {}
class NewModerationRequest extends SelectContentEvent {
  final List<ContentId> content;
  NewModerationRequest(this.content);
}

class SelectContentBloc extends Bloc<SelectContentEvent, SelectContentData> with ActionRunner {
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final AccountRepository account = LoginRepository.getInstance().repositories.account;

  SelectContentBloc() : super(SelectContentData()) {
    on<ReloadAvailableContent>((data, emit) async {
      await runOnce(() async {
        await reload(emit);
      });
    });
    // on<NewModerationRequest>((data, emit) async {
    //   await runOnce(() async {
    //     emit(SelectContentData().copyWith(isLoading: true));
    //     final result = await media.createNewModerationRequest(data.content);
    //     switch (result) {
    //       case Ok():
    //         await reload(emit);
    //       case Err():
    //         emit(SelectContentData().copyWith(isLoading: false, isError: true));
    //     }
    //   });
    // });
  }

  Future<void> reload(Emitter<SelectContentData> emit) async {
    // Reset to loading state
    emit(SelectContentData().copyWith(isLoading: true));

    final value = await media.loadAllContent().ok();
    if (value == null) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
      ));
      return;
    }

    final allContentIterator = value.data.map((v) {
      return MyContent(
        v.cid,
        v.fd,
        v.state,
        null,
        null,
      );
    });
    final allContentList = UnmodifiableList(allContentIterator);

    emit(state.copyWith(
      isLoading: false,
      maxContent: value.maxContentCount,
      showAddNewContent: value.data.length < value.maxContentCount,
      availableContent: allContentList,
    ));
  }
}
