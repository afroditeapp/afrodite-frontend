import 'package:app/ui_utils/consts/colors.dart';
import 'package:app/ui_utils/consts/icons.dart';
import 'package:app/ui_utils/extensions/api.dart';
import 'package:app/ui_utils/attribute/attribute.dart';
import 'package:app/ui_utils/attribute/state.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/moderation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:app/ui_utils/consts/size.dart';
import 'package:app/ui_utils/dialog.dart';
import 'package:utils/utils.dart';
import 'package:app/data/image_cache.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/profile/attributes.dart';
import 'package:app/logic/settings/privacy_settings.dart';
import 'package:app/model/freezed/logic/profile/attributes.dart';
import 'package:app/model/freezed/logic/settings/privacy_settings.dart';
import 'package:app/ui/normal/settings/profile/edit_profile.dart';
import 'package:app/ui_utils/consts/corners.dart';
import 'package:app/ui_utils/consts/padding.dart';

const double VIEW_PROFILE_WIDGET_IMG_HEIGHT = 400;

// TODO(quality): Check that IconButtons have tooltips

class ViewProfileEntry extends StatefulWidget {
  final ProfileEntry profile;
  final bool isMyProfile;
  const ViewProfileEntry({required this.profile, required this.isMyProfile, super.key});

  @override
  State<ViewProfileEntry> createState() => _ViewProfileEntryState();
}

class _ViewProfileEntryState extends State<ViewProfileEntry> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final profileText = widget.profile.profileText;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: VIEW_PROFILE_WIDGET_IMG_HEIGHT,
                width: constraints.maxWidth,
                child: ViewProfileImgViewer(
                  profile: widget.profile,
                  showNonAcceptedImages: widget.profile is MyProfileEntry,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              title(context),
              if (!widget.isMyProfile) const Padding(padding: EdgeInsets.only(top: 8)),
              if (!widget.isMyProfile)
                BlocBuilder<PrivacySettingsBloc, PrivacySettingsData>(
                  builder: (context, privacyState) {
                    return lastSeenTime(context, privacyState);
                  },
                ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              if (profileText != null) profileTextWidget(context, profileText),
              if (profileText != null) const Padding(padding: EdgeInsets.only(top: 16)),
              attributes(),
              const Padding(padding: EdgeInsets.only(top: FLOATING_ACTION_BUTTON_EMPTY_AREA)),
            ],
          ),
        );
      },
    );
  }

  Widget title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.profile.profileTitleWithAge(
                      showNonAcceptedProfileNames: widget.isMyProfile,
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (!widget.profile.nameAccepted) nameNotAcceptedInfoButton(context),
              ],
            ),
          ),
          if (widget.profile.unlimitedLikes)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(UNLIMITED_LIKES_ICON, color: getUnlimitedLikesColor(context)),
            ),
          if (widget.profile.containsNonAcceptedContent())
            profileContentNotAcceptedInfoButton(context),
        ],
      ),
    );
  }

  Widget nameNotAcceptedInfoButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        final state = widget.profile is MyProfileEntry
            ? (widget.profile as MyProfileEntry).profileNameModerationState
            : null;
        final infoText = getProfileNameRejectionInfoText(context, state);
        showInfoDialog(context, infoText);
      },
      icon: const Icon(Icons.info),
    );
  }

  Widget profileContentNotAcceptedInfoButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        var infoText =
            context.strings.view_profile_screen_non_accepted_profile_content_info_dialog_text;
        final profile = widget.profile;
        if (profile is MyProfileEntry) {
          for (final (i, c) in profile.myContent.indexed) {
            if (c.accepted) {
              continue;
            }
            infoText =
                "$infoText\n\n${context.strings.view_profile_screen_non_accepted_profile_content_info_dialog_text_picture_title((i + 1).toString())}";
            infoText = addModerationStateRow(
              context,
              infoText,
              c.state.toUiString(context).toString(),
            );
            infoText = addRejectedCategoryRow(context, infoText, c.rejectedCategory?.value);
            infoText = addRejectedDetailsRow(context, infoText, c.rejectedDetails?.value);
          }
        }
        showInfoDialog(context, infoText, scrollable: true);
      },
      icon: const Icon(Icons.info),
    );
  }

  Widget profileTextWidget(BuildContext context, String profileText) {
    final double rightPadding;
    if (widget.profile.profileTextAccepted) {
      rightPadding = COMMON_SCREEN_EDGE_PADDING;
    } else {
      rightPadding = 0;
    }

    return Padding(
      padding: EdgeInsets.only(left: COMMON_SCREEN_EDGE_PADDING, right: rightPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.profile.profileTextOrFirstCharacterProfileText(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          if (!widget.profile.profileTextAccepted)
            IconButton(
              onPressed: () {
                final myProfile = widget.profile is MyProfileEntry
                    ? widget.profile as MyProfileEntry
                    : null;
                final infoText = getProfileTextRejectionInfoText(
                  context,
                  myProfile?.profileTextModerationState,
                  myProfile?.profileTextModerationRejectedCategory?.value,
                  myProfile?.profileTextModerationRejectedDetails?.value,
                );
                showInfoDialog(context, infoText);
              },
              icon: const Icon(Icons.info),
            ),
        ],
      ),
    );
  }

  Widget lastSeenTime(BuildContext context, PrivacySettingsData privacySettings) {
    final lastSeenTime = widget.profile.lastSeenTimeValue;
    final List<Widget> widgets;
    if (lastSeenTime == null ||
        lastSeenTime < -1 ||
        (widget.profile.lastSeenTimeValue == -1 && !privacySettings.onlineStatus) ||
        (widget.profile.lastSeenTimeValue != null &&
            widget.profile.lastSeenTimeValue! >= 0 &&
            !privacySettings.lastSeenTime)) {
      return const SizedBox.shrink();
    } else if (widget.profile.lastSeenTimeValue == -1) {
      widgets = [
        Container(
          padding: const EdgeInsets.all(8),
          width: PROFILE_CURRENTLY_ONLINE_SIZE,
          height: PROFILE_CURRENTLY_ONLINE_SIZE,
          decoration: BoxDecoration(
            color: PROFILE_CURRENTLY_ONLINE_COLOR,
            borderRadius: BorderRadius.circular(PROFILE_CURRENTLY_ONLINE_RADIUS),
          ),
        ),
        const Padding(padding: EdgeInsets.only(right: 8)),
        Text(
          context.strings.view_profile_screen_profile_currently_online,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ];
    } else {
      final currentDateTime = UtcDateTime.now();
      final lastSeenDateTime = UtcDateTime.fromUnixEpochMilliseconds(lastSeenTime * 1000);
      final lastSeenDuration = currentDateTime.difference(lastSeenDateTime);
      final String text;
      if (lastSeenDuration.inDays == 1) {
        text = context.strings.view_profile_screen_profile_last_seen_day(1.toString());
      } else if (lastSeenDuration.inDays > 1) {
        text = context.strings.view_profile_screen_profile_last_seen_days(
          lastSeenDuration.inDays.toString(),
        );
      } else if (lastSeenDuration.inHours == 1) {
        text = context.strings.view_profile_screen_profile_last_seen_hour(1.toString());
      } else if (lastSeenDuration.inHours > 1) {
        text = context.strings.view_profile_screen_profile_last_seen_hours(
          lastSeenDuration.inHours.toString(),
        );
      } else if (lastSeenDuration.inMinutes == 1) {
        text = context.strings.view_profile_screen_profile_last_seen_minute(1.toString());
      } else if (lastSeenDuration.inMinutes > 1) {
        text = context.strings.view_profile_screen_profile_last_seen_minutes(
          lastSeenDuration.inMinutes.toString(),
        );
      } else if (lastSeenDuration.inSeconds == 0) {
        text = context.strings.view_profile_screen_profile_last_seen_seconds(
          lastSeenDuration.inSeconds.toString(),
        );
      } else if (lastSeenDuration.inSeconds == 1) {
        text = context.strings.view_profile_screen_profile_last_seen_second(1.toString());
      } else {
        text = context.strings.view_profile_screen_profile_last_seen_seconds(
          lastSeenDuration.inSeconds.toString(),
        );
      }

      widgets = [Text(text, style: Theme.of(context).textTheme.titleSmall)];
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
        child: Row(children: widgets),
      ),
    );
  }

  Widget attributes() {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, state) {
        final manager = state.manager;
        if (manager == null) {
          return const SizedBox.shrink();
        } else {
          return AttributeList(manager: manager, attributes: widget.profile.attributeIdAndStateMap);
        }
      },
    );
  }
}

class ViewProfileImgViewer extends StatefulWidget {
  final ProfileEntry profile;
  final bool showNonAcceptedImages;
  const ViewProfileImgViewer({
    required this.profile,
    required this.showNonAcceptedImages,
    super.key,
  });

  @override
  State<ViewProfileImgViewer> createState() => _ViewProfileImgViewerState();
}

class _ViewProfileImgViewerState extends State<ViewProfileImgViewer> {
  int selectedImg = 0;

  List<ContentIdAndAccepted> contentList = [];

  final PageController pageController = PageController(keepPage: false);

  @override
  void initState() {
    super.initState();

    contentList = widget.profile.content;
  }

  @override
  void didUpdateWidget(covariant ViewProfileImgViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.profile != widget.profile) {
      contentList = widget.profile.content;
      selectedImg = 0;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imgs = [];
    for (int i = 0; i < contentList.length; i++) {
      if (!widget.showNonAcceptedImages && !contentList[i].accepted) {
        continue;
      }
      imgs.add(viewProifleImage(context, widget.profile.accountId, contentList[i].id));
    }

    if (imgs.isEmpty) {
      return Center(child: Text(context.strings.generic_empty));
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Load all profile images to image cache to avoid flickering
        // when changing to the next image.
        ...imgs.map((image) => Visibility(visible: false, maintainState: true, child: image)),
        PageView(
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              selectedImg = index;
            });
          },
          children: imgs,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SelectedImgIndicator(selectedImg: selectedImg, imgCount: imgs.length),
        ),
        touchArea(imgs.length),
      ],
    );
  }

  Widget touchArea(int visibleImagesCount) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImg > 0) {
                  selectedImg--;
                  if (pageController.hasClients) {
                    pageController.jumpToPage(selectedImg);
                  }
                }
              });
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImg < visibleImagesCount - 1) {
                  selectedImg++;
                  if (pageController.hasClients) {
                    pageController.jumpToPage(selectedImg);
                  }
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget viewProifleImage(BuildContext context, AccountId accountId, ContentId contentId) {
    return accountImgWidget(
      context,
      accountId,
      contentId,
      cacheSize: PrecacheImageForViewProfileScreen.cacheSizeForViewProfileScreenImages(context),
    );
  }
}

class SelectedImgIndicator extends StatelessWidget {
  final int selectedImg;
  final int imgCount;
  const SelectedImgIndicator({required this.selectedImg, required this.imgCount, super.key});

  @override
  Widget build(BuildContext context) {
    return indicator();
  }

  Widget indicator() {
    final List<Widget> indicators = [];
    for (int i = 0; i < imgCount; i++) {
      final oneIndicator = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 20,
          height: 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            color: i == selectedImg ? Colors.white.withAlpha(150) : Colors.grey.withAlpha(150),
          ),
        ),
      );
      indicators.add(oneIndicator);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: indicators);
  }
}

class AttributeList extends StatelessWidget {
  final AttributeManager manager;
  final Map<int, ProfileAttributeValueUpdate> attributes;
  const AttributeList({required this.manager, required this.attributes, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> attributeWidgets = <Widget>[];

    final l = manager.parseStates(attributes);
    for (final a in l) {
      attributeWidgets.add(attributeWidget(context, a));
      attributeWidgets.add(const Padding(padding: EdgeInsets.only(top: 8)));
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return Column(children: attributeWidgets);
  }

  Widget attributeWidget(BuildContext context, AttributeAndState a) {
    final attributeText = a.attribute().uiName();
    final icon = a.attribute().uiIcon();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(4)),
        ViewAttributeTitle(attributeText, icon: icon),
        const Padding(padding: EdgeInsets.all(4)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
          child: AttributeValuesArea(a: a, isFilter: false),
        ),
      ],
    );
  }
}

class AttributeValuesArea extends StatelessWidget {
  final AttributeValueAreaInfoProvider a;
  final bool isFilter;
  const AttributeValuesArea({required this.a, required this.isFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return attributeValuesArea(context, a);
  }

  Widget attributeValuesArea(BuildContext c, AttributeValueAreaInfoProvider a) {
    final List<Widget> valueWidgets = [];
    for (final v in a.valueAreaExtraValues()) {
      final w = Chip(label: Text(v));
      valueWidgets.add(w);
    }

    for (final v in a.valueAreaSelectedValues()) {
      final text = v.uiName();
      final iconData = v.uiIcon();
      final Widget? avatar;
      if (iconData != null) {
        avatar = Icon(iconData);
      } else {
        avatar = null;
      }
      final w = Chip(
        avatar: avatar,
        label: Text(text),
        backgroundColor: a.valueAreaSelectedAlternativeColor()
            ? Theme.of(c).colorScheme.primaryContainer
            : null,
      );
      valueWidgets.add(w);
    }

    for (final v in a.valueAreaUnwantedValues()) {
      final text = v.uiName();
      final iconData = v.uiIcon();
      final Widget? avatar;
      if (iconData != null) {
        avatar = Icon(iconData);
      } else {
        avatar = null;
      }
      final w = Chip(
        avatar: avatar,
        label: Text(text),
        backgroundColor: Theme.of(c).colorScheme.errorContainer,
      );
      valueWidgets.add(w);
    }

    if (valueWidgets.isEmpty) {
      if (isFilter) {
        return Text(c.strings.generic_disabled);
      } else {
        return Text(c.strings.generic_empty);
      }
    } else {
      return Wrap(spacing: 8, children: valueWidgets);
    }
  }
}
