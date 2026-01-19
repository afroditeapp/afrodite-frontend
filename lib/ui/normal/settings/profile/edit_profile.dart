import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/account/client_features_config.dart';
import 'package:app/model/freezed/logic/account/client_features_config.dart';
import 'package:app/ui/normal/settings/profile/edit_profile_text.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/navigation/url.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/list.dart';
import 'package:app/utils/result.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/logic/media/profile_pictures.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/profile/my_profile.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/profile/my_profile.dart';
import 'package:app/ui/initial_setup/profile_basic_info.dart';
import 'package:app/ui/initial_setup/profile_pictures.dart';
import 'package:app/ui/normal/settings/profile/edit_profile_attribute.dart';
import 'package:app/ui/utils/view_profile.dart';
import 'package:app/ui_utils/common_update_logic.dart';
import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:app/ui_utils/icon_button.dart';
import 'package:app/ui_utils/snack_bar.dart';
import 'package:app/utils/age.dart';
import 'package:app/utils/profile_entry.dart';

class EditProfilePageUrlParser extends UrlParser<EditProfilePage> {
  final RepositoryInstances r;
  EditProfilePageUrlParser(this.r);

  @override
  Future<Result<(EditProfilePage, UrlSegments), ()>> parseFromSegments(
    UrlSegments urlSegments,
  ) async {
    final myProfile = await r.accountDb
        .accountStreamSingle((db) => db.myProfile.getProfileEntryForMyProfile())
        .ok();
    if (myProfile == null) {
      return Err(());
    }
    return Ok((EditProfilePage(myProfile), urlSegments.noArguments()));
  }
}

class EditProfilePage extends MyScreenPage<()> {
  EditProfilePage(MyProfileEntry initialProfile)
    : super(
        builder: (closer) =>
            EditProfileScreenOpener(closer: closer, initialProfile: initialProfile),
      );
}

class EditProfileScreenOpener extends StatelessWidget {
  final PageCloser<()> closer;
  final MyProfileEntry initialProfile;
  const EditProfileScreenOpener({required this.closer, required this.initialProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return EditProfileScreen(
      closer: closer,
      initialProfile: initialProfile,
      profilePicturesBloc: context.read<ProfilePicturesBloc>(),
      myProfileBloc: context.read<MyProfileBloc>(),
      profileAttributesBloc: context.read<ProfileAttributesBloc>(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final PageCloser<()> closer;
  final MyProfileEntry initialProfile;
  final ProfilePicturesBloc profilePicturesBloc;
  final MyProfileBloc myProfileBloc;
  final ProfileAttributesBloc profileAttributesBloc;
  const EditProfileScreen({
    required this.closer,
    required this.initialProfile,
    required this.profilePicturesBloc,
    required this.myProfileBloc,
    required this.profileAttributesBloc,
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();

    final p = widget.initialProfile;

    // Profile data
    widget.myProfileBloc.add(ResetEditedValues());

    // Profile pictures

    widget.profilePicturesBloc.add(ResetIfModeChanges(const NormalProfilePictures()));

    setImgToBloc(p.myContent.getAtOrNull(0), 0);
    widget.profilePicturesBloc.add(UpdateCropArea(p.primaryImageCropArea(), 0));

    setImgToBloc(p.myContent.getAtOrNull(1), 1);
    setImgToBloc(p.myContent.getAtOrNull(2), 2);
    setImgToBloc(p.myContent.getAtOrNull(3), 3);
    widget.profilePicturesBloc.add(NewPageKeyForProfilePicturesBloc(widget.closer.key));
  }

  void setImgToBloc(MyContent? c, int index) {
    if (c == null) {
      widget.profilePicturesBloc.add(RemoveImage(index));
      return;
    }
    final imgId = AccountImageId(widget.initialProfile.accountId, c.id, c.faceDetected, c.accepted);
    widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(imgId, null), index));
  }

  void validateAndSaveData(BuildContext context) {
    final s = widget.myProfileBloc.state;
    final age = s.valueAge();
    if (age == null || !ageIsValid(age)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_age);
      return;
    }

    final name = s.valueName();
    if (name == null || !nameIsValid(context, name)) {
      showSnackBar(context.strings.edit_profile_screen_invalid_profile_name);
      return;
    }

    final editedProfileText = s.valueProfileText()?.trim() ?? "";
    final String? newProfileText;
    if (editedProfileText.isEmpty) {
      newProfileText = null;
    } else {
      newProfileText = editedProfileText;
    }

    final imgUpdateState = widget.profilePicturesBloc.state;
    final imgUpdate = imgUpdateState.toSetProfileContent();
    if (imgUpdate == null) {
      showSnackBar(context.strings.edit_profile_screen_one_profile_image_required);
      return;
    }

    if (!imgUpdateState.faceDetectedFromPrimaryImage()) {
      showSnackBar(
        context.strings.initial_setup_screen_profile_pictures_primary_image_face_not_detected,
      );
      return;
    }

    context.read<MyProfileBloc>().add(
      SetProfile(
        ProfileUpdate(
          age: age,
          name: name,
          ptext: newProfileText,
          attributes: s.valueAttributeIdAndStateMap().values.toList(),
        ),
        imgUpdate,
        unlimitedLikes: s.valueUnlimitedLikes(),
      ),
    );
  }

  bool dataChanged(MyProfileData myProfileData, ProfilePicturesData editedImgData) {
    if (myProfileData.unsavedChanges()) {
      return true;
    }

    final currentState = widget.initialProfile;
    final editedImgs = editedImgData.toSetProfileContent();
    if (editedImgs == null ||
        currentState.content.firstOrNull?.id != editedImgs.c.firstOrNull ||
        currentState.content.getAtOrNull(1)?.id != editedImgs.c.getAtOrNull(1) ||
        currentState.content.getAtOrNull(2)?.id != editedImgs.c.getAtOrNull(2) ||
        currentState.content.getAtOrNull(3)?.id != editedImgs.c.getAtOrNull(3) ||
        currentState.content.getAtOrNull(4)?.id != editedImgs.c.getAtOrNull(4) ||
        currentState.content.getAtOrNull(5)?.id != editedImgs.c.getAtOrNull(5) ||
        currentState.primaryContentGridCropSize != editedImgs.gridCropSize ||
        currentState.primaryContentGridCropX != editedImgs.gridCropX ||
        currentState.primaryContentGridCropY != editedImgs.gridCropY) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return updateStateHandler<MyProfileBloc, MyProfileData>(
      context: context,
      pageKey: widget.closer.key,
      child: BlocBuilder<MyProfileBloc, MyProfileData>(
        builder: (context, data) {
          return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
            builder: (context, profilePicturesData) {
              // PageKey check prevent Flutter from hiding
              // my profile screen's floating action button after
              // pressing this screen's save changes floating action button
              // the first time after app launch.
              final dataEditingDetected =
                  profilePicturesData.pageKey == widget.closer.key &&
                  dataChanged(data, profilePicturesData);

              return PopScope(
                canPop: !dataEditingDetected,
                onPopInvokedWithResult: (didPop, _) {
                  if (didPop) {
                    return;
                  }
                  showConfirmDialog(
                    context,
                    context.strings.generic_save_confirmation_title,
                    yesNoActions: true,
                  ).then((value) {
                    if (!context.mounted) {
                      return;
                    }
                    if (value == true) {
                      validateAndSaveData(context);
                      // updateStateHandler closes EditProfileScreen
                    } else if (value == false) {
                      widget.closer.close(context, ());
                    }
                  });
                },
                child: Scaffold(
                  appBar: AppBar(title: Text(context.strings.edit_profile_screen_title)),
                  body: edit(context, dataEditingDetected),
                  floatingActionButton: dataEditingDetected
                      ? FloatingActionButton(
                          onPressed: () => validateAndSaveData(context),
                          child: const Icon(Icons.check),
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget edit(BuildContext context, bool dataChanged) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfilePictureSelection(profilePicturesBloc: context.read<ProfilePicturesBloc>()),
          const Padding(padding: EdgeInsets.only(top: 16)),
          const Divider(),
          const Padding(padding: EdgeInsets.only(top: 8)),
          EditProfileBasicInfo(
            initialProfile: widget.initialProfile,
            setterProfileName: (value) {
              widget.myProfileBloc.add(NewName(value));
            },
            ageInitialValue: widget.initialProfile.age,
            setterProfileAge: (value) {
              widget.myProfileBloc.add(NewAge(value));
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          const Divider(),
          unlimitedLikesSetting(context),
          const Divider(),
          EditProfileText(initialProfile: widget.initialProfile),
          const Divider(),
          const EditAttributes(),
          const Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA)),
        ],
      ),
    );
  }

  Widget unlimitedLikesSetting(BuildContext context) {
    return BlocBuilder<ClientFeaturesConfigBloc, ClientFeaturesConfigData>(
      builder: (context, clientFeatures) {
        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, myProfileData) {
            final String? subtitle;
            if (myProfileData.valueUnlimitedLikes()) {
              final resetTime = clientFeatures.unlimitedLikesResetTime();
              if (resetTime != null) {
                subtitle = context.strings
                    .edit_profile_screen_unlimited_likes_description_enabled_and_automatic_disabling(
                      resetTime.uiString(),
                    );
              } else {
                subtitle = null;
              }
            } else {
              subtitle = null;
            }
            return SwitchListTile(
              title: Text(context.strings.edit_profile_screen_unlimited_likes),
              subtitle: subtitle != null ? Text(subtitle) : null,
              secondary: Icon(UNLIMITED_LIKES_ICON, color: getUnlimitedLikesColor(context)),
              value: myProfileData.valueUnlimitedLikes(),
              onChanged: (bool value) =>
                  context.read<MyProfileBloc>().add(NewUnlimitedLikesValue(value)),
            );
          },
        );
      },
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

        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, myProfileData) {
            return Column(
              children: attributeTiles(
                context,
                manager,
                myProfileData.valueAttributeIdAndStateMap(),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> attributeTiles(
    BuildContext context,
    AttributeManager manager,
    Map<int, ProfileAttributeValueUpdate> myAttributes,
  ) {
    final List<Widget> attributeWidgets = <Widget>[];

    final l = manager.parseStates(myAttributes, includeNullAttributes: true);
    for (final a in l) {
      attributeWidgets.add(
        EditAttributeRow(
          a: a,
          onStartEditor: () => MyNavigator.pushLimited(context, EditProfileAttributePage(a)),
        ),
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
    super.key,
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
              if (valueWidget != null)
                Row(
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

    return InkWell(onTap: startEditorCallback, child: attributeWidget);
  }
}

class ViewAttributeTitle extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final IconData? icon;
  final Widget Function(Color? disabledColor)? iconWidgetBuilder;
  final String? valueText;
  const ViewAttributeTitle(
    this.text, {
    this.isEnabled = true,
    this.icon,
    this.iconWidgetBuilder,
    this.valueText,
    super.key,
  });

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
    final currentValueText = valueText;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: disabledColor),
              ),
            if (currentIconWidgetBuilder != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: currentIconWidgetBuilder(disabledColor),
              ),
            Text(text, style: titleStyle),
            if (currentValueText != null) const Spacer(),
            if (currentValueText != null) Text(currentValueText),
          ],
        ),
      ),
    );
  }
}

class EditProfileBasicInfo extends StatefulWidget {
  final MyProfileEntry initialProfile;
  final void Function(String) setterProfileName;
  final int? ageInitialValue;
  final void Function(int?) setterProfileAge;
  const EditProfileBasicInfo({
    required this.initialProfile,
    required this.setterProfileName,
    required this.ageInitialValue,
    required this.setterProfileAge,
    super.key,
  });

  @override
  State<EditProfileBasicInfo> createState() => _EditProfileBasicInfoState();
}

class _EditProfileBasicInfoState extends State<EditProfileBasicInfo> {
  final nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextController.text = widget.initialProfile.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.initialProfile.nameAccepted) hPad(profileName(context)),
        if (!widget.initialProfile.nameAccepted) const Padding(padding: EdgeInsets.only(top: 8)),
        if (!widget.initialProfile.nameAccepted) Divider(),
        if (!widget.initialProfile.nameAccepted) const Padding(padding: EdgeInsets.only(top: 8)),
        hPad(age(context)),
      ],
    );
  }

  Widget profileName(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.edit_profile_screen_profile_name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        profileNameTextField(
          context,
          controller: nameTextController,
          onChanged: widget.setterProfileName,
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Text(context.strings.edit_profile_screen_profile_name_description),
        const Padding(padding: EdgeInsets.only(top: 8)),
        ProfileNameRejectionWidget(initialProfile: widget.initialProfile),
      ],
    );
  }

  Widget age(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.strings.generic_age, style: Theme.of(context).textTheme.bodyLarge),
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
              if (nextAutomaticAgeChange != null)
                IconButton(
                  onPressed: () {
                    showInfoDialog(
                      context,
                      context.strings
                          .edit_profile_screen_automatic_min_age_incrementing_info_dialog_text(
                            nextAutomaticAgeChange.age.toString(),
                            nextAutomaticAgeChange.year.toString(),
                          ),
                    );
                  },
                  icon: const Icon(Icons.info),
                ),
            ],
          );
        }
      },
    );
  }

  Widget ageSelection(BuildContext context, AvailableAges info) {
    return DropdownMenu<int>(
      initialSelection: widget.ageInitialValue,
      dropdownMenuEntries: info.availableAges.map((value) {
        return DropdownMenuEntry<int>(value: value, label: value.toString());
      }).toList(),
      onSelected: (value) {
        if (value != null) {
          widget.setterProfileAge(value);
        }
      },
    );
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }
}

class EditProfileText extends StatefulWidget {
  final MyProfileEntry initialProfile;
  const EditProfileText({required this.initialProfile, super.key});

  @override
  State<EditProfileText> createState() => _EditProfileTextState();
}

class _EditProfileTextState extends State<EditProfileText> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, state) {
        return content(context, state.valueProfileText());
      },
    );
  }

  Widget content(BuildContext context, String? currentText) {
    final currentText = context.read<MyProfileBloc>().state.valueProfileText();
    final String? displayedText;
    if (currentText == null || currentText.isEmpty) {
      displayedText = null;
    } else {
      displayedText = currentText;
    }

    final r = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                if (displayedText != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Text(displayedText),
                  ),
                ProfileTextRejectionWidget(initialProfile: widget.initialProfile),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: IconWithIconButtonPadding(
            Icons.edit_rounded,
            iconColor: getIconButtonEnabledColor(context),
          ),
        ),
      ],
    );

    return InkWell(
      onTap: () => openEditProfileText(context, context.read<MyProfileBloc>()),
      child: r,
    );
  }
}

class ProfileNameRejectionWidget extends StatelessWidget {
  final MyProfileEntry initialProfile;
  const ProfileNameRejectionWidget({required this.initialProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, myProfileState) {
        final profile = myProfileState.profile ?? initialProfile;
        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, state) {
            if (isRejectedState(profile.profileNameModerationState) &&
                state.valueName() == profile.name) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  getProfileNameRejectionInfoText(
                    context,
                    profile.profileNameModerationState,
                    profile.profileNameModerationRejectedCategory?.value,
                    profile.profileNameModerationRejectedDetails?.value,
                    includeBaseText: false,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}

class ProfileTextRejectionWidget extends StatelessWidget {
  final MyProfileEntry initialProfile;
  const ProfileTextRejectionWidget({required this.initialProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfileBloc, MyProfileData>(
      builder: (context, myProfileState) {
        final profile = myProfileState.profile ?? initialProfile;
        return BlocBuilder<MyProfileBloc, MyProfileData>(
          builder: (context, state) {
            if (!profile.profileTextAccepted &&
                isRejectedState(profile.profileTextModerationState) &&
                state.valueProfileText() == profile.profileText) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    getProfileTextRejectionInfoText(
                      context,
                      profile.profileTextModerationState,
                      profile.profileTextModerationRejectedCategory?.value,
                      profile.profileTextModerationRejectedDetails?.value,
                      includeBaseText: false,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
