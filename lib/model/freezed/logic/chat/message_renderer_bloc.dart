import "package:database/database.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:pihka_frontend/utils/immutable_list.dart";

part 'message_renderer_bloc.freezed.dart';


@freezed
class MessageRendererData with _$MessageRendererData {
  factory MessageRendererData({
    @Default(false) bool completed,
    @Default(0.0) double totalHeight,
    MessageEntry? currentlyRendering,
    @Default(UnmodifiableList<MessageEntry>.empty()) UnmodifiableList<MessageEntry> toBeRendered,
  }) = _MessageRendererData;
}
