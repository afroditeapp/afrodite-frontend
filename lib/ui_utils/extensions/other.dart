import 'dart:math';

import 'package:database/database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension GridSettingsExtensions on GridSettings {
  double singleItemWidth(BuildContext context) {
    // Assume that app window in on the first display
    final currentDisplay = PlatformDispatcher.instance.displays.firstOrNull;
    final widthPixels = currentDisplay?.size.width.toInt() ?? 1920;
    final heightPixels = currentDisplay?.size.height.toInt() ?? 1080;
    final portraitAvailablePixels = min(widthPixels, heightPixels);
    double portraitAvailableSize;
    if (kIsWeb) {
      portraitAvailableSize = portraitAvailablePixels.toDouble();
    } else {
      portraitAvailableSize = portraitAvailablePixels / MediaQuery.devicePixelRatioOf(context);
    }
    portraitAvailableSize = min(portraitAvailableSize, 720);
    final itemAreaWidth = portraitAvailableSize - (valueHorizontalPadding() * 2);
    final itemAreaWidthWithoutInternalPadding =
        itemAreaWidth - (valueInternalPadding() * (valueRowProfileCount() - 1));
    final singleItemWidth = itemAreaWidthWithoutInternalPadding / valueRowProfileCount();
    return singleItemWidth;
  }

  SliverGridDelegate toSliverGridDelegate(BuildContext context, {required double? itemWidth}) {
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: itemWidth ?? singleItemWidth(context),
      crossAxisSpacing: valueInternalPadding(),
      mainAxisSpacing: valueInternalPadding(),
    );
  }

  GridSettings copyWith({int? itemSizeMode, int? paddingMode}) {
    return GridSettings(
      itemSizeMode: itemSizeMode ?? this.itemSizeMode,
      paddingMode: paddingMode ?? this.paddingMode,
    );
  }
}

extension PagingStateExtensions<T> on PagingState<int, T> {
  bool isInitialPage() {
    return currentPageNumber() == 0;
  }

  /// The first number is 0.
  int currentPageNumber() {
    return keys?.lastOrNull ?? 0;
  }

  int nextPageNumber() {
    return currentPageNumber() + 1;
  }

  PagingState<int, T> copyAndAdd(List<T> page) {
    return copyWith(
      isLoading: false,
      pages: [...?pages, page],
      keys: [...?keys, nextPageNumber()],
      hasNextPage: page.isNotEmpty,
    );
  }

  PagingState<int, T> copyAndShowError() {
    return copyWith(isLoading: false, error: true);
  }

  PagingState<int, T> copyAndShowLoading() {
    return copyWith(isLoading: true, error: null);
  }
}
