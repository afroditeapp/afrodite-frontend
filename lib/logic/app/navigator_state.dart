import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/model/freezed/logic/main/navigator_state.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/immutable_list.dart";
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
class RemoveMultiplePages extends NavigatorStateEvent {
  final Iterable<PageKey> pageKeys;
  RemoveMultiplePages(this.pageKeys);
}
class PushPage extends NavigatorStateEvent {
  final PageAndChannel newPage;
  PushPage(this.newPage);
}
class ReplaceAllWith extends NavigatorStateEvent {
  final Page<Object?> page;
  ReplaceAllWith(this.page);
}

// NOTE: This bloc must be dependency free because of NavigationStateBlocInstance.
class NavigatorStateBloc extends Bloc<NavigatorStateEvent, NavigatorStateData> {
  NavigatorStateBloc._() : super(
    NavigatorStateData(
      pages: UnmodifiableList(PageAndChannel.splashScreen()),
    )
  ) {
    on<PushPage>((data, emit) {
      emit(state.copyWith(
        pages: UnmodifiableList([
          ...state.pages,
          data.newPage,
        ]),
      ));
    });
    on<PopPage>((data, emit) {
      final newPages = state.pages.toList();
      if (newPages.isNotEmpty) {
        final removed = newPages.removeLast();
        removed.channel.add(PagePopDone(data.pageReturnValue));
      }
      emit(state.copyWith(
        pages: UnmodifiableList(newPages),
      ));
    });
    on<RemovePage>((data, emit) {
      final newPages = <PageAndChannel>[];
      for (final p in state.pages) {
        if (p.key != data.pageKey) {
          newPages.add(p);
        } else {
          p.channel.add(PagePopDone(data.pageReturnValue));
        }
      }
      emit(state.copyWith(
        pages: UnmodifiableList(newPages),
      ));
    });
    on<RemoveMultiplePages>((data, emit) {
      final newPages = <PageAndChannel>[];
      for (final p in state.pages) {
        if (!data.pageKeys.contains(p.key)) {
          newPages.add(p);
        } else {
          p.channel.add(const PagePopDone(null));
        }
      }
      emit(state.copyWith(
        pages: UnmodifiableList(newPages),
      ));
    });
    on<ReplaceAllWith>((data, emit) {
      final currentPages = state.pages.toList();

      for (final p in currentPages.reversed) {
        p.channel.add(const PagePopDone(null));
      }

      emit(state.copyWith(
        pages: UnmodifiableList([
          PageAndChannel(
            PageKey(),
            data.page,
            BehaviorSubject.seeded(const WaitingPagePop()),
            null,
          ),
        ]),
      ));
    });
  }

  /// Push new page to the navigator stack and wait for it to be popped.
  Future<T?> push<T>(Page<T> page, {PageInfo? pageInfo}) async {
    final key = PageKey();
    return await pushWithKey(page, key, pageInfo: pageInfo);
  }

  /// Push new page to the navigator stack with specific key and wait for it to be popped.
  Future<T?> pushWithKey<T>(Page<T> page, PageKey pageKey, {PageInfo? pageInfo}) async {
    final returnChannel = BehaviorSubject<ReturnChannelValue>.seeded(const WaitingPagePop());
    final newPage = PageAndChannel(pageKey, page, returnChannel, pageInfo);
    add(PushPage(newPage));
    final popDone = await returnChannel.whereType<PagePopDone>().first;
    final returnValue = popDone.returnValue;
    if (returnValue is T?) {
      return returnValue;
    } else {
      return null;
    }
  }

  /// Pop all current pages and make new stack with the new page.
  void replaceAllWith<T>(Page<T> page) {
    add(ReplaceAllWith(page));
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
    return state.pages.isNotEmpty;
  }

  Future<T?> showDialog<T>(
    {
      required PageKey pageKey,
      required Widget Function(BuildContext) builder,
      bool barrierDismissable = true,
    }
  ) async {
    return await pushWithKey(
      MaterialDialogPage<T>(builder, barrierDismissable: barrierDismissable),
      pageKey,
    );
  }
}

class NavigationStateBlocInstance extends AppSingletonNoInit {
  static final _instance = NavigationStateBlocInstance._();
  NavigationStateBlocInstance._();
  factory NavigationStateBlocInstance.getInstance() {
    return _instance;
  }

  final bloc = NavigatorStateBloc._();
}

class MyNavigator {
  /// Push new page to the navigator stack and wait for it to be popped.
  static Future<T?> push<T>(BuildContext context, Page<T> page, {PageInfo? pageInfo}) async {
    return await context.read<NavigatorStateBloc>().push(page, pageInfo: pageInfo);
  }

  /// Push new page to the navigator stack with specific key and wait for it to be popped.
  static Future<T?> pushWithKey<T>(BuildContext context, Page<T> page, PageKey pageKey, {PageInfo? pageInfo}) async {
    return await context.read<NavigatorStateBloc>().pushWithKey(page, pageKey, pageInfo: pageInfo);
  }

  /// Pop all current pages and make new stack with the new page.
  static void replaceAllWith<T>(BuildContext context, Page<T> page) {
    context.read<NavigatorStateBloc>().replaceAllWith(page);
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

  static Future<T?> showDialog<T>(
    {
      required BuildContext context,
      required PageKey pageKey,
      required Widget Function(BuildContext) builder,
      bool barrierDismissable = true,
    }
  ) async {
    return await context.read<NavigatorStateBloc>().showDialog(
      pageKey: pageKey,
      builder: builder,
      barrierDismissable: barrierDismissable,
    );
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
