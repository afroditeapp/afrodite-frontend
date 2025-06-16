

import 'package:app/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/ui/normal/settings/profile/edit_profile_text.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/utils/list.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/edit_my_profile.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/edit_my_profile.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/initial_setup/profile_basic_info.dart';
import 'package:app/ui/initial_setup/profile_pictures.dart';
import 'package:app/ui/normal/settings/profile/edit_profile_attribute.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/icon_button.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/age.dart';
import 'package:app/utils/profile_entry.dart';

class EditProfilePage extends StatefulWidget {
  final PageKey pageKey;
  final MyProfileEntry initialProfile;
  final ProfilePicturesBloc profilePicturesBloc;
  final EditMyProfileBloc editMyProfileBloc;
  final ProfileAttributesBloc profileAttributesBloc;
  const EditProfilePage({
    required this.pageKey,
    required this.initialProfile,
    required this.profilePicturesBloc,
    required this.editMyProfileBloc,
    required this.profileAttributesBloc,
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  @override
  void initState() {
    super.initState();

    final p = widget.initialProfile;

    // Profile data
    widget.editMyProfileBloc.add(SetInitialValues(p));

    // Profile pictures

    widget.profilePicturesBloc.add(ResetIfModeChanges(const NormalProfilePictures()));

    setImgToBloc(p.myContent.getAtOrNull(0), 0);
    widget.profilePicturesBloc.add(UpdateCropResults(p.primaryImageCropInfo(), 0));

    setImgToBloc(p.myContent.getAtOrNull(1), 1);
    setImgToBloc(p.myContent.getAtOrNull(2), 2);
    setImgToBloc(p.myContent.getAtOrNull(3), 3);
  }

  void setImgToBloc(MyContent? c, int index) {
    if (c == null) {
      widget.profilePicturesBloc.add(RemoveImage(index));
      return;
    }
    final imgId = AccountImageId(widget.initialProfile.uuid, c.id, c.faceDetected, c.accepted);
    widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(imgId, null), index));
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.editMyProfileBloc.state;
    final age = s.age;
    if (age == null || !ageIsValid(age)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_age);
      return;
    }

    final name = s.name;
    if (name == null || !nameIsValid(name)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_first_name);
      return;
    }

    final profileText = s.profileText ?? "";

    final imgUpdateState = widget.profilePicturesBloc.state;
    final imgUpdate = imgUpdateState.toSetProfileContent();
    if (imgUpdate == null) {
      showSnackBar(context.strings.edit_profile_screen_one_profile_image_required);
      return;
    }

    if (!imgUpdateState.faceDetectedFromPrimaryImage()) {
      showSnackBar(context.strings.initial_setup_screen_profile_pictures_primary_image_face_not_detected);
      return;
    }

    context.read<MyProfileBloc>().add(SetProfile(
      ProfileUpdate(
        age: age,
        name: name,
        ptext: profileText,
        attributes: s.attributeIdAndStateMap.values.toList(),
      ),
      imgUpdate,
      unlimitedLikes: s.unlimitedLikes,
    ));
  }

  bool dataChanged(EditMyProfileData editedData, ProfilePicturesData editedImgData) {
    final currentState = widget.initialProfile;
    if (
      currentState.age != editedData.age ||
      currentState.name != editedData.name ||
      currentState.profileText != editedData.profileText ||
      currentState.unlimitedLikes != editedData.unlimitedLikes
    ) {
      return true;
    }

    final editedImgs = editedImgData.toSetProfileContent();
    if (
      editedImgs == null ||
      currentState.content.firstOrNull?.id != editedImgs.c.firstOrNull ||
      currentState.content.getAtOrNull(1)?.id != editedImgs.c.getAtOrNull(1)||
      currentState.content.getAtOrNull(2)?.id != editedImgs.c.getAtOrNull(2) ||
      currentState.content.getAtOrNull(3)?.id != editedImgs.c.getAtOrNull(3) ||
      currentState.content.getAtOrNull(4)?.id != editedImgs.c.getAtOrNull(4) ||
      currentState.content.getAtOrNull(5)?.id != editedImgs.c.getAtOrNull(5) ||
      currentState.primaryContentGridCropSize != editedImgs.gridCropSize ||
      currentState.primaryContentGridCropX != editedImgs.gridCropX ||
      currentState.primaryContentGridCropY != editedImgs.gridCropY
    ) {
      return true;
    }

    final originalAttributes = currentState.attributeIdAndStateMap.values.toList();
    final modifiedAttributes = { ...editedData.attributeIdAndStateMap };
    for (final a in originalAttributes) {
      final removed = modifiedAttributes.remove(a.id);
      if (removed == null) {
        // The modified attributes should contain all attributes
        // from original as those are needed when removing an attribute.
        // ProfileAttributeValueUpdate with empty list removes the attribute.
        continue;
      }
      if (!listEquals(a.v, removed.v)) {
        return true;
      }
    }
    for (final a in modifiedAttributes.values) {
      if (a.v.isNotEmpty) {
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
          const Padding(padding: EdgeInsets.only(top: 16)),
          const Divider(),
          const Padding(padding: EdgeInsets.only(top: 8)),
          EditProfileBasicInfo(
            ageInitialValue: widget.initialProfile.age,
            setterProfileAge: (value) {
              widget.editMyProfileBloc.add(NewAge(value));
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          const Divider(),
          const EditProfileText(),
          const Divider(),
          const EditAttributes(),
          const Divider(),
          unlimitedLikesSetting(context),
          const Padding(
            padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA),
            child: null,
          ),
        ],
      ),
    );
  }

  Widget unlimitedLikesSetting(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, clientFeatures) {
        return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(builder: (context, myProfileData) {
          final String subtitle;
          if (myProfileData.unlimitedLikes) {
            final resetTime = clientFeatures.unlimitedLikesResetTime();
            if (resetTime != null) {
              subtitle = context.strings.edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(resetTime.uiString());
            } else {
              subtitle = context.strings.edit_profile_screen_unlimited_likes_description_enabled;
            }
          } else {
            subtitle = context.strings.edit_profile_screen_unlimited_likes_description_disabled;
          }
          return SwitchListTile(
            title: Text(context.strings.edit_profile_screen_unlimited_likes),
            subtitle: Text(subtitle),
            isThreeLine: true,
            secondary: Icon(
              UNLIMITED_LIKES_ICON,
              color: getUnlimitedLikesColor(context),
            ),
            value: myProfileData.unlimitedLikes,
            onChanged: (bool value) =>
              context.read<EditMyProfileBloc>().add(NewUnlimitedLikesValue(value)),
          );
        });
      }
    );
  }
}

class EditAttributes extends StatelessWidget {
  const EditAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, data) {
        final manager = data.manager;
        if (manager == null) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(builder: (context, myProfileData) {
          return Column(
            children: attributeTiles(context, manager, myProfileData.attributeIdAndStateMap)
          );
        });
      },
    );
  }

  List<Widget> attributeTiles(
    BuildContext context,
    AttributeManager manager,
    Map<int, ProfileAttributeValueUpdate> myAttributes,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];

    final l = manager.parseStates(
      myAttributes,
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
  final AttributeValueAreaInfoProvider a;
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
    final attributeText = a.attribute().uiName();
    final icon = a.attribute().uiIcon();

    final void Function()? startEditorCallback;
    final Widget? valueWidget;
    final Color iconColor;
    if (isEnabled) {
      startEditorCallback = onStartEditor;
      if (a.isEmpty()) {
        valueWidget = null;
      } else {
        valueWidget = AttributeValuesArea(a: a, isFilter: false);
      }
      iconColor = getIconButtonEnabledColor(context);
    } else {
      startEditorCallback = null;
      valueWidget = null;
      iconColor = getIconButtonDisabledColor(context);
    }

    final attributeWidget = Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(4)),
              ViewAttributeTitle(attributeText, isEnabled: isEnabled, icon: icon),
              const Padding(padding: EdgeInsets.all(4)),
              if (valueWidget != null) Row(
                children: [
                  const SizedBox(height: 48),
                  const Padding(padding: EdgeInsets.only(right: 16)),
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

class ViewAttributeTitle extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final IconData? icon;
  final Widget Function(Color? disabledColor)? iconWidgetBuilder;
  const ViewAttributeTitle(this.text, {this.isEnabled = true, this.icon, this.iconWidgetBuilder, super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? titleStyle;
    final Color? disabledColor;
    if (isEnabled) {
      titleStyle = Theme.of(context).textTheme.bodyLarge;
      disabledColor = null;
    } else {
      disabledColor = Theme.of(context).disabledColor;
      titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(color: disabledColor);
    }
    final currentIconWidgetBuilder = iconWidgetBuilder;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: COMMON_SCREEN_EDGE_PADDING),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: disabledColor),
            ),
            if (currentIconWidgetBuilder != null) Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: currentIconWidgetBuilder(disabledColor),
            ),
            Text(text, style: titleStyle),
          ],
        ),
      ),
    );
  }
}

class EditProfileBasicInfo extends StatefulWidget {
  final int? ageInitialValue;
  final void Function(int?) setterProfileAge;
  const EditProfileBasicInfo({
    required this.ageInitialValue,
    required this.setterProfileAge,
    super.key,
  });

  @override
  State<EditProfileBasicInfo> createState() => _EditProfileBasicInfoState();
}

class _EditProfileBasicInfoState extends State<EditProfileBasicInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: INITIAL_SETUP_PADDING),
              child: askInfo(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget askInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.initial_setup_screen_profile_basic_info_age_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        ageSelectionOrError(),
      ],
    );
  }

  Widget ageSelectionOrError() {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, state) {
        final info = state.initialAgeInfo;
        if (info == null) {
          return Text(context.strings.generic_error);
        } else {
          final availableAges = info.availableAges(MAX_AGE);
          final nextAutomaticAgeChange = availableAges.nextAutomaticAgeChange;
          return Row(
            children: [
              ageSelection(context, availableAges),
              if (nextAutomaticAgeChange != null) IconButton(
                onPressed: () {
                  showInfoDialog(
                    context,
                    context.strings.edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(
                      nextAutomaticAgeChange.age.toString(),
                      nextAutomaticAgeChange.year.toString(),
                    )
                  );
                },
                icon: const Icon(Icons.info),
              )
            ]
          );
        }
      }
    );
  }

  Widget ageSelection(BuildContext context, AvailableAges info) {
    return DropdownMenu<int>(
      initialSelection: widget.ageInitialValue,
      dropdownMenuEntries: info.availableAges
        .map((value) {
          return DropdownMenuEntry<int>(
            value: value,
            label: value.toString(),
          );
        })
        .toList(),
      onSelected: (value) {
        if (value != null) {
          widget.setterProfileAge(value);
        }
      },
    );
  }
}

class EditProfileText extends StatefulWidget {
  const EditProfileText({
    super.key,
  });

  @override
  State<EditProfileText> createState() => _EditProfileTextState();
}

class _EditProfileTextState extends State<EditProfileText> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyProfileBloc, EditMyProfileData>(
      builder: (context, state) {
        return content(context, state.profileText);
      },
    );
  }

  Widget content(BuildContext context, String? currentText) {
    final currentText = context.read<EditMyProfileBloc>().state.profileText;
    final String? displayedText;
    if (currentText == null || currentText.isEmpty) {
      displayedText = null;
    } else {
      displayedText = currentText;
    }

    final r = Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(4)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.notes),
                    const Padding(padding: EdgeInsets.all(4)),
                    Text(
                      context.strings.edit_profile_screen_profile_text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              if (displayedText != null) Row(
                children: [
                  const SizedBox(height: 44),
                  const Padding(padding: EdgeInsets.only(right: 16)),
                  Expanded(child: Text(displayedText)),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconWithIconButtonPadding(Icons.edit_rounded, iconColor: getIconButtonEnabledColor(context)),
        ),
      ],
    );

    return InkWell(
      onTap: () => openEditProfileText(context, context.read<EditMyProfileBloc>()),
      child: r,
    );
  }
}
