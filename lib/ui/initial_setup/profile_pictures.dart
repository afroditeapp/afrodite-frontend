import "package:app/logic/media/new_moderation_request.dart";
import "package:app/ui_utils/consts/padding.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:logging/logging.dart";
import "package:openapi/api.dart";
import "package:utils/utils.dart";
import "package:app/data/image_cache.dart";
import "package:app/data/login_repository.dart";
import "package:app/localizations.dart";
import "package:app/logic/account/initial_setup.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/logic/media/image_processing.dart";
import "package:app/logic/media/profile_pictures.dart";
import "package:app/logic/media/select_content.dart";
import "package:app/model/freezed/logic/main/navigator_state.dart";
import "package:app/model/freezed/logic/media/profile_pictures.dart";
import "package:app/ui/initial_setup/profile_basic_info.dart";
import "package:app/ui/normal/settings/media/select_content.dart";
import "package:app/ui_utils/consts/corners.dart";
import "package:app/ui_utils/crop_image_screen.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/image.dart";
import "package:app/ui_utils/image_processing.dart";
import "package:app/ui_utils/initial_setup_common.dart";
import "package:app/ui_utils/profile_thumbnail_image.dart";
import "package:app/ui_utils/snack_bar.dart";
import "package:app/ui_utils/view_image_screen.dart";
import 'package:image/image.dart' as img;

final log = Logger("ProfilePictures");

class AskProfilePicturesScreen extends StatelessWidget {
  const AskProfilePicturesScreen({super.key});

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
              final primaryPicture = pictures[0];
              if (primaryPicture is ImageSelected && primaryPicture.img.isFaceDetected()) {
                onPressed = () {
                  context.read<InitialSetupBloc>().add(SetProfileImages(pictures));
                  MyNavigator.push(
                    context,
                    const MaterialPage<void>(child: AskProfileBasicInfoScreen()),
                  );
                };
              }

              return ElevatedButton(
                onPressed: onPressed,
                child: Text(context.strings.generic_continue),
              );
            },
          );
        },
        question: const AskProfilePictures(),
      ),
      showRefreshProfilePicturesFaceDetectedValuesAction: true,
    );
  }
}

const ROW_HEIGHT = 150.0;
const THUMBNAIL_SIZE = 100.0;

class AskProfilePictures extends StatefulWidget {
  const AskProfilePictures({super.key});

  @override
  State<AskProfilePictures> createState() => _AskProfilePicturesState();
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
  const ProfilePictureSelection({this.mode, required this.profilePicturesBloc, super.key});

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
          final id = AccountImageId(
            processedImg.accountId,
            processedImg.contentId,
            processedImg.faceDetected,
            false,
          );
          final nextAddImgState = widget.profilePicturesBloc.state
              .pictures()
              .indexed
              .where((element) => element.$2 is Add)
              .firstOrNull;
          final int index;
          if (nextAddImgState != null) {
            index = nextAddImgState.$1;
          } else {
            return;
          }
          widget.profilePicturesBloc.add(
            AddProcessedImage(ProfileImage(id, processedImg.slot), index),
          );
        },
      );
    } else {
      zeroSizedWidgets = [];
    }

    return Column(
      children: [
        topRow(context),
        primaryImageIsNotFaceImageError(),
        if (widget.profilePicturesBloc.state.mode is NormalProfilePictures)
          primaryImageIsNotAcceptedError(),
        const Divider(height: 50),
        bottomRow(context),

        // Zero sized widgets
        ...zeroSizedWidgets,
      ],
    );
  }

  Widget topRow(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Center(child: imgStateToWidget(context, 0))),
        Expanded(
          flex: 2,
          child: Center(
            child: SizedBox(height: ROW_HEIGHT, child: thumbnailArea(context)),
          ),
        ),
      ],
    );
  }

  Widget bottomRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Center(child: imgStateToWidget(context, 1))),
        Expanded(child: Center(child: imgStateToWidget(context, 2))),
        Expanded(child: Center(child: imgStateToWidget(context, 3))),
      ],
    );
  }

  Widget thumbnailArea(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Align(alignment: Alignment.topRight, child: primaryImageInfoButton(context)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Container()),
            imgStateToPrimaryImageThumbnail(0),
            Flexible(
              child: Align(alignment: Alignment.centerLeft, child: thumbnailEditButton(0)),
            ),
          ],
        ),
      ],
    );
  }

  Widget primaryImageInfoButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        showInfoDialog(
          context,
          context
              .strings
              .initial_setup_screen_profile_pictures_primary_image_info_dialog_description,
        );
      },
      icon: const Icon(Icons.info),
    );
  }

  Widget thumbnailEditButton(int imgStateIndex) {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) =>
          previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        final img = getProcessedAccountImage(context, imgState);
        if (img != null && imgState is ImageSelected) {
          return IconButton(
            onPressed: () {
              openEditThumbnail(context, img, imgState.cropArea, imgStateIndex);
            },
            icon: const Icon(Icons.edit),
          );
        } else {
          return Container();
        }
      },
    );
  }

  AccountImageId? getProcessedAccountImage(BuildContext context, ImgState imgState) {
    if (imgState is ImageSelected) {
      switch (imgState.img) {
        case InitialSetupSecuritySelfie():
          final securitySelfie = context.read<InitialSetupBloc>().state.securitySelfie;
          if (securitySelfie != null) {
            return AccountImageId(
              securitySelfie.accountId,
              securitySelfie.contentId,
              securitySelfie.faceDetected,
              false,
            );
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
      buildWhen: (previous, current) =>
          previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        switch (imgState) {
          case Add():
            return AddPicture(imgIndex: imgStateIndex);
          case Hidden():
            return const HiddenPicture();
          case ImageSelected():
            final processedImg = getProcessedAccountImage(context, imgState);
            if (processedImg != null) {
              return FilePicture(img: processedImg, imgIndex: imgStateIndex);
            } else {
              return AddPicture(imgIndex: imgStateIndex);
            }
        }
      },
    );
  }

  Widget imgStateToPrimaryImageThumbnail(int imgStateIndex) {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) =>
          previous.pictures()[imgStateIndex] != current.pictures()[imgStateIndex],
      builder: (context, state) {
        final imgState = state.pictures()[imgStateIndex];
        switch (imgState) {
          case Add():
            return const HiddenThumbnailPicture();
          case Hidden():
            return const HiddenThumbnailPicture();
          case ImageSelected(:final cropArea):
            {
              final processedImg = getProcessedAccountImage(context, imgState);
              if (processedImg != null) {
                return VisibleThumbnailPicture(
                  img: processedImg,
                  imgIndex: imgStateIndex,
                  cropArea: cropArea,
                );
              } else {
                return const HiddenThumbnailPicture();
              }
            }
        }
      },
    );
  }

  Widget primaryImageIsNotFaceImageError() {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) => previous.pictures()[0] != current.pictures()[0],
      builder: (context, state) {
        final imgState = state.pictures()[0];
        if (imgState is ImageSelected && !imgState.img.isFaceDetected()) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.close, color: Colors.red, size: 32),
                Text(
                  context
                      .strings
                      .initial_setup_screen_profile_pictures_primary_image_face_not_detected,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget primaryImageIsNotAcceptedError() {
    return BlocBuilder<ProfilePicturesBloc, ProfilePicturesData>(
      buildWhen: (previous, current) => previous.pictures()[0] != current.pictures()[0],
      builder: (context, state) {
        final imgState = state.pictures()[0];
        if (imgState is ImageSelected && !imgState.img.isAccepted()) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: COMMON_SCREEN_EDGE_PADDING,
              right: COMMON_SCREEN_EDGE_PADDING,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, size: 32, color: Theme.of(context).primaryColor),
                const Padding(padding: EdgeInsets.only(left: 8.0)),
                Flexible(
                  child: Text(
                    context.strings.edit_profile_screen_primary_profile_content_not_accepted,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Future<void> openEditThumbnail(
  BuildContext context,
  AccountImageId img,
  CropArea currentCrop,
  int imgStateIndex,
) async {
  final bytes = await ImageCacheData.getInstance().getImage(
    img.accountId,
    img.contentId,
    media: LoginRepository.getInstance().repositories.media,
  );
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
  await MyNavigator.push<CropArea>(
    context,
    MaterialPage<CropArea>(
      child: CropImageScreen(
        info: CropImageFileContent(
          img.accountId,
          img.contentId,
          flutterImg.width,
          flutterImg.height,
          currentCrop,
        ),
        onCropAreaChanged: (cropArea) {
          if (cropArea != null && context.mounted) {
            context.read<ProfilePicturesBloc>().add(UpdateCropArea(cropArea, imgStateIndex));
          }
        },
      ),
    ),
  );
}

class AddPicture extends StatelessWidget {
  final int imgIndex;
  const AddPicture({required this.imgIndex, super.key});

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
            child: accountImgWidget(
              securitySelfie.accountId,
              securitySelfie.contentId,
              cacheSize: ImageCacheSize.constantSquare(context, iconSize),
            ),
          ),
        ),
        title: Text(
          context
              .strings
              .initial_setup_screen_profile_pictures_select_picture_security_selfie_title,
        ),
        onTap: () {
          context.read<ProfilePicturesBloc>().add(
            AddProcessedImage(InitialSetupSecuritySelfie(), imgIndex),
          );
          MyNavigator.pop(context, null);
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
    final newModerationRequestBloc = context.read<NewModerationRequestBloc>();
    final selectedImg = await MyNavigator.push(
      context,
      MaterialPage<AccountImageId?>(
        child: SelectContentPage(
          selectContentBloc: selectContentBloc,
          newModerationRequestBloc: newModerationRequestBloc,
          identifyFaceImages: imgIndex == 0,
        ),
      ),
    );
    if (selectedImg != null) {
      bloc.add(AddProcessedImage(ProfileImage(selectedImg, null), imgIndex));
    }
  }
}

void openSelectPictureDialog(
  BuildContext context, {
  Widget lastOption = const SizedBox.shrink(),
  required int serverSlotIndex,
}) {
  final pageKey = PageKey();
  MyNavigator.showDialog<void>(
    context: context,
    pageKey: pageKey,
    builder: (context) => SimpleDialog(
      title: Text(
        context.strings.initial_setup_screen_profile_pictures_select_picture_dialog_title,
      ),
      children: [
        ListTile(
          leading: const Icon(Icons.photo),
          title: Text(
            context.strings.initial_setup_screen_profile_pictures_select_picture_from_gallery_title,
          ),
          onTap: () async {
            final imageProcessingBloc = context.read<ProfilePicturesImageProcessingBloc>();
            MyNavigator.removePage(context, pageKey, null);

            try {
              final image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
                requestFullMetadata: false,
              );

              if (image != null) {
                final imageBytes = await image.readAsBytes();

                final decodedImg = img.decodeJpg(imageBytes);
                if (decodedImg == null) {
                  showSnackBar(
                    R.strings.initial_setup_screen_profile_pictures_unsupported_image_error,
                  );
                  return;
                }

                imageProcessingBloc.add(SendImageToSlot(imageBytes, serverSlotIndex));
              }
            } catch (e) {
              log.error("Picking image failed");
              log.finest("$e");
            }
          },
        ),
        if (!kIsWeb)
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(
              context
                  .strings
                  .initial_setup_screen_profile_pictures_select_picture_take_new_picture_title,
            ),
            onTap: () async {
              final imageProcessingBloc = context.read<ProfilePicturesImageProcessingBloc>();
              MyNavigator.removePage(context, pageKey, null);

              try {
                final image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  requestFullMetadata: false,
                  preferredCameraDevice: CameraDevice.front,
                );
                if (image != null) {
                  final imageBytes = await image.readAsBytes();
                  imageProcessingBloc.add(ConfirmImage(imageBytes, serverSlotIndex));
                }
              } catch (e) {
                log.error("Taking image failed");
                log.finest("$e");
              }
            },
          ),
        lastOption,
      ],
    ),
  );
}

class HiddenPicture extends StatelessWidget {
  const HiddenPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: ROW_HEIGHT,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}

class HiddenThumbnailPicture extends StatelessWidget {
  const HiddenThumbnailPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: THUMBNAIL_SIZE,
      height: THUMBNAIL_SIZE,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
        borderRadius: BorderRadius.circular(PROFILE_PICTURE_BORDER_RADIUS),
      ),
    );
  }
}

class FilePicture extends StatelessWidget {
  final AccountImageId img;
  final int imgIndex;

  const FilePicture({required this.img, required this.imgIndex, super.key});

  @override
  Widget build(BuildContext context) {
    const maxWidth = 150.0;
    const maxHeight = ROW_HEIGHT;

    return imgAndDeleteButton(context, maxWidth, maxHeight);
  }

  Widget imgAndDeleteButton(BuildContext context, double maxWidth, double maxHeight) {
    return DragTarget<int>(
      onAcceptWithDetails: (details) {
        context.read<ProfilePicturesBloc>().add(MoveImageTo(details.data, imgIndex));
      },
      onWillAcceptWithDetails: (details) => details.data != imgIndex,
      builder: (context, candidateData, rejectedData) {
        final acceptedCandidate = candidateData.where((element) => element != imgIndex).firstOrNull;
        final backgroundColor = acceptedCandidate == null
            ? Colors.transparent
            : Theme.of(context).colorScheme.surfaceContainerHighest;
        return ImgWithCloseButton(
          onCloseButtonPressed: () =>
              context.read<ProfilePicturesBloc>().add(RemoveImage(imgIndex)),
          imgWidgetBuilder: (c, width, height) => draggableImgWidget(context, width, height),
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          backgroundColor: backgroundColor,
        );
      },
    );
  }

  Widget draggableImgWidget(BuildContext context, double imgWidth, double imgHeight) {
    return LongPressDraggable<int>(
      data: imgIndex,
      feedback: accountImgWidget(
        img.accountId,
        img.contentId,
        width: imgWidth,
        height: imgHeight,
        cacheSize: ImageCacheSize.constantWidthAndHeight(context, imgWidth, imgHeight),
      ),
      childWhenDragging: Container(
        width: imgWidth,
        height: imgHeight,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: ImgWithCloseButton.defaultImgWidgetBuilder(
        context,
        imgWidth,
        imgHeight,
        img.accountId,
        img.contentId,
      ),
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
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          IconButton(onPressed: onCloseButtonPressed, icon: const Icon(Icons.close_rounded)),
        ],
      ),
    );
  }

  static Widget defaultImgWidgetBuilder(
    BuildContext context,
    double imgWidth,
    double imgHeight,
    AccountId accountId,
    ContentId contentId,
  ) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => openViewImageScreenForAccountImage(context, accountId, contentId),
          child: accountImgWidgetInk(
            accountId,
            contentId,
            width: imgWidth,
            height: imgHeight,
            alignment: Alignment.topRight,
            cacheSize: ImageCacheSize.constantWidthAndHeight(context, imgWidth, imgHeight),
          ),
        ),
      ),
    );
  }
}

class VisibleThumbnailPicture extends StatelessWidget {
  final AccountImageId img;
  final CropArea cropArea;
  final int imgIndex;

  const VisibleThumbnailPicture({
    required this.img,
    required this.imgIndex,
    required this.cropArea,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileThumbnailImage(
      accountId: img.accountId,
      contentId: img.contentId,
      cropArea: cropArea,
      width: THUMBNAIL_SIZE,
      height: THUMBNAIL_SIZE,
      cacheSize: ImageCacheSize.constantSquare(context, THUMBNAIL_SIZE),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            openEditThumbnail(context, img, cropArea, imgIndex);
          },
        ),
      ),
    );
  }
}
