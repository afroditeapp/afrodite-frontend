import "package:flutter_bloc/flutter_bloc.dart";

extension type BottomNavigationStateData(BottomNavigationScreenId screen) {}

abstract class BottomNavigationStateEvent {}

class ChangeScreen extends BottomNavigationStateEvent {
  final BottomNavigationScreenId value;
  ChangeScreen(this.value);
}
class BottomNavigationStateBloc extends Bloc<BottomNavigationStateEvent, BottomNavigationStateData> {
  BottomNavigationStateBloc() : super(BottomNavigationStateData(BottomNavigationScreenId.profiles)) {
    on<ChangeScreen>((data, emit) =>
      emit(BottomNavigationStateData(data.value)
    ));
  }
}

enum BottomNavigationScreenId {
  profiles(0),
  likes(1),
  chats(2),
  settings(3);

  final int screenIndex;
  const BottomNavigationScreenId(this.screenIndex);
}
