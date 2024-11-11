import 'dart:math';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'new_received_likes_available_bloc.freezed.dart';

@freezed
class NewReceivedLikesAvailableData with _$NewReceivedLikesAvailableData {
  const NewReceivedLikesAvailableData._();

  factory NewReceivedLikesAvailableData({
    @Default(0) int newReceivedLikesCount,
    /// The debounced value exists to hide new received likes badge blink when
    /// - Likes bottom navigation tab is open,
    /// - scroll position is on top and
    /// - automatic received likes refresh happens.
    @Default(0) int newReceivedLikesCountPartiallyDebounced,
    @Default(0) int newReceivedLikesCountNotViewed,
    @Default(false) bool triggerReceivedLikesRefresh,
    @Default(false) bool showRefreshButton,
  }) = _NewReceivedLikesAvailableData;

  int receivedLikesCountForUi() {
    return max(newReceivedLikesCountPartiallyDebounced, newReceivedLikesCountNotViewed);
  }
}
