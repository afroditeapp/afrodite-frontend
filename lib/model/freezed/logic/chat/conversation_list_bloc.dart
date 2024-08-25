
import 'package:database/database.dart';
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

part 'conversation_list_bloc.freezed.dart';

@freezed
class ConversationListData with _$ConversationListData {
  factory ConversationListData({
    @Default(UnmodifiableList<IdAndEntry>.empty()) UnmodifiableList<IdAndEntry> conversations,
    @Default(UnmodifiableList<ListItemChangeWithEntry>.empty()) UnmodifiableList<ListItemChangeWithEntry> changesBetweenCurrentAndPrevious,
    @Default(false) bool initialLoadDone,
  }) = _ConversationListData;
}

class IdAndEntry {
  final AccountId id;
  final ProfileEntry? entry;
  IdAndEntry(this.id, this.entry);
}

sealed class ListItemChange {}

class AddItem extends ListItemChange {
  final int i;
  final AccountId id;
  AddItem(this.i, this.id);
}
class RemoveItem extends ListItemChange {
  final int i;
  final AccountId id;
  RemoveItem(this.i, this.id);
}

sealed class ListItemChangeWithEntry {}

class AddItemEntry extends ListItemChangeWithEntry {
  final int i;
  final AccountId id;
  final ProfileEntry? entry;
  AddItemEntry(this.i, this.id, this.entry);
}
class RemoveItemEntry extends ListItemChangeWithEntry {
  final int i;
  final AccountId id;
  final ProfileEntry? entry;
  RemoveItemEntry(this.i, this.id, this.entry);
}
