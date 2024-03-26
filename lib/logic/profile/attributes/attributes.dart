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

sealed class AttributesEvent {}
class NewAttributes extends AttributesEvent {
  final AvailableProfileAttributes? attributes;
  NewAttributes(this.attributes);
}
class RefreshAttributesIfNeeded extends AttributesEvent {}


class ProfileAttributesBloc extends Bloc<AttributesEvent, AttributesData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();

  ProfileAttributesBloc() : super(AttributesData()) {
    on<NewAttributes>((data, emit) async {
      emit(state.copyWith(attributes: data.attributes));
    });
    on<RefreshAttributesIfNeeded>((data, emit) async {
      if (state.attributes != null) {
        // Refresh only if the attributes are not already loaded
        return;
      }

      emit(state.copyWith(refreshState: AttributeRefreshLoading()));
      final attributes = await ProfileRepository.getInstance().receiveProfileAttributes();
      emit(state.copyWith(refreshState: null));

      // Only check error as the new attributes will be received from the
      // listener
      if (attributes == null) {
        showSnackBar(R.strings.generic_error_occurred);
      }
    });

    ProfileRepository.getInstance().profileAttributes.listen((value) => add(NewAttributes(value)));
  }
}

sealed class AttributeRefreshState {}
class AttributeRefreshLoading extends AttributeRefreshState {}
