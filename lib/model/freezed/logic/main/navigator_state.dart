import 'package:flutter/material.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:openapi/api.dart';
import 'package:app/ui/splash_screen.dart';
import 'package:app/utils/immutable_list.dart';
import 'package:rxdart/rxdart.dart';

part 'navigator_state.freezed.dart';

@freezed
class NavigatorStateData with _$NavigatorStateData {
  NavigatorStateData._();
  factory NavigatorStateData({
    required UnmodifiableList<PageAndChannel> pages,
    @Default(false) bool disableAnimation,
  }) = _NavigatorStateData;

  List<Page<Object?>> getPages() {
    return pages.map((e) => e.page).toList();
  }

  static NavigatorStateData defaultValue() {
    return NavigatorStateData(pages: UnmodifiableList(PageAndChannel.splashScreen()));
  }
}

class PageAndChannel {
  final PageKey key;
  final Page<Object?> page;
  final BehaviorSubject<ReturnChannelValue> channel;
  final PageInfo? pageInfo;

  const PageAndChannel(this.key, this.page, this.channel, this.pageInfo);

  static List<PageAndChannel> splashScreen() {
    return [
      PageAndChannel(
        PageKey(),
        const MaterialPage(child: SplashScreen()),
        BehaviorSubject.seeded(const WaitingPagePop()),
        null,
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
