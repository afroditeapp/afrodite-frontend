


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:database/database.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/logic/profile/attributes.dart';
import 'package:pihka_frontend/model/freezed/logic/profile/attributes.dart';
import 'package:pihka_frontend/ui/initial_setup/profile_attributes.dart';

import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui/normal/settings/profile/edit_profile.dart';
import 'package:pihka_frontend/ui_utils/consts/padding.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/loading_dialog.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';
import 'package:pihka_frontend/ui_utils/snack_bar.dart';

const double PROFILE_IMG_HEIGHT = 400;

// TODO: Check that IconButtons have tooltips
// TODO(prod): Set scrolledUnderElevation: 0 to app bar theme

class ViewProfileEntry extends StatefulWidget {
  final ProfileEntry profile;
  final ProfileHeroTag? heroTag;
  const ViewProfileEntry({required this.profile, this.heroTag, super.key});

  @override
  State<ViewProfileEntry> createState() => _ViewProfileEntryState();
}

class _ViewProfileEntryState extends State<ViewProfileEntry> {

  @override
  void initState() {
    super.initState();
    context.read<ProfileAttributesBloc>().add(RefreshAttributesIfNeeded());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        List<Widget> profileTextWidgets;
        if (widget.profile.profileText.trim().isNotEmpty) {
          profileTextWidgets = [
            const Padding(padding: EdgeInsets.all(8)),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
                child: Text(widget.profile.profileText, style: Theme.of(context).textTheme.bodyLarge),
              ),
            )
          ];
        } else {
          profileTextWidgets = const [SizedBox.shrink()];
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: PROFILE_IMG_HEIGHT,
                width: constraints.maxWidth,
                child: ViewProfileImgViewer(profile: widget.profile, heroTag: widget.heroTag),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              title(context),
              ...profileTextWidgets,
              const Padding(padding: EdgeInsets.all(8)),
              attributes(),
              const Padding(padding: EdgeInsets.all(8)),
              // Zero sized widgets
              ProgressDialogOpener<ProfileAttributesBloc, AttributesData>(
                dialogVisibilityGetter: (context, state) =>
                  state.refreshState is AttributeRefreshLoading,
              ),
            ]
          ),
        );
      }
    );
  }

  Widget title(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
        child: Row(
          children: [
            Text(widget.profile.profileTitle(), style: Theme.of(context).textTheme.titleLarge),
            // TODO: Spacer and infinity icon if limitless likes are enabled
          ],
        ),
      ),
    );
  }

  Widget attributes() {
    return BlocBuilder<ProfileAttributesBloc, AttributesData>(
      builder: (context, state) {
        final info = state.attributes?.info;
        if (info == null) {
          return const SizedBox.shrink();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: COMMON_SCREEN_EDGE_PADDING),
            child: AttributeList(availableAttributes: info, attributes: widget.profile.attributes),
          );
        }
      }
    );
  }
}

class ViewProfileImgViewer extends StatefulWidget {
  final ProfileEntry profile;
  final ProfileHeroTag? heroTag;
  const ViewProfileImgViewer({
    required this.profile,
    this.heroTag,
    super.key
  });

  @override
  State<ViewProfileImgViewer> createState() => _ViewProfileImgViewerState();
}

class _ViewProfileImgViewerState extends State<ViewProfileImgViewer> {
  int selectedImg = 0;

  List<ContentId> contentList = [];

  @override
  void initState() {
    super.initState();

    contentList = widget.profile.primaryImgAndPossibleOtherImgs();
  }

  @override
  void didUpdateWidget(covariant ViewProfileImgViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.profile != widget.profile) {
      contentList = widget.profile.primaryImgAndPossibleOtherImgs();
      selectedImg = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imgs = [];
    for (int i = 0; i < contentList.length; i++) {
      final firstImgHeroTag = 0 == i ? widget.heroTag : null;
      final img = viewProifleImage(context, widget.profile.uuid, contentList[i], firstImgHeroTag);
      imgs.add(img);
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        IndexedStack(
          index: selectedImg,
          children: imgs,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SelectedImgIndicator(selectedImg: selectedImg, imgCount: contentList.length),
        ),
        touchArea(),
      ]
    );
  }

  Widget touchArea() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImg > 0) {
                  selectedImg--;
                }
              });
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedImg < contentList.length - 1) {
                  selectedImg++;
                }
              });
            },
          ),
        ),
      ]
    );
  }

  Widget viewProifleImage(BuildContext context, AccountId accountId, ContentId contentId, ProfileHeroTag? heroTag) {
    final Widget imgWidget;
    if (heroTag != null) {
      imgWidget = Hero(
        tag: heroTag.value,
        child: ProfileThumbnailImage(
          accountId: accountId,
          contentId: contentId,
          borderRadius: null,
          squareFactor: 0.0,
        )
      );
    } else {
      imgWidget = accountImgWidget(
        accountId,
        contentId,
      );
    }

    return imgWidget;
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}

class AttributeList extends StatelessWidget {
  final ProfileAttributes availableAttributes;
  final List<ProfileAttributeValue> attributes;
  const AttributeList({required this.availableAttributes, required this.attributes, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> attributeWidgets = <Widget>[];

    final l = AttributeAndValue.sortedListFrom(availableAttributes, attributes);
    for (final a in l) {
      attributeWidgets.add(attributeWidget(context, a));
      attributeWidgets.add(const Divider());
    }

    if (attributeWidgets.isNotEmpty) {
      attributeWidgets.removeLast();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: attributeWidgets,
      ),
    );
  }

  Widget attributeWidget(BuildContext context, AttributeAndValue a) {
    final attributeText = a.title(context);
    final icon = iconResourceToMaterialIcon(a.attribute.icon);
    if (icon == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () => showSnackBar(attributeText),
          tooltip: attributeText
        ),
        const Padding(padding: EdgeInsets.only(right: COMMON_SCREEN_EDGE_PADDING)),
        Expanded(child: AttributeValuesArea(a: a)),
      ],
    );
  }
}

class AttributeValuesArea extends StatelessWidget {
  final AttributeInfoProvider a;
  const AttributeValuesArea({required this.a, super.key});

  @override
  Widget build(BuildContext context) {
    return attributeValuesArea(context, a);
  }

  Widget attributeValuesArea(BuildContext c, AttributeInfoProvider a) {
    final List<Widget> valueWidgets = [];
      for (final v in a.extraValues(c)) {
      final w = Chip(
        label: Text(v),
      );
      valueWidgets.add(w);
    }

    for (final v in a.sortedSelectedValues()) {
      final text = attributeValueName(c, v, a.attribute.translations);
      final iconData = iconResourceToMaterialIcon(v.icon);
      final Widget? avatar;
      if (iconData != null) {
        avatar = Icon(iconData);
      } else {
        avatar = null;
      }
      final w = Chip(
        avatar: avatar,
        label: Text(text),
      );
      valueWidgets.add(w);
    }

    if (valueWidgets.isEmpty) {
      if (a.isFilter) {
        return Text(c.strings.generic_disabled);
      } else {
        return Text(c.strings.generic_empty);
      }
    } else {
      return Wrap(
        spacing: 8,
        children: valueWidgets,
      );
    }
  }
}

class AttributeAndValue implements AttributeInfoProvider {
  @override
  final Attribute attribute;
  @override
  final ProfileAttributeValue? value;
  const AttributeAndValue({required this.attribute, required this.value});

  /// Get sorted list of attributes and values
  static List<AttributeAndValue> sortedListFrom(
    ProfileAttributes availableAttributes,
    Iterable<ProfileAttributeValue> attributes,
    {bool includeNullAttributes = false}
  ) {
    final List<AttributeAndValue> result = [];

    for (final a in availableAttributes.attributes) {
      final currentValue = attributes.where((attr) => attr.id == a.id).firstOrNull;
      if (!includeNullAttributes && currentValue == null) {
        continue;
      }
      result.add(AttributeAndValue(attribute: a, value: currentValue));
    }

    if (availableAttributes.attributeOrder == AttributeOrderMode.orderNumber) {
      result.sort((a, b) {
        return a.attribute.orderNumber.compareTo(b.attribute.orderNumber);
      });
    }

    return result;
  }

  @override
  String title(BuildContext context) {
    return attributeName(context, attribute);
  }

  @override
  List<AttributeValue> sortedSelectedValues() {
    final List<AttributeValue> result = [];

    final value = this.value;
    if (value == null) {
      return result;
    }

    if (attribute.mode == AttributeMode.selectSingleFilterSingle || attribute.mode == AttributeMode.selectSingleFilterMultiple) {
      for (final v in attribute.values) {
        if (v.id != value.valuePart1) {
          continue;
        }

        if (value.valuePart2 == null) {
          result.add(v);
        }

        // Only second level is supported
        final secondLevelValues = v.groupValues;
        if (secondLevelValues != null) {
          for (final v2 in secondLevelValues.values) {
            if (v2.id == value.valuePart2) {
              result.add(v2);
              break;
            }
          }
        }
      }
    } else if (attribute.mode == AttributeMode.selectMultipleFilterMultiple) {
      for (final bitflag in attribute.values) {
        if (bitflag.id & value.valuePart1 != 0) {
          result.add(bitflag);
        }
      }
    }

    reorderValues(result, attribute.valueOrder);

    return result;
  }

  @override
  List<String> extraValues(BuildContext c) {
    return [];
  }

  @override
  bool get isFilter => false;
}
