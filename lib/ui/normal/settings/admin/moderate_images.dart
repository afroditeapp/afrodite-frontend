

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';


import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/ui_utils/view_image_screen.dart';
import 'package:pihka_frontend/ui_utils/dialog.dart';


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

const imageHeight = 300.0;


class ModerateImagesPage extends StatefulWidget {
  const ModerateImagesPage({Key? key}) : super(key: key);

  @override
  _ModerateImagesPageState createState() => _ModerateImagesPageState();
}

class _ModerateImagesPageState extends State<ModerateImagesPage> {
  bool reset = true;

  ScrollController _controller = ScrollController();
  int currentPosition = -100;
  ImageModerationBloc? logic;

  @override
  void initState() {
    super.initState();
    reset = true;
    _controller.addListener(() {
      final offset = _controller.offset - (imageHeight);
      final position = offset ~/ imageHeight;
      if (currentPosition != position && offset > 0) {
        currentPosition = position;
        logic?.add(ModerateEntry(currentPosition, true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    logic = context.read<ImageModerationBloc>();

    if (reset) {
      context.read<ImageModerationBloc>().add(ResetImageModerationData());
      reset = false;
    }

    if (_controller.hasClients) {
      final position = _controller.offset ~/ imageHeight;
      if (currentPosition != position) {
        currentPosition = position;
        logic?.add(ModerateEntry(currentPosition, true));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.pageModerateImagesTitle)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return BlocBuilder<ImageModerationBloc, ImageModerationData>(
      buildWhen: (previous, current) {
        return previous.state != current.state;
      },
      builder: (context, state) {
        switch (state.state) {
          case ImageModerationStatus.allModerated:
            return buildEmptyText();
          case ImageModerationStatus.moderating:
            return ListView.builder(
              itemCount: null,
              controller: _controller,
              itemBuilder: (context, index) {
                return buildEntry(context, state, index);
              },
            );
        }
      },
    );
  }

  Widget buildEntry(BuildContext context, ImageModerationData state, int index) {
    final rowState = context.read<ImageModerationBloc>().getImageRow(index);

    return StreamBuilder(
      stream: rowState,
      builder: (context, snapshot) {
        final s = snapshot.data;
        if (s != null) {
          switch (s) {
            case AllModerated _ : return buildEmptyText();
            case Loading _ : return buildProgressIndicator();
            case ImageRow r : {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return buildImageRow(context, r.entry, r.requestEntry, index, constraints.maxWidth);
                }
              );
            }
          }
        } else {
          return buildProgressIndicator();
        }
      }
    );
  }

  Widget buildImageRow(BuildContext contex, ModerationEntry entry, ModerationRequestEntry requestEntry, int index, double maxWidth) {
    final securitySelfie = entry.securitySelfie;
    final Widget securitySelfieWidget;
    if (securitySelfie != null) {
      securitySelfieWidget =
        buildImage(contex, requestEntry.m.requestCreatorId, securitySelfie, null, maxWidth/2);
    } else {
      securitySelfieWidget =
        SizedBox(width: maxWidth/2, height: imageHeight, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.strings.generic_empty),
          ],
        ));
    }

    final Color? color;
    switch (entry.status) {
      case true: color = Colors.green.shade200;
      case false: color = Colors.red.shade200;
      case null: color = null;
    }

    return Container(
      color: color,
      height: imageHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          securitySelfieWidget,
          buildImage(contex, requestEntry.m.requestCreatorId, entry.target, index, maxWidth/2),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext contex, AccountId imageOwner, ContentId image, int? index, double width) {
    return FutureBuilder(
      future: ImageCacheData.getInstance().getImage(imageOwner, image),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final imageFile = snapshot.data;
            if (imageFile != null) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => ViewImageScreen(ViewImageAccountContent(imageOwner, image))
                    ),
                  );
                },
                onLongPress: () {
                  if (index != null) {
                    showActionDialog(imageOwner, image, index);
                  }
                },
                child: Image.file(
                  imageFile,
                  width: width,
                  height: imageHeight,
                ),
              );
            } else {
              return Text(context.strings.generic_error);
            }
          }
        }
    },);
  }

  Widget buildProgressIndicator() {
    return const SizedBox(
      height: imageHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      )
    );
  }

  Widget buildEmptyText() {
    return SizedBox(
      height: imageHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.strings.generic_empty)
        ],
      )
    );
  }

  Future<void> showActionDialog(AccountId account, ContentId contentId, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Select action"),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showConfirmDialog(
                  context,
                  context.strings.pageModerateImagesDenyImageText,
                  details: "Note that if when all images in a requests are green, you have to ban the profile if you want make sure that other users can't see the image.",
                )
                .then(
                    (value) {
                      if (value == true) {
                        context.read<ImageModerationBloc>().add(ModerateEntry(index, false));
                      }
                    }
                );
              },
              child: const Text("Deny image"),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                showInfoDialog(context, "Account ID\n\n${account.accountId}\n\nContent ID\n\n${contentId.contentId}");
              },
              child: const Text("Show info"),
            ),
          ],
        );
      },
    );
  }
}
