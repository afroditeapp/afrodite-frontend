

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/app/navigator_state.dart';
import 'package:pihka_frontend/logic/media/profile_pictures.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/logic/profile/edit_my_profile.dart';
import 'package:pihka_frontend/logic/profile/my_profile.dart';
import 'package:pihka_frontend/model/freezed/logic/main/navigator_state.dart';
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
import 'package:pihka_frontend/ui_utils/consts/colors.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';
import 'package:pihka_frontend/ui_utils/icon_button.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';
import 'package:pihka_frontend/utils/api.dart';
import 'package:pihka_frontend/utils/age.dart';
import 'package:pihka_frontend/utils/profile_entry.dart';


// TODO: Logout leaves some profile images to Bloc, so previous account's
// profile images are visible in the new account's edit profile screen.
// Update: there is now RemoveImage event which should reset the data but
// other blocs should also be checked.

class EditProfilePage extends StatefulWidget {
  final PageKey pageKey;
  final ProfileEntry initialProfile;
  final ProfilePicturesBloc profilePicturesBloc;
  final EditMyProfileBloc editMyProfileBloc;
  final ProfileAttributesBloc profileAttributesBloc;
  const EditProfilePage({
    required this.pageKey,
    required this.initialProfile,
    required this.profilePicturesBloc,
    required this.editMyProfileBloc,
    required this.profileAttributesBloc,
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

  bool dataChanged(EditMyProfileData editedData, ProfilePicturesData editedImgData) {
    final currentState = widget.initialProfile;
    if (
      currentState.age != editedData.age ||
      currentState.name != editedData.initial
    ) {
      return true;
    }

    final editedImgs = editedImgData.toSetProfileContent();
    if (
      editedImgs == null ||
      currentState.imageUuid != editedImgs.contentId0 ||
      currentState.content1 != editedImgs.contentId1 ||
      currentState.content2 != editedImgs.contentId2 ||
      currentState.content3 != editedImgs.contentId3 ||
      currentState.content4 != editedImgs.contentId4 ||
      currentState.content5 != editedImgs.contentId5 ||
      currentState.primaryContentGridCropSize != editedImgs.gridCropSize ||
      currentState.primaryContentGridCropX != editedImgs.gridCropX ||
      currentState.primaryContentGridCropY != editedImgs.gridCropY
    ) {
      return true;
    }

    final availableAttributes = widget.profileAttributesBloc.state.attributes?.info?.attributes ?? [];
    for (final a in editedData.attributes) {
      final currentOrNull = currentState.attributes.where((e) => e.id == a.id).firstOrNull;
      final current = ProfileAttributeValueUpdate(
        id: a.id,
        values: currentOrNull?.values ?? [],
      );
      final attributeInfo = availableAttributes.where((e) => e.id == a.id).firstOrNull;

      final nonNumberListAttributeChanges =
        (current.firstValue() ?? 0) != (a.firstValue() ?? 0) ||
        // Non bitflag attributes can have null values when not selected
        ((attributeInfo?.isStoredAsBitflagValue() ?? false) == false && current.firstValue() != a.firstValue()) ||
        current.secondValue() != a.secondValue();
      final isNumberListAttribute =
        attributeInfo?.isNumberListAttribute() ?? false;
      if (
        (!isNumberListAttribute && nonNumberListAttributeChanges) ||
        (isNumberListAttribute && !const SetEquality<int>().equals(current.values.toSet(), a.values.toSet()))
      ) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<MyProfileBloc, MyProfileData>(
      context: context,
      pageKey: widget.pageKey,
      child: BlocBuilder<EditMyProfileBloc, EditMyProfileData>(
        builder: (context, data) {
          return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
            builder: (context, profilePicturesData) {
              final dataEditingDetected = dataChanged(data, profilePicturesData);

              return PopScope(
                canPop: !dataEditingDetected,
                onPopInvoked: (didPop) {
                  if (didPop) {
                    return;
                  }
                  showConfirmDialog(context, context.strings.generic_save_confirmation_title, yesNoActions: true)
                    .then((value) {
                      if (value == true) {
                        validateAndSaveData(context);
                      } else if (value == false) {
                        MyNavigator.pop(context);
                      }
                    });
                },
                child: Scaffold(
                  appBar: AppBar(title: Text(context.strings.edit_profile_screen_title)),
                  body: edit(context, dataEditingDetected),
                  floatingActionButton: dataEditingDetected ? FloatingActionButton(
                    onPressed: () => validateAndSaveData(context),
                    child: const Icon(Icons.check),
                  ) : null
                ),
              );
            }
          );
        }
      ),
    );
  }

  Widget edit(BuildContext context, bool dataChanged) {
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
          if (dataChanged) const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
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
    Iterable<ProfileAttributeValueUpdate> myAttributes,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];
    final convertedAttributes = myAttributes.map((e) {
      final value = e.firstValue();
      if (value == null) {
        return null;
      } else {
        return ProfileAttributeValue(
          id: e.id,
          values: e.values,
        );
      }
    }).nonNulls;

    final l = AttributeAndValue.sortedListFrom(
      availableAttributes,
      convertedAttributes,
      includeNullAttributes: true,
    );
    for (final a in l) {
      attributeWidgets.add(
        EditAttributeRow(
          a: a,
          onStartEditor: () {
            MyNavigator.push(
              context,
              MaterialPage<void>(child: EditProfileAttributeScreen(a: a))
            );
          }
        )
      );
      attributeWidgets.add(const Divider());
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return attributeWidgets;
  }
}

class EditAttributeRow extends StatelessWidget {
  final AttributeInfoProvider a;
  final void Function() onStartEditor;
  final bool isEnabled;
  const EditAttributeRow({
    required this.a,
    required this.onStartEditor,
    this.isEnabled = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final attributeText = a.title(context);
    final icon = iconResourceToMaterialIcon(a.attribute.icon);
    if (icon == null) {
      return const SizedBox.shrink();
    }

    final void Function()? startEditorCallback;
    final Widget valueWidget;
    final TextStyle? titleStyle;
    final Color iconColor;
    if (isEnabled) {
      startEditorCallback = onStartEditor;
      valueWidget = AttributeValuesArea(a: a);
      titleStyle = Theme.of(context).textTheme.bodyLarge;
      iconColor = getIconButtonEnabledColor(context);
    } else {
      startEditorCallback = null;
      final disabledTextColor = Theme.of(context).disabledColor;
      valueWidget = Text(
        context.strings.generic_disabled,
        style: TextStyle(color: disabledTextColor),
      );
      titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(color: disabledTextColor);
      iconColor = getIconButtonDisabledColor(context);
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
                  child: Text(attributeText, style: titleStyle),
                ),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: IconWithIconButtonPadding(icon, iconColor: iconColor),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 8)),
                  Expanded(child: valueWidget),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconWithIconButtonPadding(Icons.edit_rounded, iconColor: iconColor),
        ),
      ],
    );

    return InkWell(
      onTap: startEditorCallback,
      child: attributeWidget,
    );
  }
}

abstract class AttributeInfoProvider {
  Attribute get attribute;
  ProfileAttributeValue? get value;

  String title(BuildContext context);
  List<AttributeValue> sortedSelectedValues();

  List<String> extraValues(BuildContext context);

  bool get isFilter;
}
