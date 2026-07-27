import "package:app/data/utils/repository_instances.dart";
import "package:app/model/freezed/logic/account/association_membership.dart";
import "package:app/ui_utils/common_update_logic.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/utils/result.dart";
import "package:app/utils.dart";
import "package:app/utils/time.dart";
import "package:app/localizations.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";

sealed class AssociationMembershipEvent {}

class ReloadMembership extends AssociationMembershipEvent {}

class JoinAssociation extends AssociationMembershipEvent {
  final String fullName;
  final String domicile;
  final int membershipType;
  JoinAssociation(this.fullName, this.domicile, this.membershipType);
}

class UpdateMembership extends AssociationMembershipEvent {
  final String fullName;
  final String domicile;
  UpdateMembership(this.fullName, this.domicile);
}

class EndMembership extends AssociationMembershipEvent {}

class AssociationMembershipBloc
    extends Bloc<AssociationMembershipEvent, AssociationMembershipBlocData>
    with ActionRunner {
  final RepositoryInstances r;

  AssociationMembershipBloc(this.r) : super(AssociationMembershipBlocData()) {
    on<ReloadMembership>((event, emit) async {
      await runOnce(() async {
        await _reload(emit);
      });
    });
    on<JoinAssociation>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();
        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await r.account.api
            .accountAction(
              (api) => api.postAssociationMembership(
                UpdateAssociationMembership(
                  fullName: event.fullName,
                  domicile: event.domicile,
                  membershipType: event.membershipType,
                ),
              ),
            )
            .ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          await _reload(emit);
        } else {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
    on<UpdateMembership>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();
        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await r.account.api
            .accountAction(
              (api) => api.postAssociationMembership(
                UpdateAssociationMembership(
                  fullName: event.fullName,
                  domicile: event.domicile,
                  membershipType: state.membership!.membershipType,
                ),
              ),
            )
            .ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          await _reload(emit);
        } else {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
    on<EndMembership>((event, emit) async {
      await runOnce(() async {
        emit(state.copyWith(updateState: const UpdateStarted()));

        final waitTime = WantedWaitingTimeManager();
        emit(state.copyWith(updateState: const UpdateInProgress()));

        final result = await r.account.api
            .accountAction((api) => api.deleteAssociationMembership())
            .ok();

        await waitTime.waitIfNeeded();

        if (result != null) {
          await _reload(emit);
        } else {
          showSnackBar(R.strings.generic_error_occurred);
        }

        emit(state.copyWith(updateState: const UpdateIdle()));
      });
    });
  }

  Future<void> _reload(Emitter<AssociationMembershipBlocData> emit) async {
    final config = r.account.clientFeaturesConfigValue.association;
    final membership = await r.account.api.account((api) => api.getAssociationMembership()).ok();

    GetAssociationMembersOnlyInfo? membersOnlyInfo;
    if (membership?.membership != null) {
      membersOnlyInfo = await r.account.api
          .account((api) => api.getAssociationMembersOnlyInfo())
          .ok();
    }

    emit(
      state.copyWith(
        isLoading: false,
        isError: membership == null && config == null,
        membership: membership?.membership,
        config: config,
        membersOnlyInfo: membersOnlyInfo,
      ),
    );
  }
}
