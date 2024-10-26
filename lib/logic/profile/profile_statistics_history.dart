
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/api/api_manager.dart";
import "package:pihka_frontend/data/login_repository.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/profile/profile_statistics_history.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";


sealed class ProfileStatisticsHistoryEvent {}
class Reload extends ProfileStatisticsHistoryEvent {
  final ProfileStatisticsHistoryValueType? historyValue;
  final int? age;
  final bool manualRefresh;
  Reload({this.historyValue, this.age, this.manualRefresh = false});
}

class ProfileStatisticsHistoryBloc extends Bloc<ProfileStatisticsHistoryEvent, ProfileStatisticsHistoryData> with ActionRunner {
  final ApiManager api = LoginRepository.getInstance().repositories.api;

  ProfileStatisticsHistoryBloc() : super(ProfileStatisticsHistoryData()) {
    on<Reload>((data, emit) async {
      if (!data.manualRefresh) {
        emit(state.copyWith(
          isLoading: true,
          isError: false
        ));
      }

      final r = await api.profileAdmin((api) => api.getProfileStatisticsHistory(
        data.historyValue ?? ProfileStatisticsHistoryValueType.accounts,
        age: data.age,
      ));

      if (data.manualRefresh) {
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
