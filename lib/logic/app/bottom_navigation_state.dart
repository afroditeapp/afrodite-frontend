import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/general/notification/state/like_received.dart";
import "package:pihka_frontend/model/freezed/logic/main/bottom_navigation_state.dart";
import "package:pihka_frontend/utils.dart";


abstract class BottomNavigationStateEvent {}

class ChangeScreen extends BottomNavigationStateEvent {
  final BottomNavigationScreenId value;
  final bool resetIsScrolledValues;
  ChangeScreen(this.value, {this.resetIsScrolledValues = false});
}
class SetIsScrolledValue extends BottomNavigationStateEvent {
  final BottomNavigationScreenId screen;
  final bool value;
  SetIsScrolledValue(this.screen, this.value);
}
class BottomNavigationStateBloc extends Bloc<BottomNavigationStateEvent, BottomNavigationStateData> {
  BottomNavigationStateBloc._() : super(BottomNavigationStateData()) {
    on<ChangeScreen>((data, emit) {
      if (data.value == BottomNavigationScreenId.likes) {
        NotificationLikeReceived.getInstance().resetReceivedLikesCount();
      }
      if (data.resetIsScrolledValues) {
        emit(state.copyWith(
          screen: data.value,
          isScrolledProfile: false,
          isScrolledLikes: false,
          isScrolledChats: false,
          isScrolledSettings: false,
        ));
      } else {
        emit(state.copyWith(screen: data.value));
      }
    });
    on<SetIsScrolledValue>((data, emit) {
      switch (data.screen) {
        case BottomNavigationScreenId.profiles:
          emit(state.copyWith(isScrolledProfile: data.value));
          break;
        case BottomNavigationScreenId.likes:
          emit(state.copyWith(isScrolledLikes: data.value));
          break;
        case BottomNavigationScreenId.chats:
          emit(state.copyWith(isScrolledChats: data.value));
          break;
        case BottomNavigationScreenId.settings:
          emit(state.copyWith(isScrolledSettings: data.value));
          break;
      }
    });
  }

  void updateIsScrolled(
    bool isScrolled,
    BottomNavigationScreenId screen,
    bool Function(BottomNavigationStateData) currentIsScrolledGetter,
  ) {
    final currentIsScrolled = currentIsScrolledGetter(state);
    if (isScrolled != currentIsScrolled) {
      add(SetIsScrolledValue(screen, isScrolled));
    }
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
