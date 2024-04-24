import 'package:flutter/material.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/ui/splash_screen.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';
import 'package:rxdart/rxdart.dart';

part 'navigator_state.freezed.dart';

@freezed
class NavigatorStateData with _$NavigatorStateData {
  NavigatorStateData._();
  factory NavigatorStateData({
    required UnmodifiableList<PageAndChannel> pages,
  }) = _NavigatorStateData;

  List<Page<Object?>> getPages() {
    return pages.map((e) => e.page).toList();
  }
}

class PageAndChannel {
  final PageKey key;
  final Page<Object?> page;
  final BehaviorSubject<ReturnChannelValue> channel;

  const PageAndChannel(this.key, this.page, this.channel);

  static List<PageAndChannel> splashScreen() {
    return [
      PageAndChannel(
        PageKey(),
        const MaterialPage(child: SplashScreen()),
        BehaviorSubject.seeded(const WaitingPagePop()),
      ),
    ];
  }
}


sealed class ReturnChannelValue {
  const ReturnChannelValue();
}
class WaitingPagePop extends ReturnChannelValue {
  const WaitingPagePop();
}
class PagePopDone extends ReturnChannelValue {
  final Object? returnValue;
  const PagePopDone(this.returnValue);
}

class PageKey extends UniqueKey {}
