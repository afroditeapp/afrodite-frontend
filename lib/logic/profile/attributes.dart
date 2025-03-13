import "dart:async";

import "package:database/database.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:app/data/login_repository.dart";
import "package:app/data/profile_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/attributes.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";


sealed class AttributesEvent {}
class NewAttributes extends AttributesEvent {
  final ProfileAttributes? attributes;
  NewAttributes(this.attributes);
}
class RefreshAttributesIfNeeded extends AttributesEvent {}


class ProfileAttributesBloc extends Bloc<AttributesEvent, AttributesData> with ActionRunner {
  final ProfileRepository profile = LoginRepository.getInstance().repositories.profile;

  StreamSubscription<ProfileAttributes?>? _attributesSubscription;

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
      final r = await profile.receiveClientConfig();
      emit(state.copyWith(refreshState: null));

      // Only check error as the new attributes will be received from the
      // listener
      if (r.isErr()) {
        showSnackBar(R.strings.generic_error_occurred);
      }
    });

    _attributesSubscription = profile.profileAttributes.listen((value) => add(NewAttributes(value)));
  }

  @override
  Future<void> close() async {
    await _attributesSubscription?.cancel();
    await super.close();
  }
}
