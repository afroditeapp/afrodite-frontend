
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/model/freezed/logic/media/select_content.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/api.dart";
import "package:pihka_frontend/utils/immutable_list.dart";
import "package:pihka_frontend/utils/result.dart";

final log = Logger("SelectContentBloc");

sealed class SelectContentEvent {}
class ReloadAvailableContent extends SelectContentEvent {}

class SelectContentBloc extends Bloc<SelectContentEvent, SelectContentData> with ActionRunner {
  final MediaRepository media = MediaRepository.getInstance();
  final AccountRepository account = AccountRepository.getInstance();

  SelectContentBloc() : super(SelectContentData()) {
    on<ReloadAvailableContent>((data, emit) async {
      await runOnce(() async {
        // Reset to loading state
        emit(SelectContentData().copyWith(isLoading: true));

        final isInitialModerationOngoing = await account.isInitialModerationOngoing();
        final currentModerationRequest = await media.currentModerationRequestState();
        if (currentModerationRequest == null) {
          emit(state.copyWith(isLoading: false, isError: true));
          return;
        }
        final isModerationRequestOngoing = currentModerationRequest.isOngoing();
        final imgsInCurrentModerationRequest = currentModerationRequest.contentList();

        final value = await media.loadAllContent().ok();
        final List<ContentId> allContent = [];
        final List<ContentId> pendingModeration = [];
        if (value != null) {
          for (final content in value.data) {
            if (content.state == ContentState.moderatedAsAccepted ||
              // When initial moderation is ongoing the pending content can be edited
              (isInitialModerationOngoing && (content.state == ContentState.inSlot || content.state == ContentState.inModeration))) {
              allContent.add(content.id);
            }

            if (!isInitialModerationOngoing &&
              isModerationRequestOngoing &&
              imgsInCurrentModerationRequest.contains(content.id) &&
              (content.state == ContentState.inSlot || content.state == ContentState.inModeration)) {
              pendingModeration.add(content.id);
            }
          }
        }

        emit(state.copyWith(
          isLoading: false,
          initialModerationOngoing: isInitialModerationOngoing,
          showMakeNewModerationRequest: !isModerationRequestOngoing,
          availableContent: UnmodifiableList(allContent),
          pendingModeration: UnmodifiableList(pendingModeration),
        ));
      });
    });
  }
}
