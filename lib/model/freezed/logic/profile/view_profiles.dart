import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/chat_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/database/profile_entry.dart";
import "package:pihka_frontend/utils.dart";

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
