import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


part 'profile.freezed.dart';

@freezed
class ProfileData with _$ProfileData {
  factory ProfileData({
    @Default("") String accountId,
  }) = _ProfileData;
}

abstract class ProfileEvent {}
class SetProfileText extends ProfileEvent {
  final String profile;
  SetProfileText(this.profile);
}

/// Do register/login operations
class ProfileBloc extends Bloc<ProfileEvent, ProfileData> {
  final ProfileRepository profile;

  ProfileBloc(this.profile) : super(ProfileData()) {
    on<SetProfileText>((data, emit) async {

    });
  }
}
