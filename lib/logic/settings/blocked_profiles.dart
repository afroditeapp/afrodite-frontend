import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/chat_repository.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/settings/blocked_profiles.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";

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
