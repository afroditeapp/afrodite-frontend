


import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/database/profile_entry.dart';

import 'package:pihka_frontend/ui/normal/profiles/view_profile.dart';
import 'package:pihka_frontend/ui_utils/image.dart';
import 'package:pihka_frontend/ui_utils/profile_thumbnail_image.dart';

const double PROFILE_IMG_HEIGHT = 400;

Widget viewProifle(BuildContext context, ProfileEntry profile, {ProfileHeroTag? heroTag}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      String profileText;
      if (profile.profileText.isEmpty) {
        profileText = "";
      } else {
        profileText = profile.profileText;
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: PROFILE_IMG_HEIGHT,
              width: constraints.maxWidth,
              child: ViewProfileImgViewer(profile: profile, heroTag: heroTag),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(profile.name, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(profileText, style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ]
        ),
      );
    }
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

  late final List<ContentId> contentList;

  @override
  void initState() {
    super.initState();

    contentList = widget.profile.primaryImgAndPossibleOtherImgs();
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
