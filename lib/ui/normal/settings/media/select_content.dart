import 'package:app/data/image_cache.dart';
import 'package:app/data/utils/repository_instances.dart';
import 'package:app/logic/media/image_processing.dart';
import 'package:app/model/freezed/logic/main/navigator_state.dart';
import 'package:app/ui/initial_setup/profile_pictures.dart';
import 'package:app/ui/initial_setup/security_selfie.dart';
import 'package:app/ui_utils/image_processing.dart';
import 'package:app/ui_utils/padding.dart';
import 'package:app/utils/api.dart';
import 'package:app/utils/immutable_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/api.dart';
import 'package:app/localizations.dart';
import 'package:app/logic/media/select_content.dart';
import 'package:app/model/freezed/logic/media/profile_pictures.dart';
import 'package:app/model/freezed/logic/media/select_content.dart';
import 'package:app/ui_utils/consts/padding.dart';
import 'package:app/ui_utils/image.dart';

const SELECT_CONTENT_IMAGE_HEIGHT = 200.0;
const SELECT_CONTENT_IMAGE_WIDTH = 150.0;

class SelectContentPage extends MyFullScreenDialogPage<AccountImageId> {
  SelectContentPage({bool identifyFaceImages = false, bool securitySelfieMode = false})
    : super(
        builder: (closer) => SelectContentScreenOpener(
          closer: closer,
          identifyFaceImages: identifyFaceImages,
          securitySelfieMode: securitySelfieMode,
        ),
      );
}

class SelectContentScreenOpener extends StatelessWidget {
  final PageCloser<AccountImageId> closer;
  final bool identifyFaceImages;
  final bool securitySelfieMode;

  const SelectContentScreenOpener({
    required this.closer,
    required this.identifyFaceImages,
    required this.securitySelfieMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectContentScreen(
      closer: closer,
      selectContentBloc: context.read<SelectContentBloc>(),
      identifyFaceImages: identifyFaceImages,
      securitySelfieMode: securitySelfieMode,
    );
  }
}

class SelectContentScreen extends StatefulWidget {
  final PageCloser<AccountImageId> closer;
  final SelectContentBloc selectContentBloc;
  final bool identifyFaceImages;
  final bool securitySelfieMode;
  const SelectContentScreen({
    required this.closer,
    required this.selectContentBloc,
    required this.identifyFaceImages,
    required this.securitySelfieMode,
    super.key,
  });

  @override
  State<SelectContentScreen> createState() => _SelectContentScreenState();
}

class _SelectContentScreenState extends State<SelectContentScreen> {
  final cameraScreenOpener = CameraScreenOpener();

  @override
  void initState() {
    super.initState();
    widget.selectContentBloc.add(ReloadAvailableContent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.strings.select_content_screen_title)),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SelectContentBloc, SelectContentData>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return selectContentPage(
                    context,
                    context.read<RepositoryInstances>().accountId,
                    state.availableContent,
                    state.maxContent,
                    state.showAddNewContent,
                  );
                }
              },
            ),
          ),

          // Zero sized widgets
          ...imageProcessingUiWidgets<ProfilePicturesImageProcessingBloc>(
            onComplete: (context, processedImg) {
              context.read<SelectContentBloc>().add(ReloadAvailableContent());
            },
          ),
          ...imageProcessingUiWidgets<SecuritySelfieImageProcessingBloc>(
            onComplete: (context, processedImg) {
              context.read<SelectContentBloc>().add(ReloadAvailableContent());
            },
          ),
        ],
      ),
    );
  }

  Widget selectContentPage(
    BuildContext context,
    AccountId accountId,
    UnmodifiableList<ContentInfoDetailed> content,
    int maxContent,
    bool showAddNewContent,
  ) {
    final List<Widget> gridWidgets = [];

    if (showAddNewContent) {
      gridWidgets.add(
        Center(
          child: buildAddNewButton(
            context,
            onTap: () {
              if (widget.securitySelfieMode) {
                cameraScreenOpener.openCameraScreenAction(context);
              } else {
                openSelectPictureDialog(context, serverSlotIndex: 0);
              }
            },
          ),
        ),
      );
    }

    final Iterable<ContentInfoDetailed> iterContent;
    if (widget.securitySelfieMode) {
      iterContent = content.reversed.where((v) => v.secureCapture);
    } else {
      iterContent = content.reversed;
    }

    gridWidgets.addAll(
      iterContent.map(
        (e) => buildAvailableImg(
          context,
          accountId,
          e.cid,
          e.fd,
          onTap: () =>
              widget.closer.close(context, AccountImageId(accountId, e.cid, e.fd, e.accepted())),
          identifyFaceImages: widget.identifyFaceImages,
        ),
      ),
    );

    final grid = GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: gridWidgets,
    );

    final int visibleMaxContent;
    final int visibleContentCount;
    if (widget.securitySelfieMode) {
      final normalImgCount = content.reversed.where((v) => !v.secureCapture).length;
      visibleMaxContent = maxContent - normalImgCount;
      visibleContentCount = content.length - normalImgCount;
    } else {
      visibleMaxContent = maxContent;
      visibleContentCount = content.length;
    }

    final List<Widget> widgets = [];

    widgets.add(const Padding(padding: EdgeInsets.only(top: COMMON_SCREEN_EDGE_PADDING)));
    widgets.add(
      hPad(
        Text(
          context.strings.select_content_screen_count(
            visibleContentCount.toString(),
            visibleMaxContent.toString(),
          ),
        ),
      ),
    );
    widgets.add(const Padding(padding: EdgeInsets.only(top: COMMON_SCREEN_EDGE_PADDING)));
    widgets.add(grid);
    widgets.add(const Padding(padding: EdgeInsets.only(top: COMMON_SCREEN_EDGE_PADDING)));

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: widgets),
    );
  }
}

Widget buildAddNewButton(BuildContext context, {required void Function() onTap}) {
  return Center(
    child: SizedBox(
      width: SELECT_CONTENT_IMAGE_WIDTH,
      height: SELECT_CONTENT_IMAGE_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Ink(
            width: SELECT_CONTENT_IMAGE_WIDTH,
            height: SELECT_CONTENT_IMAGE_HEIGHT,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildAvailableImg(
  BuildContext context,
  AccountId accountId,
  ContentId contentId,
  bool faceImage, {
  required void Function() onTap,
  required bool identifyFaceImages,
}) {
  final img = Material(
    child: InkWell(
      onTap: onTap,
      child: accountImgWidgetInk(
        context,
        accountId,
        contentId,
        width: SELECT_CONTENT_IMAGE_WIDTH,
        height: SELECT_CONTENT_IMAGE_HEIGHT,
        cacheSize: ImageCacheSize.constantWidthAndHeight(
          context,
          SELECT_CONTENT_IMAGE_WIDTH,
          SELECT_CONTENT_IMAGE_HEIGHT,
        ),
      ),
    ),
  );

  if (identifyFaceImages && faceImage) {
    return Center(
      child: SizedBox(
        width: SELECT_CONTENT_IMAGE_WIDTH,
        height: SELECT_CONTENT_IMAGE_HEIGHT,
        child: Column(
          children: [
            Expanded(child: img),
            Text(context.strings.select_content_screen_face_detected),
          ],
        ),
      ),
    );
  } else {
    return Center(
      child: SizedBox(
        width: SELECT_CONTENT_IMAGE_WIDTH,
        height: SELECT_CONTENT_IMAGE_HEIGHT,
        child: img,
      ),
    );
  }
}
