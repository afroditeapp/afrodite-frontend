import "package:flutter_bloc/flutter_bloc.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

part 'attributes.freezed.dart';

@freezed
class AttributesData with _$AttributesData {
  factory AttributesData({
    AvailableProfileAttributes? attributes,
    AttributeRefreshState? refreshState,
  }) = _AttributesData;
}

sealed class AttributeRefreshState {}
class AttributeRefreshLoading extends AttributeRefreshState {}
