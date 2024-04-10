

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_basic_info.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_pictures.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/age.dart';
import 'package:pihka_frontend/utils/profile_entry.dart';


class EditProfilePage extends StatefulWidget {
  final ProfileEntry initialProfile;
  final ProfilePicturesBloc profilePicturesBloc;
  final EditMyProfileBloc editMyProfileBloc;
  const EditProfilePage({
    required this.initialProfile,
    required this.profilePicturesBloc,
    required this.editMyProfileBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  bool saveStarted = false;

  @override
  void initState() {
    super.initState();

    // Profile data
    widget.editMyProfileBloc.add(SetInitialValues(widget.initialProfile));

    // Profile pictures

    widget.profilePicturesBloc.add(ResetIfModeChanges(const NormalProfilePictures()));

    setImgToBloc(widget.initialProfile.imageUuid, 0);
    final cropInfo = widget.initialProfile.primaryImageCropInfo();
    widget.profilePicturesBloc.add(UpdateCropResults(cropInfo, 0));

    setImgToBloc(widget.initialProfile.content1, 1);
    setImgToBloc(widget.initialProfile.content2, 2);
    setImgToBloc(widget.initialProfile.content3, 3);
  }

  void setImgToBloc(ContentId? contentId, int index) {
    if (contentId == null) {
      return;
    }
    final imgId = AccountImageId(widget.initialProfile.uuid, contentId);
    widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(imgId, index)));
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.editMyProfileBloc.state;
    final age = s.age;
    if (age == null || !ageIsValid(age)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_age);
      return;
    }

    final initial = s.initial;
    if (initial == null || !initialIsValid(initial)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_initial);
      return;
    }

    final attributes = widget
      .initialProfile
      .attributes
      .map((e) => ProfileAttributeValueUpdate(id: e.id, valuePart1: e.valuePart1, valuePart2: e.valuePart2))
      .toList();

    context.read<MyProfileBloc>().add(SetProfile(
      ProfileUpdate(
        age: age,
        name: initial,
        profileText: widget.initialProfile.profileText,
        attributes: attributes,
      )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        validateAndSaveData(context);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.strings.edit_profile_screen_title)),
        body: BlocListener<MyProfileBloc, MyProfileData>(
          listenWhen: (previous, current) => previous.profileUpdateState != current.profileUpdateState,
          listener: (context, state) {
            final updateState = state.profileUpdateState;
            if (updateState is ProfileUpdateStarted) {
              showLoadingDialogWithAutoDismiss<MyProfileBloc, MyProfileData>(
                context,
                dialogVisibilityGetter: (s) =>
                  s.profileUpdateState is ProfileUpdateStarted ||
                  s.profileUpdateState is ProfileUpdateInProgress,
                dismissAction: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              );
            }
          },
          child: edit(context),
        ),
      ),
    );
  }

  Widget edit(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePictureSelection(
            profilePicturesBloc: context.read<ProfilePicturesBloc>(),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          const Divider(),
          const Padding(padding: EdgeInsets.all(8)),
          AskProfileBasicInfo(
            profileInitialInitialValue: widget.initialProfile.name,
            setterProfileInitial: (value) {
              widget.editMyProfileBloc.add(NewInitial(value));
            },
            ageInitialValue: widget.initialProfile.age.toString(),
            setterProfileAge: (value) {
              widget.editMyProfileBloc.add(NewAge(value));
            },
          )
        ],
      ),
    );
  }



  // Profile text is disabled for now

  // final TextEditingController _profileTextController = TextEditingController();
  // Widget editProfileText() {
  //   Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       controller: _profileTextController,
  //       maxLines: 10,
  //       decoration: const InputDecoration(
  //         border: OutlineInputBorder(),
  //         labelText: "Profile text",
  //       ),
  //     ),
  //   );
  // }
}
