
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
        // await reload(emit);
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

//   Future<void> reload(Emitter<SelectContentData> emit) async {
//     // Reset to loading state
//     emit(SelectContentData().copyWith(isLoading: true));

//     final isInitialModerationOngoing = await account.isInitialModerationOngoing();
//     final bool isModerationRequestOngoing;
//     final List<ContentId> imgsInCurrentModerationRequest;
//     switch (await media.currentModerationRequestState()) {
//       case Ok(:final v):
//         if (v == null) {
//           isModerationRequestOngoing = false;
//           imgsInCurrentModerationRequest = [];
//         } else {
//           isModerationRequestOngoing = v.isOngoing();
//           imgsInCurrentModerationRequest = v.contentList();
//         }
//       case Err():
//         emit(state.copyWith(isLoading: false, isError: true));
//         return;
//     }

//     final value = await media.loadAllContent().ok();
//     final List<ContentIdAndFaceDetected> allContent = [];
//     final List<ContentIdAndFaceDetected> pendingModeration = [];
//     if (value != null) {
//       for (final content in value.data) {
//         if (content.state == ContentState.moderatedAsAccepted ||
//           // When initial moderation is ongoing the pending content can be edited
//           (isInitialModerationOngoing && (content.state == ContentState.inSlot || content.state == ContentState.inModeration))) {
//           allContent.add(ContentIdAndFaceDetected(content.cid, content.fd));
//         }

//         if (!isInitialModerationOngoing &&
//           isModerationRequestOngoing &&
//           imgsInCurrentModerationRequest.contains(content.cid) &&
//           (content.state == ContentState.inSlot || content.state == ContentState.inModeration)) {
//           pendingModeration.add(ContentIdAndFaceDetected(content.cid, content.fd));
//         }
//       }
//     }

//     emit(state.copyWith(
//       isLoading: false,
//       initialModerationOngoing: isInitialModerationOngoing,
//       showMakeNewModerationRequest: !isModerationRequestOngoing,
//       availableContent: UnmodifiableList(allContent),
//       pendingModeration: UnmodifiableList(pendingModeration),
//     ));
//   }
}
