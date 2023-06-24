import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/account_repository.dart";
import "package:pihka_frontend/data/media_repository.dart";
import "package:pihka_frontend/data/profile_repository.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/utils.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


part 'profile.freezed.dart';

@freezed
class ProfileData with _$ProfileData {
  factory ProfileData({
    Profile? profile,
    PrimaryImage? primaryImage,
  }) = _ProfileData;
}

sealed class ProfileEvent {}
class SetProfile extends ProfileEvent {
  final Profile profile;
  SetProfile(this.profile);
}
class LoadProfile extends ProfileEvent {
  LoadProfile();
}

/// Do register/login operations
class ProfileBloc extends Bloc<ProfileEvent, ProfileData> with ActionRunner {
  final AccountRepository account;
  final ProfileRepository profile;
  final MediaRepository media;

  ProfileBloc(this.account, this.profile, this.media) : super(ProfileData()) {
    on<SetProfile>((data, emit) async {

    });
    on<LoadProfile>((data, emit) async {
      await runOnce(() async {
        final currentAccountId = await account.accountId.first;
        if (currentAccountId != null) {
          final currentProfile = await profile.requestProfile(currentAccountId);
          final img = await media.getPrimaryImage(currentAccountId, false);
          if (currentProfile != null || img != null) {
            emit(state.copyWith(profile: currentProfile, primaryImage: img));
          }
        }
      });
    });
  }

  Future<Uint8List?> getImage(AccountIdLight imageOwner, ContentId id) async {
    return media.getImage(imageOwner, id);
  }

  Future<Uint8List?> getProfileImage(AccountIdLight imageOwner) async {
    final contentId = await media.getProfileImage(imageOwner, false);

    if (contentId != null) {
      return await getImage(imageOwner, contentId);
    } else {
      return null;
    }
  }
}
