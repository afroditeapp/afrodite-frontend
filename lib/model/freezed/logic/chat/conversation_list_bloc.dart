
import "package:openapi/api.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';

part 'conversation_list_bloc.freezed.dart';

@freezed
class ConversationListData with _$ConversationListData {
  factory ConversationListData({
    @Default(UnmodifiableList<AccountId>.empty()) UnmodifiableList<AccountId> conversations,
    @Default(UnmodifiableList<AccountId>.empty()) UnmodifiableList<AccountId> previousConversations, // TODO(prod): remove?
    @Default(UnmodifiableList<ListItemChange>.empty()) UnmodifiableList<ListItemChange> changesBetweenCurrentAndPrevious,
    @Default(false) bool initialLoadDone,
  }) = _ConversationListData;
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
