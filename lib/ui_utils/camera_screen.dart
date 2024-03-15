import "dart:async";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/image.dart";

var log = Logger("CameraScreen");

List<CameraDescription> availableCamerasList = [];

Future<void> initAvailableCameras() async {
  availableCamerasList = await availableCameras();
  log.fine(availableCamerasList);
  availableCamerasList = availableCamerasList
    .where((element) => element.lensDirection == CameraLensDirection.front)
    .toList();
}

// TODO(prod): Add some camera manager as it seems to possible to
// crash the app if going to and back several times from the camera screen
// fast enough.

sealed class CameraInitState {}
class InitSuccessful extends CameraInitState {}
class InitFailed extends CameraInitState {
  final CameraInitError error;
  InitFailed(this.error);
}

enum CameraInitError {
  noCamera,
  noCameraPermissionTryAgainOrCheckSettings,
  noCameraPermissionCheckSettings,
  noCameraPermissionCameraAccessRestricted,
  initFailed;

  String get message {
    switch (this) {
      case CameraInitError.noCamera:
        return R.strings.camera_screen_no_front_camera_error;
      case CameraInitError.noCameraPermissionTryAgainOrCheckSettings:
        return R.strings.camera_screen_camera_permission_error_try_again_or_check_settings;
      case CameraInitError.noCameraPermissionCheckSettings:
        return R.strings.camera_screen_camera_permission_error_check_settings;
      case CameraInitError.noCameraPermissionCameraAccessRestricted:
        // TODO(prod): Figure out good error text
        return "Error";
      case CameraInitError.initFailed:
        return R.strings.camera_screen_camera_initialization_error;
    }
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
  with WidgetsBindingObserver {
  CameraController? currentCameraController;
  bool photoTakingInProgress = false;

  CameraInitState? cameraInitState;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  @override
  void dispose() {
    super.dispose();
    // Change back to the default orientations.
    SystemChrome.setPreferredOrientations([]);
    WidgetsBinding.instance.removeObserver(this);
    disposeCamera();
  }

  void disposeCamera() {
    currentCameraController?.dispose().then((value) {
      log.info("Camera disposed");
    });
    currentCameraController = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.fine(state);

    final initState = cameraInitState;
    if (state == AppLifecycleState.inactive) {
      disposeCamera();
    } else if (state == AppLifecycleState.resumed && initState != null && initState is InitSuccessful) {
      initCamera();
    }
  }

  void initCamera() async {
    final firstCamera = availableCamerasList.firstOrNull;
    if (firstCamera == null) {
      if (mounted) {
        setState(() {
          cameraInitState = InitFailed(CameraInitError.noCamera);
        });
      }
      return;
    }

    final controller = CameraController(
      firstCamera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    CameraInitError? error;
    try {
      await controller.initialize();
      await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
      await controller.setFocusMode(FocusMode.auto);
      await controller.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      log.error(e);
      error = switch (e.code) {
        "CameraAccessDenied" => CameraInitError.noCameraPermissionTryAgainOrCheckSettings,
        "CameraAccessDeniedWithoutPrompt" => CameraInitError.noCameraPermissionCheckSettings,
        "CameraAccessRestricted" => CameraInitError.noCameraPermissionCameraAccessRestricted,
        _ => CameraInitError.initFailed,
      };
    }

    if (mounted) {
      setState(() {
        if (error == null) {
          cameraInitState = InitSuccessful();
        } else {
          cameraInitState = InitFailed(error);
        }
        currentCameraController = controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;
    final currentCamera = currentCameraController;
    final initState = cameraInitState;
    if (currentCamera == null || initState == null || initState is InitFailed) {
      if (initState is InitFailed) {
        widgets = [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(initState.error.message),
          ),
        ];
      } else {
        widgets = [];
      }
    } else {
      widgets = [
        cameraPreview(context, currentCamera),
        controlRow(context, currentCamera),
      ];
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.generic_take_photo)),
      body: Column(children: widgets)
    );
  }

  Widget cameraPreview(BuildContext context, CameraController currentCamera) {
    final size = currentCamera.value.previewSize;
    if (size == null) {
      return Container();
    }

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final croppedImg = ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: cropFactorToAspectRatioAtLeast43(size),
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: CameraPreview(currentCamera)
                ),
              ),
            );

          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: FittedBox(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.contain,
              child: croppedImg,
            ),
          );
        }
      ),
    );
  }

  Widget simulateCameraPreview(BuildContext context, double maxWidth, double maxHeight) {
    final cropSize = Size(maxWidth, maxHeight);
    return Container(
      width: maxWidth,
      height: maxHeight * cropFactorToAspectRatioAtLeast43(cropSize),
      color: Colors.black,
    );
  }

  Widget controlRow(BuildContext context, CameraController currentCamera) {
    final Widget progress;
    if (photoTakingInProgress) {
      progress = const CircularProgressIndicator();
    } else {
      progress = Container();
    }

    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(child: progress),
          ),
          takePhotoButton(context, currentCamera),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Widget takePhotoButton(BuildContext context, CameraController currentCamera) {
    final void Function()? onPressed;
    if (photoTakingInProgress) {
      onPressed = null;
    } else {
      onPressed = () async {
        final file = await takePhoto(currentCamera);
        if (context.mounted) {
          Future.delayed(Duration.zero, () => Navigator.pop(context, file));
        }
      };
    }

    return SizedBox(
      width: 150,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.camera_alt),
        label: Text(context.strings.generic_take_photo)
      ),
    );
  }

  Future<XFile?> takePhoto(CameraController currentCamera) async {
    if (!mounted) {
      return null;
    }

    setState(() {
      photoTakingInProgress = true;
    });

    XFile? file;
    try {
      file = await currentCamera.takePicture();
      log.info(file);
    } on CameraException catch (e) {
      log.error(e);
      if (mounted) {
        showSnackBar(R.strings.camera_screen_take_photo_error);
      }
    }

    return file;
  }
}
