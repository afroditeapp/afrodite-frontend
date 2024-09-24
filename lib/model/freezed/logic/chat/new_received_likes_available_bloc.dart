import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'new_received_likes_available_bloc.freezed.dart';

@freezed
class NewReceivedLikesAvailableData with _$NewReceivedLikesAvailableData {
  const NewReceivedLikesAvailableData._();

  factory NewReceivedLikesAvailableData({
    @Default(0) int newReceivedLikesCount,
  }) = _NewReceivedLikesAvailableData;
}
