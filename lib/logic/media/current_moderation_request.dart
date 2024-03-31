
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/utils.dart";

part 'current_moderation_request.freezed.dart';

final log = Logger("CurrentModerationRequestBloc");

@freezed
class CurrentModerationRequestData with _$CurrentModerationRequestData {
  factory CurrentModerationRequestData({
    ModerationRequest? moderationRequest,
  }) = _CurrentModerationRequestData;
}

sealed class CurrentModerationRequestEvent {}
class Reload extends CurrentModerationRequestEvent {}

class CurrentModerationRequestBloc extends Bloc<CurrentModerationRequestEvent, CurrentModerationRequestData> with ActionRunner {
  final MediaRepository media = MediaRepository.getInstance();

  CurrentModerationRequestBloc() : super(CurrentModerationRequestData()) {
    on<Reload>((data, emit) async {
      await runOnce(() async {
        final value = await media.currentModerationRequestState();
        emit(state.copyWith(moderationRequest: value));
      });
    });
  }
}
