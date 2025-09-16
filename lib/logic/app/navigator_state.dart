import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/ui_utils/consts/animation.dart";
import 'package:utils/utils.dart';
import "package:app/utils/immutable_list.dart";
import "package:rxdart/rxdart.dart";

abstract class NavigatorStateEvent {}

class PopPage extends NavigatorStateEvent {
  final Object? pageReturnValue;
  PopPage(this.pageReturnValue);
}

class RemovePage extends NavigatorStateEvent {
  final PageKey pageKey;
  final Object? pageReturnValue;
  RemovePage(this.pageKey, this.pageReturnValue);
}

class RemovePageUsingFlutterObject extends NavigatorStateEvent {
  final Page<Object?> page;
  RemovePageUsingFlutterObject(this.page);
}

class RemoveMultiplePages extends NavigatorStateEvent {
  final Iterable<PageKey> pageKeys;
  RemoveMultiplePages(this.pageKeys);
}

class PushPage extends NavigatorStateEvent {
  final MyPage<Object> newPage;
  PushPage(this.newPage);
}

class PopUntilLenghtIs extends NavigatorStateEvent {
  final int wantedLenght;
  PopUntilLenghtIs(this.wantedLenght);

  final BehaviorSubject<bool> completed = BehaviorSubject.seeded(false);

  /// Can be called only once
  Future<void> waitCompletionAndDispose() async {
    await completed.where((v) => v).first;
    await completed.close();
  }
}

class NavigatorStateBloc extends Bloc<NavigatorStateEvent, NavigatorStateData> {
  NavigatorStateBloc(super.initialState) {
    on<PushPage>((data, emit) {
      emit(state.copyWith(pages: UnmodifiableList([...state.pages, data.newPage])));
    });
    on<PopPage>((data, emit) {
      final newPages = state.pages.toList();
      if (state.pages.length > 1) {
        final removed = newPages.removeLast();
        removed.completer.complete(data.pageReturnValue);
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages)));
    });
    on<RemovePage>((data, emit) {
      final newPages = <MyPage<Object>>[];
      for (final p in state.pages) {
        if (p.key != data.pageKey) {
          newPages.add(p);
        } else {
          p.completer.complete(data.pageReturnValue);
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages)));
    });
    on<RemovePageUsingFlutterObject>((data, emit) {
      final newPages = <MyPage<Object>>[];
      for (final p in state.pages) {
        if (p.page != data.page) {
          newPages.add(p);
        } else {
          p.completer.complete(null);
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages)));
    });
    on<RemoveMultiplePages>((data, emit) {
      final newPages = <MyPage<Object>>[];
      for (final p in state.pages) {
        if (!data.pageKeys.contains(p.key)) {
          newPages.add(p);
        } else {
          p.completer.complete(null);
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages)));
    });
    on<PopUntilLenghtIs>((data, emit) {
      if (data.wantedLenght < 1) {
        return;
      }

      final newPages = <MyPage<Object>>[];
      for (final (i, p) in state.pages.indexed) {
        if (i < data.wantedLenght) {
          newPages.add(p);
        } else {
          p.completer.complete(null);
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages)));
      data.completed.add(true);
    });
  }

  /// Push new page to the navigator stack and wait for it to be popped.
  Future<T?> push<T extends Object>(MyScreenPage<T> page) async {
    final completer = page.completer;
    add(PushPage(page));
    return await completer.future;
  }

  Future<T?> pushLimited<T extends Object>(MyScreenPageLimited<T> page) async {
    final completer = page.completer;
    add(PushPage(page));
    return await completer.future;
  }

  /// Pops the top page from the navigator stack if possible.
  @optionalTypeArgs
  void pop<T>([T? popValue]) {
    add(PopPage(popValue));
  }

  /// Remove page with specific key from the navigator stack if possible.
  @optionalTypeArgs
  void removePage<T>(PageKey pageKey, [T? pageReturnValue]) {
    add(RemovePage(pageKey, pageReturnValue));
  }

  void removeMultiplePages(Iterable<PageKey> pageKeys) {
    add(RemoveMultiplePages(pageKeys));
  }

  /// Returns true if there is more than one page in the navigator stack.
  bool canPop() {
    return state.pages.length > 1;
  }

  Future<T?> showDialog<T extends Object>({required MyDialogPage<T> page}) async {
    final completer = page.completer;
    add(PushPage(page));
    return await completer.future;
  }

  Future<T?> removeAndShowDialog<T extends Object>({
    required PageKey toBeRemoved,
    required MyDialogPage<T> page,
  }) async {
    removePage(toBeRemoved);
    if (!WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations) {
      await Future<void>.delayed(const Duration(milliseconds: WAIT_BETWEEN_DIALOGS_MILLISECONDS));
    }
    return await showDialog(page: page);
  }

  Future<T?> showFullScreenDialog<T extends Object>({
    required MyFullScreenDialogPage<T> page,
  }) async {
    final completer = page.completer;
    add(PushPage(page));
    return await completer.future;
  }
}

class NavigationStateBlocInstance extends AppSingletonNoInit {
  static final _instance = NavigationStateBlocInstance._();
  NavigationStateBlocInstance._();
  factory NavigationStateBlocInstance.getInstance() {
    return _instance;
  }

  final BehaviorSubject<NavigatorStateBloc?> _latestBloc = BehaviorSubject.seeded(null);

  Stream<NavigatorStateData> get navigationStateStream => _latestBloc.switchMap((b) {
    return b != null
        ? b.stream.startWith(b.state)
        : Stream.value(NavigatorStateData.defaultValue());
  });

  NavigatorStateData get navigationState =>
      _latestBloc.value?.state ?? NavigatorStateData.defaultValue();

  void setLatestBloc(NavigatorStateBloc newBloc) {
    if (_latestBloc.value != newBloc) {
      _latestBloc.add(newBloc);
    }
  }
}

class MyNavigator {
  /// Push new page to the navigator stack and wait for it to be popped.
  static Future<T?> push<T extends Object>(BuildContext context, MyScreenPage<T> page) async {
    return await context.read<NavigatorStateBloc>().push(page);
  }

  static Future<T?> pushLimited<T extends Object>(
    BuildContext context,
    MyScreenPageLimited<T> page,
  ) async {
    return await context.read<NavigatorStateBloc>().pushLimited(page);
  }

  /// Pops the top page from the navigator stack if possible.
  @optionalTypeArgs
  static void pop<T>(BuildContext context, [T? popValue]) {
    context.read<NavigatorStateBloc>().pop(popValue);
  }

  /// Remove page with specific key from the navigator stack if possible.
  @optionalTypeArgs
  static void removePage<T>(BuildContext context, PageKey pageKey, [T? pageReturnValue]) {
    context.read<NavigatorStateBloc>().removePage(pageKey, pageReturnValue);
  }

  static void removeMultiplePages(BuildContext context, Iterable<PageKey> pageKeys) {
    context.read<NavigatorStateBloc>().removeMultiplePages(pageKeys);
  }

  /// Returns true if there is more than one page in the navigator stack.
  static bool canPop(BuildContext context) {
    return context.read<NavigatorStateBloc>().canPop();
  }

  static Future<T?> showDialog<T extends Object>({
    required BuildContext context,
    required MyDialogPage<T> page,
  }) async {
    return await context.read<NavigatorStateBloc>().showDialog(page: page);
  }

  static Future<T?> removeAndShowDialog<T extends Object>({
    required BuildContext context,
    required PageKey toBeRemoved,
    required MyDialogPage<T> page,
  }) async {
    return await context.read<NavigatorStateBloc>().removeAndShowDialog(
      toBeRemoved: toBeRemoved,
      page: page,
    );
  }

  static Future<T?> showFullScreenDialog<T extends Object>({
    required BuildContext context,
    required MyFullScreenDialogPage<T> page,
  }) async {
    return await context.read<NavigatorStateBloc>().showFullScreenDialog(page: page);
  }
}

class MaterialDialogPage<T> extends Page<T> {
  final Widget Function(BuildContext) builder;
  final bool barrierDismissable;
  MaterialDialogPage(this.builder, {this.barrierDismissable = true}) : super(key: PageKey());

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      settings: this,
      context: context,
      barrierDismissible: barrierDismissable,
      builder: (context) => builder(context),
    );
  }
}
