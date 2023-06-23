

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:pihka_frontend/data/image_cache.dart';
import 'package:pihka_frontend/logic/account/account.dart';
import 'package:pihka_frontend/logic/admin/image_moderation.dart';
import 'package:pihka_frontend/ui/normal/settings.dart';
import 'package:pihka_frontend/ui/utils.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pihka_frontend/ui/utils/image_page.dart';


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
      final offset = _controller.offset - (imageHeight/8*7);
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
      context.read<ImageModerationBloc>().add(GetMoreData());
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
      appBar: AppBar(title: Text(AppLocalizations.of(context).pageModerateImagesTitle)),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return BlocBuilder<ImageModerationBloc, ImageModerationData>(
      builder: (context, state) {
        switch (state.state) {
          case ImageModerationStatus.loading:
            return buildProgressIndicator();
          case ImageModerationStatus.moderating || ImageModerationStatus.moderatingAndNoMoreData:
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

  Widget buildEntry(BuildContext contex, ImageModerationData state, int index) {
    final (entry, requestEntry) = state.data[index] ?? (null, null);

    if (entry != null && requestEntry != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return buildImageRow(contex, entry, requestEntry, index, constraints.maxWidth);
        }
      );
    } else {
      switch (state.state) {
        case ImageModerationStatus.loading || ImageModerationStatus.moderating:
          return buildProgressIndicator();
        case ImageModerationStatus.moderatingAndNoMoreData:
          return Text(AppLocalizations.of(context).genericError);
      }
    }
  }

  Widget buildImageRow(BuildContext contex, ModerationEntry entry, ModerationRequestEntry requestEntry, int index, double maxWidth) {
    void Function()? acceptModeration;
    void Function()? denyModeration;
    if (entry.status == null) {
      acceptModeration = () {
        context.read<ImageModerationBloc>().add(ModerateEntry(index, true));
      };
      denyModeration = () {
        context.read<ImageModerationBloc>().add(ModerateEntry(index, false));
      };
    }

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
            Text(AppLocalizations.of(context).genericEmpty),
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

  Widget buildImage(BuildContext contex, AccountIdLight imageOwner, ContentId image, int? index, double width) {
    return FutureBuilder(
      future: ImageCacheData.getInstance().getImage(imageOwner, image),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active || ConnectionState.waiting: {
            return buildProgressIndicator();
          }
          case ConnectionState.none || ConnectionState.done: {
            final data = snapshot.data;
            if (data != null) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ImagePage(imageOwner, image)));
                },
                onLongPress: () {
                  if (index != null) {
                    showDenyDialog().then((value) {
                      if (value == true) {
                        context.read<ImageModerationBloc>().add(ModerateEntry(index, false));
                      }
                    });
                  }
                },
                child: Image.memory(
                  data,
                  width: width,
                  height: imageHeight,
                ),
              );
            } else {
              return Text(AppLocalizations.of(context).genericError);
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

  Future<bool?> showDenyDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).pageModerateImagesDenyImageText),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context).genericCancel)
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(AppLocalizations.of(context).genericOk)
          )
        ],
      )
    );
  }
}
