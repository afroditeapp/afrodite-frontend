import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:rxdart/rxdart.dart";

extension type LikeGridInstanceManagerData(int currentlyVisibleId) {}

abstract class LikeGridInstanceMangerEvent {}

class NewId extends LikeGridInstanceMangerEvent {
  final int index;
  NewId(this.index);
}
class LikeGridInstanceManagerBloc extends Bloc<LikeGridInstanceMangerEvent, LikeGridInstanceManagerData> {
  final BehaviorSubject<int> _currentlyVisibleId = BehaviorSubject.seeded(0);

  LikeGridInstanceManagerBloc() : super(LikeGridInstanceManagerData(0)) {
    on<NewId>((data, emit) {
      emit(LikeGridInstanceManagerData(data.index));
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
}
