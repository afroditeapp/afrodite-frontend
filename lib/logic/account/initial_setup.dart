import "package:camera/camera.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";

@immutable
class InitialSetupData extends Equatable {
  final String email;
  final String profileName;
  final XFile? securitySelfie;
  final XFile? profileImage;
  final String? sendError; // If null sending in progress
  final int currentStep;

  const InitialSetupData({
    this.email = "",
    this.profileName = "",
    this.securitySelfie,
    this.profileImage,
    this.sendError,
    this.currentStep = 0,
  });

  InitialSetupData copyAndChange(void Function(InitialSetupData) change) {
    final newData = InitialSetupData(
      email: email,
      profileName: profileName,
      securitySelfie: securitySelfie,
      profileImage: profileImage,
      sendError: sendError,
      currentStep: currentStep
    );

    return newData;
  }

  @override
  List<Object?> get props =>  [
    email,
    profileName,
    securitySelfie,
    profileImage,
    sendError,
    currentStep
  ];
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
// class SendAll extends InitialSetupEvent {}
class GoBack extends InitialSetupEvent {
  final int? step;
  GoBack(this.step);
}


/// Do register/login operations
class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> {
  final AccountRepository account;

  InitialSetupBloc(this.account) : super(InitialSetupData()) {
    on<SetAccountStep>((data, emit) {
      print(data);
      emit(InitialSetupData(
        email: data.email,
        profileName: state.profileName,
        securitySelfie: state.securitySelfie,
        profileImage: state.profileImage,
        sendError: state.sendError,
        currentStep: 1,
      ));
    });
    on<SetProfileStep>((data, emit) {
      print(data);
      emit(InitialSetupData(
        email: state.email,
        profileName: data.profileName,
        securitySelfie: state.securitySelfie,
        profileImage: state.profileImage,
        sendError: state.sendError,
        currentStep: 2,
      ));
    });
    on<SetSecuritySelfieStep>((data, emit) {
      print(data);
      emit(InitialSetupData(
        email: state.email,
        profileName: state.profileName,
        securitySelfie: data.securitySelfie,
        profileImage: state.profileImage,
        sendError: state.sendError,
        currentStep: 3,
      ));
    });
    on<SetProfileImageStep>((data, emit) {
      print(data);
      emit(InitialSetupData(
        email: state.email,
        profileName: state.profileName,
        securitySelfie: state.securitySelfie,
        profileImage: data.profileImage,
        sendError: state.sendError,
        currentStep: 4,
      ));
    });
    // on<SendAll>((_, emit) {
    //   state.sendError = null;
    //   state.currentStep += 1;
    //   emit(state);
    // });
    on<GoBack>((requestedStep, emit) {
      final stepIndex = requestedStep.step;
      print(requestedStep);
      int newIndex;
      if (stepIndex == null && state.currentStep > 0) {
        newIndex = state.currentStep - 1;
      } else if (stepIndex != null && stepIndex < state.currentStep) {
        newIndex = stepIndex;
      } else {
        newIndex = state.currentStep;
      }

      emit(InitialSetupData(
        email: state.email,
        profileName: state.profileName,
        securitySelfie: state.securitySelfie,
        profileImage: state.profileImage,
        sendError: state.sendError,
        currentStep: newIndex,
      ));
    });
  }
}
