import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/general/notification/state/like_received.dart";
import "package:pihka_frontend/utils.dart";

extension type BottomNavigationStateData(BottomNavigationScreenId screen) {}

abstract class BottomNavigationStateEvent {}

class ChangeScreen extends BottomNavigationStateEvent {
  final BottomNavigationScreenId value;
  ChangeScreen(this.value);
}
class BottomNavigationStateBloc extends Bloc<BottomNavigationStateEvent, BottomNavigationStateData> {
  BottomNavigationStateBloc._() : super(BottomNavigationStateData(BottomNavigationScreenId.profiles)) {
    on<ChangeScreen>((data, emit) {
      if (data.value == BottomNavigationScreenId.likes) {
        NotificationLikeReceived.getInstance().resetReceivedLikesCount();
      }
      emit(BottomNavigationStateData(data.value));
    });
  }
}

class BottomNavigationStateBlocInstance extends AppSingletonNoInit {
  static final _instance = BottomNavigationStateBlocInstance._();
  BottomNavigationStateBlocInstance._();
  factory BottomNavigationStateBlocInstance.getInstance() {
    return _instance;
  }

  final bloc = BottomNavigationStateBloc._();
}

enum BottomNavigationScreenId {
  profiles(0),
  likes(1),
  chats(2),
  settings(3);

  final int screenIndex;
  const BottomNavigationScreenId(this.screenIndex);
}
