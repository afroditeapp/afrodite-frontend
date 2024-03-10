
import "package:flutter/material.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/image_cache.dart";

import 'package:pihka_frontend/localizations.dart';


class ImagePage extends StatefulWidget {
  ImagePage(this.imageOwner, this.imageId, {super.key});
  final AccountId imageOwner;
  final ContentId imageId;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage>
  with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.pageViewImageTitle)),
      body: Center(child: buildImage(context, widget.imageOwner, widget.imageId),),
    );
  }

  Widget buildImage(BuildContext contex, AccountId imageOwner, ContentId image) {
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
              return InteractiveViewer(
                panEnabled: false,
                minScale: 1.0,
                maxScale: 2.0,
                child: Image.file(
                  imageFile,
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
    return const SizedBox(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
      ],
    ));
  }
}
