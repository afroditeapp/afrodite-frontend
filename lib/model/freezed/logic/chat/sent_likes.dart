import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'sent_likes.freezed.dart';

@freezed
class SentLikesData with _$SentLikesData {
  SentLikesData._();
  factory SentLikesData({@Default(false) bool blockOngoing}) = _SentLikesData;
}
