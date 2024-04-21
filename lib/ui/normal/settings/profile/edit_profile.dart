

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/attributes.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/my_profile.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_attributes.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_basic_info.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_pictures.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile_attribute.dart';
import 'package:pihka_frontend/ui/utils/view_profile.dart';
import 'package:pihka_frontend/ui_utils/common_update_logic.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/age.dart';
import 'package:pihka_frontend/utils/immutable_list.dart';
import 'package:pihka_frontend/utils/profile_entry.dart';


// TODO: Logout leaves some profile images to Bloc, so previous account's
// profile images are visible in the new account's edit profile screen.
// Update: there is now RemoveImage event which should reset the data but
// other blocs should also be checked.

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
      widget.profilePicturesBloc.add(RemoveImage(index));
      return;
    }
    final imgId = AccountImageId(widget.initialProfile.uuid, contentId);
    widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(imgId, null), index));
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

    final imgUpdate = widget.profilePicturesBloc.state.toSetProfileContent();
    if (imgUpdate == null) {
      showSnackBar(context.strings.edit_profile_screen_one_profile_image_required);
      return;
    }

    context.read<MyProfileBloc>().add(SetProfile(
      ProfileUpdate(
        age: age,
        name: initial,
        profileText: widget.initialProfile.profileText,
        attributes: s.attributes.toList(),
      ),
      imgUpdate,
      context.read<AccountBloc>().state.isInitialModerationOngoing(),
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
        body: updateStateHandler<MyProfileBloc, MyProfileData>(
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
          ),
          const Padding(padding: EdgeInsets.all(8)),
          const Divider(),
          const EditAttributes(),
          const Padding(padding: EdgeInsets.all(8)),
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

class EditAttributes extends StatelessWidget {
  const EditAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, data) {
        final availableAttributes = data.attributes?.info;
        if (availableAttributes == null) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(builder: (context, myProfileData) {
          return Column(
            children: attributeTiles(context, availableAttributes, myProfileData.attributes)
          );
        });
      },
    );
  }

  List<Widget> attributeTiles(
    BuildContext context,
    ProfileAttributes availableAttributes,
    UnmodifiableList<ProfileAttributeValueUpdate> myAttributes,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];
    final convertedAttributes = myAttributes.map((e) {
      final value = e.valuePart1;
      if (value == null) {
        return null;
      } else {
        return ProfileAttributeValue(
          id: e.id,
          valuePart1: value,
          valuePart2: e.valuePart2,
        );
      }
    }).nonNulls;

    final l = AttributeAndValue.sortedListFrom(
      availableAttributes,
      convertedAttributes,
      includeNullAttributes: true,
    );
    for (final a in l) {
      attributeWidgets.add(attributeWidget(context, a));
      attributeWidgets.add(const Divider());
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return attributeWidgets;
  }

  Widget attributeWidget(BuildContext context, AttributeAndValue a) {
    final attributeText = a.title(context);
    final icon = iconResourceToMaterialIcon(a.attribute.icon);
    if (icon == null) {
      return const SizedBox.shrink();
    }

    final attributeWidget = Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(4)),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: COMMON_SCREEN_EDGE_PADDING),
                  child: Text(attributeText, style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: IconButton(
                      icon: Icon(icon),
                      onPressed: () => (),
                      tooltip: attributeText,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                  Expanded(child: AttributeValuesArea(a: a)),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconButton(
            icon: const Icon(Icons.edit_rounded),
            // color: buttonColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => EditProfileAttributeScreen(a: a))
            ),
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () =>
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => EditProfileAttributeScreen(a: a))
        ),
      child: attributeWidget,
    );
  }
}
