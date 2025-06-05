import "dart:async";

import "package:app/database/database_manager.dart";
import "package:flutter_bloc/flutter_bloc.dart";

extension type InfoDialogData(bool chatInfoDialogShown) {}

abstract class InfoDialogEvent {}

class NewChatInfoDialogShownValue extends InfoDialogEvent {
  final bool value;
  NewChatInfoDialogShownValue(this.value);
}
class MarkChatInfoDialogShown extends InfoDialogEvent {}

class InfoDialogBloc extends Bloc<InfoDialogEvent, InfoDialogData> {
  final commonDb = DatabaseManager.getInstance();
  StreamSubscription<bool?>? _chatInfoDialogShownSubscription;

  InfoDialogBloc() : super(InfoDialogData(false)) {
    on<NewChatInfoDialogShownValue>((data, emit) =>
      emit(InfoDialogData(data.value)
    ));
    on<MarkChatInfoDialogShown>((_, emit) async {
      await commonDb.commonAction((db) => db.updateChatInfoDialogShown(true));
    });

    _chatInfoDialogShownSubscription = commonDb.commonStream((db) => db.watchChatInfoDialogShown()).listen((state) {
      add(NewChatInfoDialogShownValue(state ?? false));
    });
  }

  @override
  Future<void> close() async {
    await _chatInfoDialogShownSubscription?.cancel();
    await super.close();
  }
}
