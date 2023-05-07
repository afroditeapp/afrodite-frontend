import "package:camera/camera.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'initial_setup.freezed.dart';

@freezed
class InitialSetupData with _$InitialSetupData {
  factory InitialSetupData({
    @Default("") String email,
    @Default("") String profileName,
    XFile? securitySelfie,
    XFile? profileImage,
    String? sendError,
    @Default(0) int currentStep,
  }) = _InitialSetupData;
}

abstract class InitialSetupEvent {}

class SetAccountStep extends InitialSetupEvent {
  final String email;
  SetAccountStep(this.email);
}
class SetProfileStep extends InitialSetupEvent {
  final String profileName;
  SetProfileStep(this.profileName);
}
class SetSecuritySelfieStep extends InitialSetupEvent {
  final XFile securitySelfie;
  SetSecuritySelfieStep(this.securitySelfie);
}
class SetProfileImageStep extends InitialSetupEvent {
  final XFile profileImage;
  SetProfileImageStep(this.profileImage);
}
class GoBack extends InitialSetupEvent {
  final int? step;
  GoBack(this.step);
}

class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> {
  final AccountRepository account;

  InitialSetupBloc(this.account) : super(InitialSetupData()) {
    on<SetAccountStep>((data, emit) {
      emit(state.copyWith(
        email: data.email,
        currentStep: 1,
      ));
    });
    on<SetProfileStep>((data, emit) {
      emit(state.copyWith(
        profileName: data.profileName,
        currentStep: 2,
      ));
    });
    on<SetSecuritySelfieStep>((data, emit) {
      emit(state.copyWith(
        securitySelfie: data.securitySelfie,
        currentStep: 3,
      ));
    });
    on<SetProfileImageStep>((data, emit) {
      emit(state.copyWith(
        profileImage: data.profileImage,
        currentStep: 4,
      ));
    });
    on<GoBack>((requestedStep, emit) {
      final stepIndex = requestedStep.step;
      int newIndex;
      if (stepIndex == null && state.currentStep > 0) {
        newIndex = state.currentStep - 1;
      } else if (stepIndex != null && stepIndex < state.currentStep) {
        newIndex = stepIndex;
      } else {
        newIndex = state.currentStep;
      }
      emit(state.copyWith(
        currentStep: newIndex,
      ));
    });
  }
}
