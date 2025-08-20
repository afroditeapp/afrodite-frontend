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
  final PageAndChannel newPage;
  PushPage(this.newPage);
}

class ReplaceAllWith extends NavigatorStateEvent {
  final List<NewPageDetails> pageList;
  final bool disableAnimation;
  ReplaceAllWith(this.pageList, this.disableAnimation);

  NavigatorStateData toInitialState() {
    return NavigatorStateData(
      pages: UnmodifiableList(
        pageList.map((newPageDetails) {
          return PageAndChannel(
            newPageDetails.pageKey ?? PageKey(),
            newPageDetails.page,
            BehaviorSubject.seeded(const WaitingPagePop()),
            newPageDetails.pageInfo,
          );
        }),
      ),
      disableAnimation: disableAnimation,
    );
  }
}

class ReplaceSinglePage extends NavigatorStateEvent {
  final PageKey existingPage;
  final PageAndChannel newPage;
  ReplaceSinglePage(this.existingPage, this.newPage);
}

class NavigatorStateBloc extends Bloc<NavigatorStateEvent, NavigatorStateData> {
  NavigatorStateBloc(super.initialState) {
    on<PushPage>((data, emit) {
      emit(
        state.copyWith(
          pages: UnmodifiableList([...state.pages, data.newPage]),
          disableAnimation: false,
        ),
      );
    });
    on<PopPage>((data, emit) {
      final newPages = state.pages.toList();
      if (state.pages.length > 1) {
        final removed = newPages.removeLast();
        removed.channel.add(PagePopDone(data.pageReturnValue));
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages), disableAnimation: false));
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
      emit(state.copyWith(pages: UnmodifiableList(newPages), disableAnimation: false));
    });
    on<RemovePageUsingFlutterObject>((data, emit) {
      final newPages = <PageAndChannel>[];
      for (final p in state.pages) {
        if (p.page != data.page) {
          newPages.add(p);
        } else {
          p.channel.add(const PagePopDone(null));
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages), disableAnimation: false));
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
      emit(state.copyWith(pages: UnmodifiableList(newPages), disableAnimation: false));
    });
    on<ReplaceAllWith>((data, emit) {
      final currentPages = state.pages.toList();

      for (final p in currentPages.reversed) {
        p.channel.add(const PagePopDone(null));
      }

      emit(
        state.copyWith(
          pages: UnmodifiableList(
            data.pageList.map((newPageDetails) {
              return PageAndChannel(
                newPageDetails.pageKey ?? PageKey(),
                newPageDetails.page,
                BehaviorSubject.seeded(const WaitingPagePop()),
                newPageDetails.pageInfo,
              );
            }),
          ),
          disableAnimation: data.disableAnimation,
        ),
      );
    });
    on<ReplaceSinglePage>((data, emit) {
      final newPages = <PageAndChannel>[];
      for (final p in state.pages) {
        if (p.key != data.existingPage) {
          newPages.add(p);
        } else {
          p.channel.add(const PagePopDone(null));
          newPages.add(data.newPage);
        }
      }
      emit(state.copyWith(pages: UnmodifiableList(newPages), disableAnimation: false));
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

  /// Pop all current pages and make new stack with the new page list.
  void replaceAllWith(List<NewPageDetails> page, {bool disableAnimation = false}) {
    add(ReplaceAllWith(page, disableAnimation));
  }

  Future<T?> replaceSinglePage<T>(
    PageKey existingPage,
    Page<T> page,
    PageKey pageKey, {
    PageInfo? pageInfo,
  }) async {
    final returnChannel = BehaviorSubject<ReturnChannelValue>.seeded(const WaitingPagePop());
    final newPage = PageAndChannel(pageKey, page, returnChannel, pageInfo);
    add(ReplaceSinglePage(existingPage, newPage));
    final popDone = await returnChannel.whereType<PagePopDone>().first;
    final returnValue = popDone.returnValue;
    if (returnValue is T?) {
      return returnValue;
    } else {
      return null;
    }
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

  Future<T?> showDialog<T>({
    required PageKey pageKey,
    required Widget Function(BuildContext) builder,
    bool barrierDismissable = true,
  }) async {
    return await pushWithKey(
      MaterialDialogPage<T>(builder, barrierDismissable: barrierDismissable),
      pageKey,
    );
  }

  Future<T?> removeAndShowDialog<T>({
    required PageKey existingPageKey,
    required PageKey newPageKey,
    required Widget Function(BuildContext) builder,
    bool barrierDismissable = true,
  }) async {
    removePage(existingPageKey);
    if (!WidgetsBinding.instance.platformDispatcher.accessibilityFeatures.disableAnimations) {
      await Future<void>.delayed(const Duration(milliseconds: WAIT_BETWEEN_DIALOGS_MILLISECONDS));
    }
    return await pushWithKey(
      MaterialDialogPage<T>(builder, barrierDismissable: barrierDismissable),
      newPageKey,
    );
  }
}

class NavigationStateBlocInstance extends AppSingletonNoInit {
  static final _instance = NavigationStateBlocInstance._();
  NavigationStateBlocInstance._();
  factory NavigationStateBlocInstance.getInstance() {
    return _instance;
  }

  final BehaviorSubject<NavigatorStateBloc> _latestBloc = BehaviorSubject.seeded(
    NavigatorStateBloc(NavigatorStateData.defaultValue()),
  );

  Stream<NavigatorStateData> get navigationStateStream => _latestBloc.switchMap((b) {
    return b.stream;
  });

  NavigatorStateData get navigationState => _latestBloc.value.state;

  void setLatestBloc(NavigatorStateBloc newBloc) {
    if (_latestBloc.value != newBloc) {
      _latestBloc.add(newBloc);
    }
  }
}

class MyNavigator {
  /// Push new page to the navigator stack and wait for it to be popped.
  static Future<T?> push<T>(BuildContext context, Page<T> page, {PageInfo? pageInfo}) async {
    return await context.read<NavigatorStateBloc>().push(page, pageInfo: pageInfo);
  }

  /// Push new page to the navigator stack with specific key and wait for it to be popped.
  static Future<T?> pushWithKey<T>(
    BuildContext context,
    Page<T> page,
    PageKey pageKey, {
    PageInfo? pageInfo,
  }) async {
    return await context.read<NavigatorStateBloc>().pushWithKey(page, pageKey, pageInfo: pageInfo);
  }

  /// Pop all current pages and make new stack with the new page list.
  static void replaceAllWith(BuildContext context, List<NewPageDetails> page) {
    context.read<NavigatorStateBloc>().replaceAllWith(page);
  }

  static Future<T?> replaceSinglePage<T>(
    BuildContext context,
    PageKey existingPage,
    Page<T> page,
    PageKey pageKey, {
    PageInfo? pageInfo,
  }) async {
    return await context.read<NavigatorStateBloc>().replaceSinglePage(
      existingPage,
      page,
      pageKey,
      pageInfo: pageInfo,
    );
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

  static Future<T?> showDialog<T>({
    required BuildContext context,
    required PageKey pageKey,
    required Widget Function(BuildContext) builder,
    bool barrierDismissable = true,
  }) async {
    return await context.read<NavigatorStateBloc>().showDialog(
      pageKey: pageKey,
      builder: builder,
      barrierDismissable: barrierDismissable,
    );
  }

  static Future<T?> removeAndShowDialog<T>({
    required BuildContext context,
    required PageKey existingPageKey,
    required PageKey newPageKey,
    required Widget Function(BuildContext) builder,
    bool barrierDismissable = true,
  }) async {
    return await context.read<NavigatorStateBloc>().removeAndShowDialog(
      existingPageKey: existingPageKey,
      newPageKey: newPageKey,
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

class NewPageDetails {
  final Page<Object?> page;
  final PageKey? pageKey;
  final PageInfo? pageInfo;
  NewPageDetails(this.page, {this.pageKey, this.pageInfo});
}
