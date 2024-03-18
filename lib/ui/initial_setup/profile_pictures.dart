import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/ui_utils/image.dart";
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
          const ProfilePictureSelection(mode: PictureSelectionMode.initialSetup),
        ],
      ),
    );
  }
}

enum PictureSelectionMode {
  initialSetup,
  normal,
}


class ProfilePictureSelection extends StatefulWidget {
  final PictureSelectionMode mode;

  const ProfilePictureSelection({required this.mode, Key? key}) : super(key: key);
  @override
  _ProfilePictureSelection createState() => _ProfilePictureSelection();
}

class _ProfilePictureSelection extends State<ProfilePictureSelection> {

  late PictureSelectionController controller;

  @override
  void initState() {
    super.initState();
    controller = PictureSelectionController(mode: widget.mode);
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topRow(),
        const Divider(
          color: Colors.grey,
          height: 50,
        ),
        bottomRow(),
      ],
    );
  }

  Widget topRow() {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Center(
          child: imgStateToWidget(controller.pictures[0]),
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

  Widget bottomRow() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: imgStateToWidget(controller.pictures[1]),
          ),
        ),
        Expanded(
          child: Center(
            child: imgStateToWidget(controller.pictures[2]),
          ),
        ),
        Expanded(
          child: Center(
            child: imgStateToWidget(controller.pictures[3]),
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
    if (controller.pictures[0] is FileSelected) {
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.edit)
      );
    } else {
      return Container();
    }
  }

  Widget imgStateToWidget(ImgState imgState) {
    switch (imgState) {
      case Add(): return AddPicture(mode: controller.mode);
      case Hidden(): return HiddenPicture();
      case FileSelected(:final file): return FilePicture(file: file);
    }
  }

  Widget imgStateToPrimaryImageThumbnail(ImgState imgState) {
    switch (imgState) {
      case Add(): return HiddenThumbnailPicture();
      case Hidden(): return HiddenThumbnailPicture();
      case FileSelected(:final file): return HiddenThumbnailPicture();
    }
  }
}


class PictureSelectionController {
  final PictureSelectionMode mode;
  PictureSelectionController({required this.mode});

  List<ImgState> pictures = [];

  void init() {
    pictures = [
      Add(),
      Hidden(),
      Hidden(),
      Hidden(),
    ];
  }
}


sealed class ImgState {}
class Hidden extends ImgState {}
class Add extends ImgState {}
class FileSelected extends ImgState {
  final File file;
  FileSelected(this.file);
}

class AddPicture extends StatelessWidget {
  final PictureSelectionMode mode;
  const AddPicture({required this.mode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (mode) {
          case PictureSelectionMode.initialSetup:
            openInitialSetupActionDialog(context);
          case PictureSelectionMode.normal:
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
    final securitySelfieFile = context.read<InitialSetupBloc>().state.securitySelfie;
    final Widget lastOption;
    if (securitySelfieFile != null) {
      // TODO
      // Fix error
      // "A RenderFlex overflowed by 12 pixels on the right.
      // The relevant error-causing widget was:"
      final iconSize = IconTheme.of(context).size ?? 24.0;
      lastOption = ListTile(
        leading: SizedBox(
          width: iconSize,
          height: iconSize,
          child: AccountImage(accountId: securitySelfieFile.accountId, contentId: securitySelfieFile.contentId)
        ),
        title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_security_selfie_title),
        onTap: () {
          Navigator.pop(context);
        },
      );
    } else {
      lastOption = const SizedBox.shrink();
    }

    final selectedImg = showDialog<File?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_dialog_title),
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_from_gallery_title),
              onTap: () => Navigator.pop(context, null),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.strings.initial_setup_screen_profile_pictures_select_picture_take_new_picture_title),
              onTap: () => Navigator.pop(context, null),
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
  final File file;

  const FilePicture({required this.file, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      width: 100,
      height: 150,
    );
  }
}
