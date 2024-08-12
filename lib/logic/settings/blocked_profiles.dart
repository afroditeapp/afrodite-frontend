import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/settings/blocked_profiles.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

sealed class BlockedProfilesEvent {}
class UnblockProfile extends BlockedProfilesEvent {
  final AccountId value;
  UnblockProfile(this.value);
}

class BlockedProfilesBloc extends Bloc<BlockedProfilesEvent, BlockedProfilesData> with ActionRunner {
  final ChatRepository chat = LoginRepository.getInstance().repositories.chat;

  BlockedProfilesBloc() : super(BlockedProfilesData()) {
    on<UnblockProfile>((data, emit) async {
      if (state.unblockOngoing) {
        showSnackBar(R.strings.blocked_profiles_screen_unblock_profile_in_progress);
        return;
      }

      emit(state.copyWith(
        unblockOngoing: true,
      ));

      if (await chat.removeBlockFrom(data.value)) {
        showSnackBar(R.strings.blocked_profiles_screen_unblock_profile_successful);
      } else {
        showSnackBar(R.strings.blocked_profiles_screen_unblock_profile_failed);
      }

      emit(state.copyWith(
        unblockOngoing: false,
      ));
    });
  }
}
