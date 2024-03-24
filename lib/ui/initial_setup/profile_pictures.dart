import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/logic/media/profile_pictures.dart";
import "package:pihka_frontend/ui_utils/consts/corners.dart";
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/image_processing.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/profile_thumbnail_image.dart";
import "package:pihka_frontend/ui_utils/view_image_screen.dart";

class AskProfilePicturesScreen extends StatelessWidget {
  const AskProfilePicturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        getContinueButtonCallback: (context, state) {
          // final birthdate = state.birthdate;
          // if (birthdate != null && birthdate.isNowAdult()) {
          //   return () {
          //     Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen))
          //   };
          // } else {
          //   return null;
          // }
          return null;
        },
        question: AskProfilePictures(),
      ),
    );
  }
}

const ROW_HEIGHT = 150.0;
const THUMBNAIL_SIZE = 100.0;

class AskProfilePictures extends StatefulWidget {
  @override
  _AskProfilePicturesState createState() => _AskProfilePicturesState();
}

class _AskProfilePicturesState extends State<AskProfilePictures> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          questionTitleText(context, context.strings.initial_setup_screen_profile_pictures_title),
          ProfilePictureSelection(
            mode: InitialSetupProfilePictures(),
            profilePicturesBloc: context.read<ProfilePicturesBloc>(),
          ),
        ],
      ),
    );
  }
}


class ProfilePictureSelection extends StatefulWidget {
  final PictureSelectionMode mode;
  final ProfilePicturesBloc profilePicturesBloc;
  const ProfilePictureSelection({
    required this.mode,
    required this.profilePicturesBloc,
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePictureSelection createState() => _ProfilePictureSelection();
}

class _ProfilePictureSelection extends State<ProfilePictureSelection> {

  @override
  void initState() {
    super.initState();
    widget.profilePicturesBloc.add(ResetIfModeChanges(widget.mode));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(context),
        const Divider(
          color: Colors.grey,
          height: 50,
        ),
        bottomRow(context),

        // Zero sized widgets
        ...imageProcessingUiWidgets<ProfilePicturesImageProcessingBloc>(
          onComplete: (context, processedImg) {
            widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(processedImg)));
          },
        ),
      ],
    );
  }

  Widget topRow(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Center(
          child: imgStateToWidget(context, 0),
        ),
      ),
      Expanded(
        flex: 2,
        child: Center(
          child: SizedBox(
            height: ROW_HEIGHT,
            child: thumbnailArea(context),
          ),
        ),
      )
    ],);
  }

  Widget bottomRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: imgStateToWidget(context, 1),
          ),
        ),
        Expanded(
          child: Center(
            child: imgStateToWidget(context, 2),
          ),
        ),
        Expanded(
          child: Center(
            child: imgStateToWidget(context, 3),
          ),
        ),
      ]
    );
  }

  Widget thumbnailArea(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Align(
            alignment: Alignment.topRight,
            child: primaryImageInfoButton(context),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Container()),
            imgStateToPrimaryImageThumbnail(0),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: thumbnailEditButton(0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget primaryImageInfoButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showInfoDialog(context, context.strings.initial_setup_screen_profile_pictures_primary_image_info_dialog_description);
      },
      icon: const Icon(Icons.info)
    );
  }

  Widget thumbnailEditButton(int imgStateIndex) {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) => previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        final img = getProcessedAccountImage(context, imgState);
        if (img != null && imgState is ImageSelected) {
          return IconButton(
            onPressed: () {
              openEditThumbnail(context, img, imgState.cropResults, imgStateIndex);
            },
            icon: const Icon(Icons.edit)
          );
        } else {
          return Container();
        }
      }
    );
  }

  ProcessedAccountImage? getProcessedAccountImage(BuildContext context, ImgState imgState) {
    if (imgState is ImageSelected) {
      final info = imgState.img;
      switch (info) {
        case InitialSetupSecuritySelfie():
          return context.read<InitialSetupBloc>().state.securitySelfie;
        case ProfileImage(:final img):
          return img;
      }
    } else {
      return null;
    }
  }

  Widget imgStateToWidget(BuildContext context, int imgStateIndex) {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) => previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        switch (imgState) {
          case Add():
            return AddPicture(imgIndex: imgStateIndex);
          case Hidden():
            return HiddenPicture();
          case ImageSelected():
            final processedImg = getProcessedAccountImage(context, imgState);
            if (processedImg != null) {
              return FilePicture(img: processedImg, imgIndex: imgStateIndex);
            } else {
              return AddPicture(imgIndex: imgStateIndex);
            }
        }
      }
    );
  }

  Widget imgStateToPrimaryImageThumbnail(int imgStateIndex) {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) => previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        switch (imgState) {
          case Add(): return HiddenThumbnailPicture();
          case Hidden(): return HiddenThumbnailPicture();
          case ImageSelected(:final cropResults): {
            final processedImg = getProcessedAccountImage(context, imgState);
            if (processedImg != null) {
              return VisibleThumbnailPicture(img: processedImg, imgIndex: imgStateIndex, cropResults: cropResults);
            } else {
              return const HiddenThumbnailPicture();
            }
          }
        }
      }
    );
  }
}

Future<void> openEditThumbnail(
  BuildContext context,
  ProcessedAccountImage img,
  CropResults currentCrop,
  int imgStateIndex,
) async {
  // TODO: Error handling
  final bytes = await img.imgFile.readAsBytes();
  final flutterImg = await decodeImageFromList(bytes);
  if (!context.mounted) {
    return;
  }
  final cropResults = await Navigator.push<CropResults>(
    context,
    MaterialPageRoute<CropResults>(
      builder: (_) =>
        CropImageScreen(
          CropImageFileContent(
              img.accountId,
              img.contentId,
              img.imgFile,
              flutterImg.width,
              flutterImg.height,
              currentCrop,
            )
          )
    )
  );

  if (cropResults != null && context.mounted) {
    context.read<ProfilePicturesBloc>().add(UpdateCropResults(cropResults, imgStateIndex));
  }
}

class AddPicture extends StatelessWidget {
  final int imgIndex;
  const AddPicture({
      required this.imgIndex,
      Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Drag and drop to empty slot is disabled currently.

    // return DragTarget<int>(
    //   onAcceptWithDetails: (details) {
    //     context.read<ProfilePicturesBloc>().add(MoveImageTo(details.data, imgIndex));
    //   },
    //   onWillAcceptWithDetails: (details) => true,
    //   builder: (context, candidateData, rejectedData) {
    //     final backgroundColor = candidateData.isEmpty ? Colors.transparent : Colors.grey.shade400;
    //      return Container(
    //        color: backgroundColor,
    //        child: Center(
    //          child: buildAddPictureButton(context),
    //        ),
    //      );
    //   },
    // );

    return buildAddPictureButton(context);
  }

  Widget buildAddPictureButton(BuildContext context) {
    return SizedBox(
      width: 100,
      height: ROW_HEIGHT,
      child: Material(
        child: InkWell(
          onTap: () {
            switch (context.read<ProfilePicturesBloc>().state.mode) {
              case InitialSetupProfilePictures():
                openInitialSetupActionDialog(context);
              case NormalProfilePictures():
                openActionDialog(context);
            }
          },
          child: Ink(
            width: 100,
            height: ROW_HEIGHT,
            color: Colors.grey,
            child: const Center(
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openInitialSetupActionDialog(BuildContext context) {
    final securitySelfie = context.read<InitialSetupBloc>().state.securitySelfie;
    final Widget lastOption;
    if (securitySelfie != null) {
      final iconSize = IconTheme.of(context).size ?? 24.0;
      lastOption = ListTile(
        leading: SizedBox(
          width: iconSize,
          height: iconSize,
          child: FittedBox(
            child: AccountImage(accountId: securitySelfie.accountId, contentId: securitySelfie.contentId),
          )
        ),
        title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_security_selfie_title),
        onTap: () {
          context.read<ProfilePicturesBloc>().add(AddProcessedImage(InitialSetupSecuritySelfie(imgIndex)));
          Navigator.pop(context, null);
        },
      );
    } else {
      lastOption = const SizedBox.shrink();
    }

    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_dialog_title),
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_from_gallery_title),
              onTap: () async {
                final imageProcessingBloc = context.read<ProfilePicturesImageProcessingBloc>();
                Navigator.pop(context, null);
                // TODO: Consider resizing image on client side?
                // The built in ImagePicker resizing produces poor quality
                // images at least on Android.
                final image  = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  requestFullMetadata: false
                );
                if (image != null) {
                  imageProcessingBloc.add(SendImageToSlot(image, imgIndex + 1));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_take_new_picture_title),
              onTap: () async {
                final imageProcessingBloc = context.read<ProfilePicturesImageProcessingBloc>();
                Navigator.pop(context, null);
                final image  = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  requestFullMetadata: false,
                  preferredCameraDevice: CameraDevice.front,
                );
                if (image != null) {
                  imageProcessingBloc.add(ConfirmImage(image, imgIndex + 1));
                }
              }
            ),
            lastOption,
          ],
      )
    );
  }

  void openActionDialog(BuildContext context) {

  }
}

class HiddenPicture extends StatelessWidget {
  const HiddenPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: ROW_HEIGHT,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
    );
  }
}


class HiddenThumbnailPicture extends StatelessWidget {
  const HiddenThumbnailPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: THUMBNAIL_SIZE,
      height: THUMBNAIL_SIZE,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(PROFILE_PICTURE_BORDER_RADIUS),
      ),
    );
  }
}


class FilePicture extends StatelessWidget {
  final ProcessedAccountImage img;
  final int imgIndex;

  const FilePicture({required this.img, required this.imgIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size ?? 24.0;
    const maxWidth = 150.0;
    const maxHeight = ROW_HEIGHT;
    final imgWidth = maxWidth - iconSize;
    final imgHeight = maxHeight - iconSize;
    return imgAndDeleteButton(
      context,
      iconSize,
      maxWidth,
      maxHeight,
      imgWidth,
      imgHeight,
    );
  }

  Widget imgAndDeleteButton(
    BuildContext context,
    double iconSize,
    double maxWidth,
    double maxHeight,
    double imgWidth,
    double imgHeight,
  ) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) {
        context.read<ProfilePicturesBloc>().add(MoveImageTo(details.data, imgIndex));
      },
      onWillAcceptWithDetails: (details) => details.data != imgIndex,
      builder: (context, candidateData, rejectedData) {
        final acceptedCandidate = candidateData.where((element) => element != imgIndex).firstOrNull;
        final backgroundColor = acceptedCandidate == null ? Colors.transparent : Colors.grey.shade400;
        return Container(
          width: maxWidth,
          height: maxHeight,
          color: backgroundColor,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: EdgeInsets.only(top: iconSize, right: iconSize, left: iconSize),
                child: draggableImgWidget(context, imgWidth, imgHeight),
              ),
              closeButton(context),
            ],
          ),
        );
      }
    );
  }

  Widget draggableImgWidget(BuildContext context, double imgWidth, double imgHeight) {
    return LongPressDraggable<int>(
      data: imgIndex,
      feedback: xfileImgWidget(img.imgFile, width: imgWidth, height: imgHeight),
      childWhenDragging: Container(
        width: imgWidth,
        height: imgHeight,
        color: Colors.grey.shade400,
      ),
      child: imgWidget(context, imgWidth, imgHeight),
    );
  }

  Widget imgWidget(BuildContext context, double imgWidth, double imgHeight) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => ViewImageScreen(ViewImageAccountContent(img.accountId, img.contentId))
              )
            );
          },
          child: xfileImgWidgetInk(img.imgFile, width: imgWidth, height: imgHeight, alignment: Alignment.topRight),
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ProfilePicturesBloc>().add(RemoveImage(imgIndex));
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}


class VisibleThumbnailPicture extends StatelessWidget {
  final ProcessedAccountImage img;
  final CropResults cropResults;
  final int imgIndex;

  const VisibleThumbnailPicture({
    required this.img,
    required this.imgIndex,
    required this.cropResults,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileThumbnailImage(
      img: img,
      cropResults: cropResults,
      size: THUMBNAIL_SIZE,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            openEditThumbnail(context, img, cropResults, imgIndex);
          },
        ),
      ),
    );
  }
}
