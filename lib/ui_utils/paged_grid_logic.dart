
import 'dart:async';

import 'package:app/ui_utils/profile_grid.dart';
import 'package:rxdart/rxdart.dart';

sealed class GridEvent {}
class FetchPage extends GridEvent {
  final Future<List<ProfileGridProfileEntry>?> Function() fetchPage;
  final void Function(List<ProfileGridProfileEntry>) addPage;
  FetchPage(this.fetchPage, this.addPage);
}
class Refresh extends GridEvent {
  final void Function() refresh;
  final Future<List<ProfileGridProfileEntry>?> Function() fetchPage;
  final void Function(List<ProfileGridProfileEntry>) addPage;
  Refresh(this.refresh, this.fetchPage, this.addPage);
}

class CheckScheduled {}

class PagedGridLogic {
  final PublishSubject<CheckScheduled> _subject = PublishSubject();
  late StreamSubscription<void> subscription;

  GridEvent? scheduled;
  GridEvent? inProgress;

  void fetchPage(
    Future<List<ProfileGridProfileEntry>?> Function() fetchPage,
    void Function(List<ProfileGridProfileEntry>) addPage,
  ) {
    if (scheduled != null || inProgress != null) {
      return;
    }
    scheduled = FetchPage(fetchPage, addPage);
    _subject.add(CheckScheduled());
  }

  void refresh(
    void Function() refresh,
    Future<List<ProfileGridProfileEntry>?> Function() fetchPage,
    void Function(List<ProfileGridProfileEntry>) addPage,
  ) {
    if (scheduled is Refresh || inProgress is Refresh) {
      return;
    }
    scheduled = Refresh(refresh, fetchPage, addPage);
    _subject.add(CheckScheduled());
  }

  void init() {
    subscription = _subject
      .asyncMap((v) async {
        final next = scheduled;
        scheduled = null;
        if (next != null) {
          inProgress = next;
          switch (next) {
            case FetchPage():
              final page = await next.fetchPage();
              if (page != null) {
                next.addPage(page);
              }
            case Refresh():
              next.refresh();
              final page = await next.fetchPage();
              if (page != null) {
                next.addPage(page);
              }
          }
        }
        inProgress = null;
        return null;
      })
      .listen((_) {});
  }

  Future<void> dispose() async {
    await subscription.cancel();
  }
}
