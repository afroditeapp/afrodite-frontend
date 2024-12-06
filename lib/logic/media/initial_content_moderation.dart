
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/media_repository.dart";
import "package:app/model/freezed/logic/media/initial_content_moderation.dart";
import "package:app/utils.dart";
import "package:app/utils/result.dart";

sealed class CurrentModerationRequestEvent {}
class Reload extends CurrentModerationRequestEvent {}
class ReloadOnceConnected extends CurrentModerationRequestEvent {}

// TODO: Remove?
class InitialContentModerationBloc extends Bloc<CurrentModerationRequestEvent, InitialContentModerationData> with ActionRunner {
  final MediaRepository media = LoginRepository.getInstance().repositories.media;
  final ApiManager api = LoginRepository.getInstance().repositories.api;
  final ServerConnectionManager connectionManager = LoginRepository.getInstance().repositories.connectionManager;

  InitialContentModerationBloc() : super(InitialContentModerationData()) {
    on<Reload>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));
        await reload(emit);
      });
    });
    on<ReloadOnceConnected>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(isLoading: true));
        await connectionManager.state.firstWhere((element) => element == ApiManagerState.connected);
        await reload(emit);
      });
    });
  }

  Future<void> reload(Emitter<InitialContentModerationData> emit) async {
    final value = await api.media((api) => api.postGetInitialContentModerationCompleted());

    switch (value) {
      case Ok(:final v):
        emit(state.copyWith(
          accepted: v.accepted,
          isLoading: false
        ));
      case Err():
        emit(state.copyWith(
          isLoading: false,
          isError: true
        ));
    }
  }
}
