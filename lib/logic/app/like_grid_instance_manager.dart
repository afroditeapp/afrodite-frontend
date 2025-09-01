import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:rxdart/rxdart.dart";

typedef LikeGridInstanceManagerData = ({int currentlyVisibleId, bool visible});

abstract class LikeGridInstanceMangerEvent {}

class NewId extends LikeGridInstanceMangerEvent {
  final int index;
  NewId(this.index);
}

class SetVisible extends LikeGridInstanceMangerEvent {
  final int index;
  SetVisible(this.index);
}

class LikeGridInstanceManagerBloc
    extends Bloc<LikeGridInstanceMangerEvent, LikeGridInstanceManagerData> {
  final BehaviorSubject<int> _currentlyVisibleId = BehaviorSubject.seeded(0);

  LikeGridInstanceManagerBloc() : super((currentlyVisibleId: 0, visible: false)) {
    on<NewId>((data, emit) {
      emit((currentlyVisibleId: data.index, visible: false));
    });
    on<SetVisible>((data, emit) {
      if (state.currentlyVisibleId == data.index) {
        emit((currentlyVisibleId: state.currentlyVisibleId, visible: true));
      }
    });

    _currentlyVisibleId.listen((value) {
      add(NewId(value));
    });
  }

  int newId() {
    final id = _currentlyVisibleId.value + 1;
    _currentlyVisibleId.add(id);
    return id;
  }

  int popId() {
    final id = _currentlyVisibleId.value - 1;
    _currentlyVisibleId.add(max(0, id));
    return id;
  }

  @override
  Future<void> close() async {
    await _currentlyVisibleId.close();
    await super.close();
  }
}
