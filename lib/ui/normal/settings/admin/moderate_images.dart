

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:app/logic/admin/image_moderation.dart';


import 'package:app/localizations.dart';
import 'package:app/logic/app/navigator_state.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui_utils/image.dart';
import 'package:app/ui_utils/view_image_screen.dart';
import 'package:app/ui_utils/dialog.dart';


// Plan: Infinite list of rows of two images, first is security selfie, the
// other is to be moderated image. First image is empty if moderating security
// selfie.
//
// Long pressing the row opens option to discard the request. Maeby there should
// be space in the right side for status color.
//
// If trying to display previous rows, maeby just display empty rows? After it
// is not possible to load more entries then empty rows untill all moderated.
// Change entry to contain message all moderated.
//
// Taping image should open it to another view.

const ROW_HEIGHT = 300.0;


class ModerateImagesPage extends StatefulWidget {
  final ModerationQueueType queueType;
  const ModerateImagesPage({required this.queueType, Key? key}) : super(key: key);

  @override
  State<ModerateImagesPage> createState() => _ModerateImagesPageState();
}

class _ModerateImagesPageState extends State<ModerateImagesPage> {
  final ScrollController _controller = ScrollController();
  int currentPosition = -100;
  final logic = ImageModerationLogic.getInstance();

  @override
  void initState() {
    super.initState();
    logic.reset(widget.queueType);
    _controller.addListener(() {
      final offset = _controller.offset - ROW_HEIGHT;
      final position = offset ~/ ROW_HEIGHT;
      if (currentPosition != position && offset > 0) {
        currentPosition = position;
        logic.moderateImageRow(currentPosition, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.moderate_images_screen_title)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return StreamBuilder(
      stream: logic.imageModerationStatus,
      builder: (context, state) {
        final d = state.data;
        switch (d) {
          case ImageModerationStatus.allModerated:
            return buildEmptyText(ROW_HEIGHT);
          case ImageModerationStatus.moderating:
            return ListView.builder(
              itemCount: null,
              controller: _controller,
              itemBuilder: (context, index) {
                return buildEntry(context, index);
              },
            );
          case ImageModerationStatus.loading || null:
            return Center(child: buildProgressIndicator(ROW_HEIGHT));
        }
      },
    );
  }

  Widget buildEntry(BuildContext context, int index) {
    return StreamBuilder(
      stream: logic.getImageRow(index),
      builder: (context, snapshot) {
        final s = snapshot.data;
        if (s != null) {
          switch (s) {
            case AllModerated() : return buildEmptyText(ROW_HEIGHT);
            case Loading() : return buildProgressIndicator(ROW_HEIGHT);
            case ImageRow r : {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: buildImageRow(context, r, index, constraints.maxWidth, ROW_HEIGHT - 8),
                  );
                }
              );
            }
          }
        } else {
          return buildProgressIndicator(ROW_HEIGHT);
        }
      }
    );
  }

  Widget buildImageRow(BuildContext contex, ImageRow r, int index, double maxWidth, double height) {
    final securitySelfie = r.securitySelfie;
    final Widget securitySelfieWidget;
    if (securitySelfie != null) {
      securitySelfieWidget =
        buildImage(contex, r.state.m.requestCreatorId, securitySelfie, null, maxWidth/2, height);
    } else {
      securitySelfieWidget =
        SizedBox(width: maxWidth/2, height: height, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.strings.generic_empty),
          ],
        ));
    }

    final Color? color;
    switch (r.status) {
      case Accepted(): color = Colors.green.shade200;
      case Denied(): color = Colors.red.shade200;
      case ModerationDecicionNeeded(): color = null;
    }

    return Container(
      color: color,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          securitySelfieWidget,
          buildImage(contex, r.state.m.requestCreatorId, r.target, index, maxWidth/2, height),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext contex, AccountId imageOwner, ContentId image, int? index, double width, double height) {
    return InkWell(
      onTap: () {
        MyNavigator.push(
          context,
          MaterialPage<void>(child: ViewImageScreen(ViewImageAccountContent(imageOwner, image))),
        );
      },
      onLongPress: () {
        if (index != null) {
          showActionDialog(imageOwner, image, index);
        }
      },
      child: accountImgWidget(
        imageOwner,
        image,
        width: width,
        height: height,
      ),
    );
  }

  Widget buildProgressIndicator(double height) {
    return SizedBox(
      height: height,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      )
    );
  }

  Widget buildEmptyText(double height) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.strings.generic_empty)
        ],
      )
    );
  }

  Future<void> showActionDialog(AccountId account, ContentId contentId, int index) {
    final pageKey = PageKey();

    final rejectAction = SimpleDialogOption(
      onPressed: () {
        MyNavigator.removePage(context, pageKey);
        showConfirmDialog(
          context,
          context.strings.generic_reject_question,
        )
        .then(
            (value) {
              if (value == true) {
                logic.moderateImageRow(index, false);
              }
            }
        );
      },
      child: const Text("Reject image"),
    );

    return MyNavigator.showDialog(
      context: context,
      pageKey: pageKey,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select action"),
          children: <Widget>[
            if (logic.rejectingIsPossible(index)) rejectAction,
            SimpleDialogOption(
              onPressed: () {
                MyNavigator.removePage(context, pageKey);
                showInfoDialog(context, "Account ID\n\n${account.aid}\n\nContent ID\n\n${contentId.cid}");
              },
              child: const Text("Show info"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
