
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/model/freezed/logic/media/current_moderation_request.dart";
import "package:pihka_frontend/utils.dart";

final log = Logger("CurrentModerationRequestBloc");


sealed class CurrentModerationRequestEvent {}
class Reload extends CurrentModerationRequestEvent {}
class ReloadOnceConnected extends CurrentModerationRequestEvent {}


class CurrentModerationRequestBloc extends Bloc<CurrentModerationRequestEvent, CurrentModerationRequestData> with ActionRunner {
  final MediaRepository media = MediaRepository.getInstance();

  CurrentModerationRequestBloc() : super(CurrentModerationRequestData()) {
    on<Reload>((data, emit) async {
      await runOnce(() async {
        final value = await media.currentModerationRequestState();
        emit(state.copyWith(moderationRequest: value));
      });
    });
    on<ReloadOnceConnected>((data, emit) async {
      await runOnce(() async {
        await ApiManager.getInstance().state.firstWhere((element) => element == ApiManagerState.connected);
        final value = await media.currentModerationRequestState();
        emit(state.copyWith(moderationRequest: value));
      });
    });
  }
}
