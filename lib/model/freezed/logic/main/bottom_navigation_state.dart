
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/logic/app/bottom_navigation_state.dart';

part 'bottom_navigation_state.freezed.dart';

@freezed
class BottomNavigationStateData with _$BottomNavigationStateData {
  factory BottomNavigationStateData({
    @Default(BottomNavigationScreenId.profiles) BottomNavigationScreenId screen,
    @Default(false) bool isScrolledProfile,
    @Default(false) bool isScrolledLikes,
    @Default(false) bool isScrolledChats,
    @Default(false) bool isScrolledSettings,
  }) = _BottomNavigationStateData;
}
