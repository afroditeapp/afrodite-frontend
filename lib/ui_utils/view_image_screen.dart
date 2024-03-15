
import "dart:io";

import "package:flutter/material.dart";
import "package:openapi/api.dart";
import "package:pihka_frontend/data/image_cache.dart";

import 'package:pihka_frontend/localizations.dart';

sealed class ViewImageScreenMode {}
class ViewImageAccountContent extends ViewImageScreenMode {
  ViewImageAccountContent(this.imageOwner, this.imageId);
  final AccountId imageOwner;
  final ContentId imageId;
}
class ViewImageFileContent extends ViewImageScreenMode {
  ViewImageFileContent(this.imageFile);
  final File imageFile;
}

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen(this.mode, {super.key});
  final ViewImageScreenMode mode;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen>
  with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = switch (widget.mode) {
      ViewImageAccountContent(:final imageOwner, :final imageId) =>
        buildImage(context, imageOwner, imageId),
      ViewImageFileContent(:final imageFile) =>
        viewerForFile(imageFile),
    };

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.view_image_screen_title)),
      body: Center(child: imageWidget),
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
              return viewerForFile(imageFile);
            } else {
              return Text(context.strings.generic_error);
            }
          }
        }
    },);
  }

  Widget viewerForFile(File imageFile) {
    return InteractiveViewer(
      panEnabled: false,
      minScale: 1.0,
      maxScale: 2.0,
      child: Image.file(
        imageFile,
      ),
    );
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
