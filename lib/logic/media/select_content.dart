
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/model/freezed/logic/media/select_content.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/immutable_list.dart";
import "package:pihka_frontend/utils/result.dart";

final log = Logger("SelectContentBloc");

sealed class SelectContentEvent {}
class Reload extends SelectContentEvent {}

class SelectContentBloc extends Bloc<SelectContentEvent, SelectContentData> with ActionRunner {
  final MediaRepository media = MediaRepository.getInstance();
  final AccountRepository account = AccountRepository.getInstance();

  SelectContentBloc() : super(SelectContentData()) {
    on<Reload>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));
        final isInitialModerationOngoing = await account.isInitialModerationOngoing();
        final value = await media.loadAllContent().ok();
        final List<ContentId> allContent = [];
        if (value != null) {
          for (final content in value.data) {
            if (content.state == ContentState.moderatedAsAccepted ||
              (isInitialModerationOngoing && (content.state == ContentState.inSlot || content.state == ContentState.inModeration))) {
              allContent.add(content.id);
            }
          }
        }

        emit(state.copyWith(isLoading: false, availableContent: UnmodifiableList(allContent)));
      });
    });
  }
}
