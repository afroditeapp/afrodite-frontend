
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/model/freezed/logic/profile/profile_statistics.dart";
import "package:pihka_frontend/utils.dart";


sealed class ProfileStatisticsEvent {}
class Reload extends ProfileStatisticsEvent {}

class ProfileStatisticsBloc extends Bloc<ProfileStatisticsEvent, ProfileStatisticsData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  ProfileStatisticsBloc() : super(ProfileStatisticsData()) {
    on<Reload>((data, emit) async {
      emit(state.copyWith(
        isLoading: true,
        isError: false
      ));

      final r = await api.profile((api) => api.getProfileStatistics());

      emit(state.copyWith(
        isError: r.isErr(),
        isLoading: false,
        item: r.ok()
      ));
    },
      transformer: sequential()
    );

    add(Reload());
  }
}
