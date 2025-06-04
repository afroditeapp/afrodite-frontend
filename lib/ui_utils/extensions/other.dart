
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

extension GridSettingsExtensions on GridSettings {
  SliverGridDelegateWithFixedCrossAxisCount toSliverGridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: valueRowProfileCount(),
      crossAxisSpacing: valueInternalPadding(),
      mainAxisSpacing: valueInternalPadding(),
    );
  }

  GridSettings copyWith(
    {
      double? horizontalPadding,
      double? internalPadding,
      double? profileThumbnailBorderRadius,
      int? rowProfileCount,
    }
  ) {
    return GridSettings(
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      internalPadding: internalPadding ?? this.internalPadding,
      profileThumbnailBorderRadius: profileThumbnailBorderRadius ?? this.profileThumbnailBorderRadius,
      rowProfileCount: rowProfileCount ?? this.rowProfileCount,
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
    return copyWith(
      isLoading: false,
      error: true,
    );
  }

  PagingState<int, T> copyAndShowLoading() {
    return copyWith(
      isLoading: true,
      error: null,
    );
  }
}
