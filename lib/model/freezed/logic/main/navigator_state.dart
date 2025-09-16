import 'dart:async';

import 'package:app/logic/app/navigator_state.dart';
import 'package:flutter/material.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:app/utils/immutable_list.dart';

part 'navigator_state.freezed.dart';

@freezed
class NavigatorStateData with _$NavigatorStateData {
  NavigatorStateData._();
  factory NavigatorStateData({required UnmodifiableList<MyPage<Object>> pages}) =
      _NavigatorStateData;

  List<Page<Object?>> getPages() {
    return pages.map((e) => e.page).toList();
  }

  static NavigatorStateData defaultValue() {
    return rootPage(SplashPage());
  }

  static NavigatorStateData rootPage(MyPage<Object> page) {
    return NavigatorStateData(pages: UnmodifiableList([page]));
  }

  static NavigatorStateData rootPageAndOtherPage(MyPage<Object> first, MyPage<Object> second) {
    return NavigatorStateData(pages: UnmodifiableList([first, second]));
  }
}

abstract class MyPage<T> {
  PageKey get key;
  Page<T> get page;
  Completer<T?> get completer;
  PageInfo? get pageInfo;
}

abstract class MyScreenPage<T> extends MyPage<T> {
  final PageKey _key;
  final Page<T> _page;
  final Completer<T?> _completer;
  final PageInfo? _pageInfo;

  MyScreenPage({PageKey? key, required Widget child, Completer<T?>? completer, PageInfo? pageInfo})
    : _key = key ?? PageKey(),
      _page = MaterialPage<T>(child: child),
      _completer = completer ?? Completer(),
      _pageInfo = pageInfo;

  @override
  PageKey get key => _key;
  @override
  Page<T> get page => _page;
  @override
  Completer<T?> get completer => _completer;
  @override
  PageInfo? get pageInfo => _pageInfo;
}

/// Creating page using URL is not supported
abstract class MyScreenPageLimited<T> extends MyPage<T> {
  final _MyScreenPageLimitedImpl<T> _impl;
  MyScreenPageLimited({required Widget Function(PageCloser<T>) builder})
    : _impl = _MyScreenPageLimitedImpl(builder: builder, closer: PageCloser(PageKey()));
  @override
  PageKey get key => _impl.closer.key;
  @override
  Page<T> get page => _impl.page;
  @override
  Completer<T?> get completer => _impl.completer;
  @override
  PageInfo? get pageInfo => null;
}

class _MyScreenPageLimitedImpl<T> {
  final Page<T> page;
  final Completer<T?> completer;
  final PageCloser<T> closer;
  _MyScreenPageLimitedImpl({required Widget Function(PageCloser<T>) builder, required this.closer})
    : completer = Completer(),
      page = MaterialPage<T>(child: builder(closer));
}

abstract class MyDialogPage<T> extends MyPage<T> {
  final _MyDialogPageImpl<T> _impl;
  MyDialogPage({
    required Widget Function(BuildContext, PageCloser<T>) builder,
    bool barrierDismissable = true,
  }) : _impl = _MyDialogPageImpl(
         builder: builder,
         closer: PageCloser(PageKey()),
         barrierDismissable: barrierDismissable,
       );

  @override
  PageKey get key => _impl.closer.key;
  @override
  Page<T> get page => _impl.page;
  @override
  Completer<T?> get completer => _impl.completer;
  @override
  PageInfo? get pageInfo => null;
}

class _MyDialogPageImpl<T> {
  final Page<T> page;
  final Completer<T?> completer;
  final PageCloser<T> closer;
  _MyDialogPageImpl({
    required Widget Function(BuildContext, PageCloser<T>) builder,
    required this.closer,
    required bool barrierDismissable,
  }) : completer = Completer(),
       page = MaterialDialogPage<T>(
         (context) => builder(context, closer),
         barrierDismissable: barrierDismissable,
       );
}

abstract class MyFullScreenDialogPage<T> extends MyPage<T> {
  final _MyFullScreenDialogPageImpl<T> _impl;
  MyFullScreenDialogPage({required Widget Function(PageCloser<T>) builder})
    : _impl = _MyFullScreenDialogPageImpl(builder: builder, closer: PageCloser(PageKey()));

  @override
  PageKey get key => _impl.closer.key;
  @override
  Page<T> get page => _impl.page;
  @override
  Completer<T?> get completer => _impl.completer;
  @override
  PageInfo? get pageInfo => null;
}

class _MyFullScreenDialogPageImpl<T> {
  final Page<T> page;
  final Completer<T?> completer;
  final PageCloser<T> closer;
  _MyFullScreenDialogPageImpl({
    required Widget Function(PageCloser<T>) builder,
    required this.closer,
  }) : completer = Completer(),
       page = MaterialPage<T>(child: builder(closer), fullscreenDialog: true);
}

class PageCloser<T> {
  final PageKey key;
  PageCloser(this.key);
  void close(BuildContext context, T close) {
    MyNavigator.removePage(context, key, close);
  }
}

class PageKey extends UniqueKey {}

sealed class PageInfo {
  const PageInfo();
}

class ConversationPageInfo extends PageInfo {
  final AccountId accountId;
  const ConversationPageInfo(this.accountId);
}

class LikesPageInfo extends PageInfo {
  const LikesPageInfo();
}

class ContentManagementPageInfo extends PageInfo {
  const ContentManagementPageInfo();
}

class MyProfilePageInfo extends PageInfo {
  const MyProfilePageInfo();
}

class AutomaticProfileSearchResultsPageInfo extends PageInfo {
  const AutomaticProfileSearchResultsPageInfo();
}
