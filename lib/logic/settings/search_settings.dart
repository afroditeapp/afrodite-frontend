import "dart:async";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import 'package:pihka_frontend/database/database_manager.dart';
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/model/freezed/logic/settings/search_settings.dart";
import "package:pihka_frontend/ui_utils/common_update_logic.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/result.dart";
import "package:pihka_frontend/utils/time.dart";


sealed class SearchSettingsEvent {}
class NewMinAge extends SearchSettingsEvent {
  final int? value;
  NewMinAge(this.value);
}
class NewMaxAge extends SearchSettingsEvent {
  final int? value;
  NewMaxAge(this.value);
}
class NewSearchGroups extends SearchSettingsEvent {
  final SearchGroups? value;
  NewSearchGroups(this.value);
}
class SaveSearchSettings extends SearchSettingsEvent {
  final int minAge;
  final int maxAge;
  final SearchGroups searchGroups;
  SaveSearchSettings({
    required this.minAge,
    required this.maxAge,
    required this.searchGroups,
  });
}

class SearchSettingsBloc extends Bloc<SearchSettingsEvent, SearchSettingsData> with ActionRunner {
  final ProfileRepository profile = ProfileRepository.getInstance();
  final db = DatabaseManager.getInstance();

  StreamSubscription<int?>? _minAgeSubscription;
  StreamSubscription<int?>? _maxAgeSubscription;
  StreamSubscription<SearchGroups?>? _searchGroupsSubscription;

  SearchSettingsBloc() : super(SearchSettingsData()) {
    on<SaveSearchSettings>((data, emit) async {
      await runOnce(() async {
        emit(state.copyWith(
          updateState: const UpdateStarted(),
        ));

        final waitTime = WantedWaitingTimeManager();

        var failureDetected = false;

        emit(state.copyWith(
          updateState: const UpdateInProgress(),
        ));

        if (!await profile.updateSearchAgeRange(data.minAge, data.maxAge).isOk()) {
          failureDetected = true;
        }

        if (!await profile.updateSearchGroups(data.searchGroups).isOk()) {
          failureDetected = true;
        }

        await profile.resetMainProfileIterator();

        await waitTime.waitIfNeeded();

        if (failureDetected) {
          showSnackBar(R.strings.search_settings_screen_search_settings_update_failed);
        }

        emit(state.copyWith(
          updateState: const UpdateIdle(),
        ));
      });
    });
    on<NewMinAge>((data, emit) async {
      emit(state.copyWith(minAge: data.value));
    });
    on<NewMaxAge>((data, emit) async {
      emit(state.copyWith(maxAge: data.value));
    });
    on<NewSearchGroups>((data, emit) async {
      emit(state.copyWith(searchGroups: data.value));
    });

    _minAgeSubscription = db.accountStream((db) => db.daoProfileSettings.watchProfileSearchAgeRangeMin()).listen((event) {
      add(NewMinAge(event));
    });
    _maxAgeSubscription = db.accountStream((db) => db.daoProfileSettings.watchProfileSearchAgeRangeMax()).listen((event) {
      add(NewMaxAge(event));
    });
    _searchGroupsSubscription = db.accountStream((db) => db.daoProfileSettings.watchSearchGroups()).listen((event) {
      add(NewSearchGroups(event));
    });
  }

  @override
  Future<void> close() async {
    await _minAgeSubscription?.cancel();
    await _maxAgeSubscription?.cancel();
    await _searchGroupsSubscription?.cancel();
    await super.close();
  }
}
