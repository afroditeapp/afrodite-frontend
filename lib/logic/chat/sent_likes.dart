import "package:app/data/utils/repository_instances.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/data/chat_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/chat/sent_likes.dart";
import "package:app/ui_utils/snack_bar.dart";

sealed class SentLikesEvent {}

class BlockSentLikeProfile extends SentLikesEvent {
  final AccountId value;
  BlockSentLikeProfile(this.value);
}

class SentLikesBloc extends Bloc<SentLikesEvent, SentLikesData> {
  final ChatRepository chat;

  SentLikesBloc(RepositoryInstances r) : chat = r.chat, super(SentLikesData()) {
    on<BlockSentLikeProfile>((data, emit) async {
      if (state.blockOngoing) {
        showSnackBar(R.strings.sent_likes_screen_block_profile_in_progress);
        return;
      }

      emit(state.copyWith(blockOngoing: true));

      if (await chat.sendBlockTo(data.value)) {
        showSnackBar(R.strings.sent_likes_screen_block_profile_successful);
      } else {
        showSnackBar(R.strings.sent_likes_screen_block_profile_failed);
      }

      emit(state.copyWith(blockOngoing: false));
    });
  }
}
