import "dart:typed_data";

import "package:app/data/image_cache.dart";
import "package:flutter/material.dart";
import "package:openapi/api.dart";

import 'package:app/localizations.dart';
import "package:app/logic/app/navigator_state.dart";
import "package:app/ui_utils/image.dart";

sealed class ViewImageScreenMode {}

class ViewImageAccountContent extends ViewImageScreenMode {
  ViewImageAccountContent(this.imageOwner, this.imageId);
  final AccountId imageOwner;
  final ContentId imageId;
}

class ViewImageBytesContent extends ViewImageScreenMode {
  ViewImageBytesContent(this.imageBytes);
  final Uint8List imageBytes;
}

void openViewImageScreenForAccountImage(
  BuildContext context,
  AccountId accountId,
  ContentId contentId,
) {
  MyNavigator.push(
    context,
    MaterialPage<void>(child: ViewImageScreen(ViewImageAccountContent(accountId, contentId))),
  );
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
      ViewImageAccountContent(:final imageOwner, :final imageId) => buildImage(
        context,
        imageOwner,
        imageId,
      ),
      ViewImageBytesContent(:final imageBytes) => viewerForWidget(bytesImgWidget(imageBytes)),
    };

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.view_image_screen_title)),
      body: Center(child: imageWidget),
    );
  }

  Widget buildImage(BuildContext contex, AccountId imageOwner, ContentId image) {
    return accountImgWidget(imageOwner, image, cacheSize: ImageCacheSize.fullScreen(context));
  }

  Widget viewerForWidget(Widget child) {
    return InteractiveViewer(panEnabled: false, minScale: 1.0, maxScale: 2.0, child: child);
  }
}
