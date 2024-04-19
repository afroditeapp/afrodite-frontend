import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:openapi/api.dart";
import "package:path/path.dart";
import "package:pihka_frontend/data/image_cache.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/media/current_moderation_request.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/logic/media/profile_pictures.dart";
import "package:pihka_frontend/logic/media/select_content.dart";
import "package:pihka_frontend/model/freezed/logic/media/profile_pictures.dart";
import "package:pihka_frontend/ui/initial_setup/profile_basic_info.dart";
import "package:pihka_frontend/ui/normal/settings/media/select_content.dart";
import "package:pihka_frontend/ui_utils/consts/corners.dart";
import "package:pihka_frontend/ui_utils/crop_image_screen.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/image_processing.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";
import "package:pihka_frontend/ui_utils/profile_thumbnail_image.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/ui_utils/view_image_screen.dart";

class AskProfilePicturesScreen extends StatelessWidget {
  const AskProfilePicturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return commonInitialSetupScreenContent(
      context: context,
      child: QuestionAsker(
        continueButtonBuilder: (context) {
          return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
            builder: (context, state) {
              void Function()? onPressed;
              final pictures = state.pictures();
              if (pictures[0] is ImageSelected) {
                onPressed = () {
                  context.read<InitialSetupBloc>().add(SetProfileImages(pictures));
                  Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const AskProfileBasicInfoScreen()));
                };
              }

              return ElevatedButton(
                onPressed: onPressed,
                child: Text(context.strings.generic_continue),
              );
            }
          );
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
    return Column(
      children: [
        questionTitleText(context, context.strings.initial_setup_screen_profile_pictures_title),
        ProfilePictureSelection(
          mode: const InitialSetupProfilePictures(),
          profilePicturesBloc: context.read<ProfilePicturesBloc>(),
        ),
      ],
    );
  }
}


class ProfilePictureSelection extends StatefulWidget {
  /// If [mode] is null, the [ProfilePicturesBloc] should be used manually to
  /// init state.
  final PictureSelectionMode? mode;
  final ProfilePicturesBloc profilePicturesBloc;
  const ProfilePictureSelection({
    this.mode,
    required this.profilePicturesBloc,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePictureSelection> createState() => _ProfilePictureSelection();
}

class _ProfilePictureSelection extends State<ProfilePictureSelection> {

  @override
  void initState() {
    super.initState();
    final mode = widget.mode;
    if (mode != null) {
      widget.profilePicturesBloc.add(ResetIfModeChanges(mode));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> zeroSizedWidgets;
    if (widget.mode is InitialSetupProfilePictures) {
      zeroSizedWidgets = imageProcessingUiWidgets<ProfilePicturesImageProcessingBloc>(
        onComplete: (context, processedImg) {
          final id = AccountImageId(processedImg.accountId, processedImg.contentId);
          // Initial setup uses slot 0 for security selfie.
          // Other uploads are in slots 1-4. The UI logic uses 0-3 indexes.
          final index = processedImg.slot - 1;
          widget.profilePicturesBloc.add(AddProcessedImage(ProfileImage(id, processedImg.slot), index));
        },
      );
    } else {
      zeroSizedWidgets = [];
    }

    return Column(
      children: [
        topRow(context),
        const Divider(
          color: Colors.grey,
          height: 50,
        ),
        bottomRow(context),

        // Zero sized widgets
        ...zeroSizedWidgets,
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

  AccountImageId? getProcessedAccountImage(BuildContext context, ImgState imgState) {
    if (imgState is ImageSelected) {
      switch (imgState.img) {
        case InitialSetupSecuritySelfie():
          final securitySelfie = context.read<InitialSetupBloc>().state.securitySelfie;
          if (securitySelfie != null) {
            return AccountImageId(securitySelfie.accountId, securitySelfie.contentId);
          } else {
            return null;
          }
        case ProfileImage(:final id):
          return id;
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
  AccountImageId img,
  CropResults currentCrop,
  int imgStateIndex,
) async {
  // TODO: Error handling (now done?)

  final bytes = await ImageCacheData.getInstance().getImage(img.accountId, img.contentId);
  if (!context.mounted) {
    return;
  }
  if (bytes == null) {
    showSnackBar(context.strings.generic_error_occurred);
    return;
  }
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
            final state = context.read<ProfilePicturesBloc>().state;
            switch (state.mode) {
              case InitialSetupProfilePictures():
                final nextSlotIndex = state.nextAvailableSlotInInitialSetup();
                if (nextSlotIndex != null) {
                  openInitialSetupActionDialog(context, nextSlotIndex);
                }
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

  void openInitialSetupActionDialog(BuildContext context, int nextSlotIndex) {
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
          context.read<ProfilePicturesBloc>().add(AddProcessedImage(InitialSetupSecuritySelfie(), imgIndex));
          Navigator.pop(context, null);
        },
      );
    } else {
      lastOption = const SizedBox.shrink();
    }

    openSelectPictureDialog(context, lastOption: lastOption, serverSlotIndex: nextSlotIndex);
  }

  void openActionDialog(BuildContext context) async {
    final bloc = context.read<ProfilePicturesBloc>();
    final selectContentBloc = context.read<SelectContentBloc>();
    final selectedImg = await Navigator.push(context, MaterialPageRoute<AccountImageId?>(builder: (_) => SelectContentPage(
      selectContentBloc: selectContentBloc,
    )));
    if (selectedImg != null) {
      bloc.add(AddProcessedImage(ProfileImage(selectedImg, null), imgIndex));
    }
  }
}

void openSelectPictureDialog(
  BuildContext context,
  {
    Widget lastOption = const SizedBox.shrink(),
    required int serverSlotIndex,
  }
) {
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
              // TODO: Read image on client side and show error if
              // image is not JPEG.
              // TODO: Consider resizing image on client side?
              // The built in ImagePicker resizing produces poor quality
              // images at least on Android.
              final image  = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                requestFullMetadata: false
              );
              if (image != null) {
                imageProcessingBloc.add(SendImageToSlot(image, serverSlotIndex));
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
                imageProcessingBloc.add(ConfirmImage(image, serverSlotIndex));
              }
            }
          ),
          lastOption,
        ],
    )
  );
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
  final AccountImageId img;
  final int imgIndex;

  const FilePicture({required this.img, required this.imgIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const maxWidth = 150.0;
    const maxHeight = ROW_HEIGHT;

    return imgAndDeleteButton(
      context,
      maxWidth,
      maxHeight,
    );
  }

  Widget imgAndDeleteButton(
    BuildContext context,
    double maxWidth,
    double maxHeight,
  ) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) {
        context.read<ProfilePicturesBloc>().add(MoveImageTo(details.data, imgIndex));
      },
      onWillAcceptWithDetails: (details) => details.data != imgIndex,
      builder: (context, candidateData, rejectedData) {
        final acceptedCandidate = candidateData.where((element) => element != imgIndex).firstOrNull;
        final backgroundColor = acceptedCandidate == null ? Colors.transparent : Colors.grey.shade400;
        return ImgWithCloseButton(
            onCloseButtonPressed: () =>
              context.read<ProfilePicturesBloc>().add(RemoveImage(imgIndex)),
            imgWidgetBuilder: (c, width, height) => draggableImgWidget(context, width, height),
            maxHeight: maxHeight,
            maxWidth: maxWidth,
            backgroundColor: backgroundColor,
        );
      }
    );
  }

  Widget draggableImgWidget(BuildContext context, double imgWidth, double imgHeight) {
    return LongPressDraggable<int>(
      data: imgIndex,
      feedback: accountImgWidget(img.accountId, img.contentId, width: imgWidth, height: imgHeight),
      childWhenDragging: Container(
        width: imgWidth,
        height: imgHeight,
        color: Colors.grey.shade400,
      ),
      child: ImgWithCloseButton.defaultImgWidgetBuilder(context, imgWidth, imgHeight, img.accountId, img.contentId),
    );
  }
}

class ImgWithCloseButton extends StatelessWidget {
  final void Function() onCloseButtonPressed;
  final Widget Function(BuildContext context, double imgWidth, double imgHeight) imgWidgetBuilder;
  final double maxWidth;
  final double maxHeight;
  final Color backgroundColor;

  const ImgWithCloseButton({
    required this.onCloseButtonPressed,
    required this.imgWidgetBuilder,
    required this.maxWidth,
    required this.maxHeight,
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size ?? 24.0;
    final imgWidth = maxWidth - iconSize;
    final imgHeight = maxHeight - iconSize;
    return Container(
      width: maxWidth,
      height: maxHeight,
      color: backgroundColor,
      child: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: EdgeInsets.only(top: iconSize, right: iconSize, left: iconSize),
              child: imgWidgetBuilder(context, imgWidth, imgHeight),
            ),
            closeButton(context),
          ],
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
            onPressed: onCloseButtonPressed,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  static Widget defaultImgWidgetBuilder(BuildContext context, double imgWidth, double imgHeight, AccountId accountId, ContentId contentId) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Material(
        child: InkWell(
          onTap: () => openViewImageScreenForAccountImage(context, accountId, contentId),
          child: accountImgWidgetInk(accountId, contentId, width: imgWidth, height: imgHeight, alignment: Alignment.topRight),
        ),
      ),
    );
  }
}

class VisibleThumbnailPicture extends StatelessWidget {
  final AccountImageId img;
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
    return ProfileThumbnailImage.fromAccountImageId(
      img: img,
      cropResults: cropResults,
      width: THUMBNAIL_SIZE,
      height: THUMBNAIL_SIZE,
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
