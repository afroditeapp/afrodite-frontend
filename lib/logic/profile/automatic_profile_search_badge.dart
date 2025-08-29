import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_background_database_manager.dart";
import "package:app/model/freezed/logic/profile/automatic_profile_search_badge.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart' show sequential;
import "package:database/database.dart";

import "package:flutter_bloc/flutter_bloc.dart";

sealed class AutomaticProfileSearchBadgeEvent {}

class BadgeStateUpdate extends AutomaticProfileSearchBadgeEvent {
  final AutomaticProfileSearchBadgeState value;
  BadgeStateUpdate(this.value);
}

class HideBadge extends AutomaticProfileSearchBadgeEvent {}

class AutomaticProfileSearchBadgeBloc
    extends Bloc<AutomaticProfileSearchBadgeEvent, AutomaticProfileSearchBadgeData> {
  final AccountBackgroundDatabaseManager db;

  StreamSubscription<AutomaticProfileSearchBadgeState?>? _stateSubscription;

  AutomaticProfileSearchBadgeBloc(RepositoryInstances r)
    : db = r.accountBackgroundDb,
      super(AutomaticProfileSearchBadgeData()) {
    on<BadgeStateUpdate>((data, emit) {
      emit(state.copyWith(dataLoaded: true, badgeState: data.value));
    }, transformer: sequential());
    on<HideBadge>((data, emit) async {
      // Badge state might not be loaded yet if app process starts from
      // automatic profile search notification.
      if (state.badgeState.showBadge || !state.dataLoaded) {
        await db.accountAction((db) => db.profile.hideAutomaticProfileSearchBadge());
      }
    });

    _stateSubscription = db
        .accountStream((db) => db.profile.watchAutomaticProfileSearchUiState())
        .listen((data) {
          add(BadgeStateUpdate(data ?? AutomaticProfileSearchBadgeState.defaultValue));
        });
  }

  @override
  Future<void> close() async {
    await _stateSubscription?.cancel();
    return super.close();
  }
}
