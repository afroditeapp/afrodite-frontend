import "package:app/ui_utils/common_update_logic.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';
import "package:openapi/api.dart";

part 'association_membership.freezed.dart';

@freezed
class AssociationMembershipBlocData with _$AssociationMembershipBlocData, UpdateStateProvider {
  factory AssociationMembershipBlocData({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    AssociationMembership? membership,
    AssociationConfig? config,
    GetAssociationMembersOnlyInfo? membersOnlyInfo,
    @Default(UpdateIdle()) UpdateState updateState,
  }) = _AssociationMembershipBlocData;
}
