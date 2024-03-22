import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:image_picker/image_picker.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/media/image_processing.dart";
import "package:pihka_frontend/ui_utils/image.dart";
import "package:pihka_frontend/ui_utils/image_processing.dart";
import "package:pihka_frontend/ui_utils/initial_setup_common.dart";

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
            imageProcessingBloc: context.read<ProfilePicturesImageProcessingBloc>(),
          ),
        ],
      ),
    );
  }
}

sealed class PictureSelectionMode {}
class InitialSetupProfilePictures extends PictureSelectionMode {}
class NormalProfilePictures extends PictureSelectionMode {}

class ProfilePictureSelection extends StatefulWidget {
  final PictureSelectionMode mode;
  final ProfilePicturesImageProcessingBloc imageProcessingBloc;
  const ProfilePictureSelection({
    required this.mode,
    required this.imageProcessingBloc,
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePictureSelection createState() => _ProfilePictureSelection();
}

PictureSelectionController? _globalController;

class _ProfilePictureSelection extends State<ProfilePictureSelection> {
  late PictureSelectionController controller;

  @override
  void initState() {
    super.initState();
    var c = _globalController;
    if (c == null) {
       controller = PictureSelectionController(
        imageProcessingBloc: widget.imageProcessingBloc,
        mode: widget.mode,
        updateStateCallback: () {
          if (mounted) {
            setState(() {});
          }
        },
      );
      controller.setStateInit();
      _globalController = controller;
    } else {
      controller = c;
      controller.setStateUpdate(
        widget.mode,
        () {
          if (mounted) {
            setState(() {});
          }
        },
        widget.imageProcessingBloc,
      );
    }
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
            controller.addProcessedImage(ProfileImage(processedImg));
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
            height: 150,
            child: thumbnailArea()
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

  Widget thumbnailArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: thumbnailInfoButton(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Container()),
            imgStateToPrimaryImageThumbnail(controller.pictures[0]),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: thumbnailEditButton(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget thumbnailInfoButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.info)
    );
  }

  Widget thumbnailEditButton() {
    if (controller.pictures[0] is ImageSelected) {
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.edit)
      );
    } else {
      return Container();
    }
  }

  Widget imgStateToWidget(BuildContext context, int imgStateIndex) {
    switch (controller.pictures[imgStateIndex]) {
      case Add(): return AddPicture(imgIndex: imgStateIndex, controller: controller);
      case Hidden(): return HiddenPicture();
      case ImageSelected(:final img):
        switch (img) {
          case InitialSetupSecuritySelfie():
            final currentSecuritySelfie = context.read<InitialSetupBloc>().state.securitySelfie;
            if (currentSecuritySelfie != null) {
              return FilePicture(img: currentSecuritySelfie);
            } else {
              return AddPicture(imgIndex: imgStateIndex, controller: controller);
            }
          case ProfileImage(:final img):
            return FilePicture(img: img);
        }
    }
  }

  Widget imgStateToPrimaryImageThumbnail(ImgState imgState) {
    switch (imgState) {
      case Add(): return HiddenThumbnailPicture();
      case Hidden(): return HiddenThumbnailPicture();
      case ImageSelected(): return HiddenThumbnailPicture();
    }
  }
}


class PictureSelectionController {
  PictureSelectionMode mode;
  void Function() updateStateCallback;
  ProfilePicturesImageProcessingBloc imageProcessingBloc;
  PictureSelectionController({
    required this.mode,
    required this.updateStateCallback,
    required this.imageProcessingBloc,
  });

  List<ImgState> pictures = [];

  void setStateInit() {
    pictures = [
      Add(),
      Hidden(),
      Hidden(),
      Hidden(),
    ];
  }

  void setStateUpdate(
    PictureSelectionMode mode,
    void Function() updateStateCallback,
    ProfilePicturesImageProcessingBloc imageProcessingBloc,
  ) {
    this.updateStateCallback = updateStateCallback;
    this.imageProcessingBloc = imageProcessingBloc;

    // Reset if mode changes
    if (this.mode.runtimeType != mode.runtimeType) {
      setStateInit();
    }
    this.mode = mode;
  }

  void addImageWithConfirm(XFile file, int imgIndex) {
    imageProcessingBloc.add(ConfirmImage(file, imgIndex + 1));
  }

  void addImage(XFile file, int imgIndex) {
    imageProcessingBloc.add(SendImageToSlot(file, imgIndex + 1));
  }

  void addProcessedImage(SelectedImageInfo imgInfo) {
    switch (imgInfo) {
      case InitialSetupSecuritySelfie(:final profileImagesIndex): {
        pictures[profileImagesIndex] = ImageSelected(imgInfo);
      }
      case ProfileImage(:final img): {
        pictures[img.slot - 1] = ImageSelected(imgInfo);
      }
    }
    _updateHiddenSlotsAndRefreshUi();
  }


  void _updateHiddenSlotsAndRefreshUi() {
    for (var i = 1; i < pictures.length; i++) {
      if (pictures[i - 1] is ImageSelected && pictures[i] is Hidden) {
        // If previous slot has image, show add button
        pictures[i] = Add();
      } else if (pictures[i - 1] is Add && pictures[i] is ImageSelected) {
        // If previous slot image was removed move image to previous slot
        pictures[i - 1] = pictures[i];
        pictures[i] = Add();
      }
    }
    updateStateCallback();
  }
}

sealed class ImgState {}
class Hidden extends ImgState {}
class Add extends ImgState {}
class ImageSelected extends ImgState {
  final SelectedImageInfo img;
  ImageSelected(this.img);
}

sealed class SelectedImageInfo {}
class InitialSetupSecuritySelfie extends SelectedImageInfo {
  final int profileImagesIndex;
  InitialSetupSecuritySelfie(this.profileImagesIndex);
}
class ProfileImage extends SelectedImageInfo {
  final ProcessedAccountImage img;
  ProfileImage(this.img);
}

class AddPicture extends StatelessWidget {
  final PictureSelectionController controller;
  final int imgIndex;
  const AddPicture({
      required this.controller,
      required this.imgIndex,
      Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (controller.mode) {
          case InitialSetupProfilePictures():
            openInitialSetupActionDialog(context);
          case NormalProfilePictures():
            openActionDialog(context);
        }
      },
      child: Ink(
        width: 100,
        height: 150,
        color: Colors.grey,
        child: const Center(
          child: Icon(
            Icons.add_a_photo,
            size: 40,
            color: Colors.white,
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
          Navigator.pop(context, null);
          controller.addProcessedImage(InitialSetupSecuritySelfie(imgIndex));
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
                Navigator.pop(context, null);
                final image  = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  requestFullMetadata: false
                );
                if (image != null) {
                  controller.addImage(image, imgIndex);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_take_new_picture_title),
              onTap: () async {
                Navigator.pop(context, null);
                final image  = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  requestFullMetadata: false,
                  preferredCameraDevice: CameraDevice.front,
                );
                if (image != null) {
                  controller.addImageWithConfirm(image, imgIndex);
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
      height: 150,
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
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}


class FilePicture extends StatelessWidget {
  final ProcessedAccountImage img;

  const FilePicture({required this.img, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountImage(
      accountId: img.accountId,
      contentId: img.contentId,
      imageBuilder: (file) => xfileImgWidget(file, width: 100, height: 150),
    );
  }
}
