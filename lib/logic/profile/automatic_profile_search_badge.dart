import "dart:async";

import "package:app/data/utils/repository_instances.dart";
import "package:app/database/account_database_manager.dart";
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
  final AccountDatabaseManager db;

  StreamSubscription<AutomaticProfileSearchBadgeState?>? _stateSubscription;

  AutomaticProfileSearchBadgeBloc(RepositoryInstances r)
    : db = r.accountDb,
      super(AutomaticProfileSearchBadgeData()) {
    on<BadgeStateUpdate>((data, emit) {
      emit(state.copyWith(badgeState: data.value));
    }, transformer: sequential());
    on<HideBadge>((data, emit) async {
      if (state.badgeState.showBadge) {
        await db.accountAction((db) => db.search.hideAutomaticProfileSearchBadge());
      }
    });

    _stateSubscription = db
        .accountStream((db) => db.search.watchAutomaticProfileSearchUiState())
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
