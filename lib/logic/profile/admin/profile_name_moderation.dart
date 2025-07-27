

import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/admin/profile_name_moderation.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/result.dart";

abstract class ProfileNameModerationEvent {}
class Reload extends ProfileNameModerationEvent {}
class UpdateSelectedStatus extends ProfileNameModerationEvent {
  final ProfileStringPendingModeration item;
  final bool selected;
  UpdateSelectedStatus(this.item, this.selected);
}
class HandleList extends ProfileNameModerationEvent {
  final List<ProfileStringPendingModeration> items;
  final bool accept;
  HandleList(this.items, this.accept);
}

class ProfileNameModerationBloc extends Bloc<ProfileNameModerationEvent, ProfileNameModerationData> {
  final ApiManager api = LoginRepository.getInstance().repositories.api;
  ProfileNameModerationBloc() : super(ProfileNameModerationData()) {
    on<Reload>((data, emit) async {
        emit(ProfileNameModerationData().copyWith(isLoading: true));

        final r = await api.profileAdmin((api) => api.getProfileStringPendingModerationList(ProfileStringModerationContentType.profileName, true));
        switch (r) {
          case Ok():
            emit(state.copyWith(
              isLoading: false,
              isError: false,
              item: r.v,
            ));
          case Err():
            emit(state.copyWith(
              isLoading: false,
              isError: true,
            ));
        }
    },
      transformer: sequential(),
    );
    on<UpdateSelectedStatus>((data, emit) async {
        final copy = {
          ...state.selected,
        };
        if (data.selected) {
          copy.add(data.item);
        } else {
          copy.remove(data.item);
        }
        emit(state.copyWith(selected: copy));
    },
      transformer: sequential(),
    );
    on<HandleList>((data, emit) async {
        emit(ProfileNameModerationData().copyWith(isLoading: true));

        for (final item in data.items) {
          final r = await api.profileAdminAction((api) => api.postModerateProfileString(
            PostModerateProfileString(
              contentType: ProfileStringModerationContentType.profileName,
              accept: data.accept,
              id: item.id,
              value: item.value,
              rejectedDetails: ProfileStringModerationRejectedReasonDetails(value: ""),
            ),
          ));
          if (r.isErr()) {
            showSnackBar(R.strings.generic_error_occurred);
          }
        }

        add(Reload());
    },
      transformer: sequential(),
    );

    add(Reload());
  }
}
