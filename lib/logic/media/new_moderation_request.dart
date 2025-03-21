
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:app/model/freezed/logic/media/new_moderation_request.dart";
import "package:app/utils.dart";

final log = Logger("NewModerationRequestBloc");


sealed class NewModerationRequestEvent {}
class RemoveImg extends NewModerationRequestEvent {
  final int index;
  RemoveImg(this.index);
}
class AddImg extends NewModerationRequestEvent {
  final int slot;
  final ContentId img;
  final bool faceDetected;
  AddImg(this.slot, this.img, this.faceDetected);
}
class Reset extends NewModerationRequestEvent {}

class NewModerationRequestBloc extends Bloc<NewModerationRequestEvent, NewModerationRequestData> with ActionRunner {
  NewModerationRequestBloc() : super(NewModerationRequestData()) {
    on<Reset>((data, emit) async {
      emit(NewModerationRequestData());
    });
    on<RemoveImg>((data, emit) async {
      emit(state.copyWith(selectedImgs: state.selectedImgs.removeAt(data.index)));
    });
    on<AddImg>((data, emit) async {
      emit(state.copyWith(selectedImgs: state.selectedImgs.add(data.slot, data.img, data.faceDetected)));
    });
  }
}
