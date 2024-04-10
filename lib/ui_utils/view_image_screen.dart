

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:openapi/api.dart";

import 'package:pihka_frontend/localizations.dart';
import "package:pihka_frontend/ui_utils/image.dart";

sealed class ViewImageScreenMode {}
class ViewImageAccountContent extends ViewImageScreenMode {
  ViewImageAccountContent(this.imageOwner, this.imageId);
  final AccountId imageOwner;
  final ContentId imageId;
}
class ViewImageFileContent extends ViewImageScreenMode {
  ViewImageFileContent(this.imageFile);
  final XFile imageFile;
}

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen(this.mode, {super.key});
  final ViewImageScreenMode mode;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {

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
        viewerForWidget(xfileImgWidget(imageFile)),
    };

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.view_image_screen_title)),
      body: Center(child: imageWidget),
    );
  }

  Widget buildImage(BuildContext contex, AccountId imageOwner, ContentId image) {
    return accountImgWidget(imageOwner, image);
  }

  Widget viewerForWidget(Widget child) {
    return InteractiveViewer(
      panEnabled: false,
      minScale: 1.0,
      maxScale: 2.0,
      child: child,
    );
  }
}
