import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/logic/chat/conversation_bloc.dart";
import "package:pihka_frontend/model/freezed/logic/chat/message_renderer_bloc.dart";
import "package:pihka_frontend/utils/immutable_list.dart";

var log = Logger("MessageRendererBloc");

sealed class MessageRendererEvent {}
class RenderMessages extends MessageRendererEvent {
  final MessageListUpdate messages;
  RenderMessages(this.messages);
}
class RenderingCompleted extends MessageRendererEvent {
  final double height;
  RenderingCompleted(this.height);
}

class MessageRendererBloc extends Bloc<MessageRendererEvent, MessageRendererData> {
  MessageRendererBloc() :
    super(MessageRendererData()) {

    on<RenderMessages>((data, emit) {
      final newMessages = state.toBeRendered.addAll(data.messages.onlyNewMessages.messages);
      final nextToBeRendered = newMessages.firstOrNull;
      if (state.currentlyRendering == null && nextToBeRendered != null) {
        emit(state.copyWith(
          completed: false,
          totalHeight: 0.0,
          currentlyRendering: nextToBeRendered,
          toBeRendered: newMessages.removeAt(0),
        ));
      } else {
        emit(state.copyWith(
          completed: false,
          totalHeight: 0.0,
          toBeRendered: newMessages,
        ));
      }
    });
    on<RenderingCompleted>((data, emit) {
      final nextToBeRendered = state.toBeRendered.firstOrNull;
      final UnmodifiableList<MessageEntry> nextList;
      final bool completed;
      if (nextToBeRendered == null) {
        completed = true;
        nextList = const UnmodifiableList<MessageEntry>.empty();
      } else {
        completed = false;
        nextList = state.toBeRendered.removeAt(0);
      }
      emit(state.copyWith(
        completed: completed,
        totalHeight: state.totalHeight + data.height,
        currentlyRendering: nextToBeRendered,
        toBeRendered: nextList,
      ));
    });
  }
}
