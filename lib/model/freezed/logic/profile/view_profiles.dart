
import 'package:database/database.dart';

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'view_profiles.freezed.dart';


enum ProfileActionState {
  like,
  removeLike,
  makeMatch,
  chat,
}

@freezed
class ViewProfilesData with _$ViewProfilesData {
  factory ViewProfilesData({
    required ProfileEntry profile,
    @Default(FavoriteStateIdle(false)) FavoriteState isFavorite,
    @Default(ProfileActionState.like) ProfileActionState profileActionState,
    @Default(false) bool isNotAvailable,
    @Default(false) bool isBlocked,
    @Default(false) bool showLikeCompleted,
    @Default(false) bool showRemoveLikeCompleted,
  }) = _ViewProfilesData;
}


sealed class FavoriteState {
  final bool isFavorite;
  const FavoriteState(this.isFavorite);
}

class FavoriteStateChangeInProgress extends FavoriteState {
  const FavoriteStateChangeInProgress(super.isFavorite);
}

class FavoriteStateIdle extends FavoriteState {
  const FavoriteStateIdle(super.isFavorite);
}
