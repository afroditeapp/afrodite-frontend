
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:app/api/api_manager.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/model/freezed/logic/profile/profile_statistics.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils.dart";


sealed class ProfileStatisticsEvent {}
class Reload extends ProfileStatisticsEvent {
  final bool? generateNew;
  final StatisticsProfileVisibility? visibility;
  final bool adminRefresh;
  Reload({this.generateNew, this.visibility, this.adminRefresh = false});
}

class ProfileStatisticsBloc extends Bloc<ProfileStatisticsEvent, ProfileStatisticsData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  ProfileStatisticsBloc() : super(ProfileStatisticsData()) {
    on<Reload>((data, emit) async {
      if (!data.adminRefresh) {
        emit(state.copyWith(
          isLoading: true,
          isError: false
        ));
      }

      final r = await api.profile((api) => api.getProfileStatistics(
        generateNewStatistics: data.generateNew,
        profileVisibility: data.visibility,
      ));

      if (data.adminRefresh) {
        if (r.isErr()) {
          showSnackBar(R.strings.generic_error);
        }
        emit(state.copyWith(
          item: r.ok()
        ));
      } else {
        emit(state.copyWith(
          isError: r.isErr(),
          isLoading: false,
          item: r.ok()
        ));
      }
    },
      transformer: sequential()
    );

    add(Reload());
  }
}
