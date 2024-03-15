import "dart:async";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/localizations.dart";
import "package:pihka_frontend/ui_utils/dialog.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";
import "package:pihka_frontend/utils/camera.dart";
import "package:pihka_frontend/utils/image.dart";

var log = Logger("CameraScreen");

sealed class CameraInitState {}
class InitSuccessful extends CameraInitState {}
class InitFailed extends CameraInitState {
  final CameraInitError error;
  InitFailed(this.error);
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
  with WidgetsBindingObserver {
  bool photoTakingInProgress = false;
  bool errorDialogOpened = false;

  CameraControllerWrapper? controller;
  CameraInitState? cameraInitState;
  StreamSubscription<CameraManagerState>? stateListener;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addObserver(this);

    stateListener = CameraManager.getInstance().opeNewControllerAndThenEvents().listen((state) {
      if (!mounted) {
        return;
      }

      switch (state) {
        case Closed(:final error): {
           if (error != null) {
            setState(() {
              cameraInitState = InitFailed(error);
            });
          }
        }
        case DisposeOngoing(): {}
        case Open(:final controller): {
          setState(() {
            cameraInitState = InitSuccessful();
            this.controller = controller;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    stateListener?.cancel();
    // Change back to the default orientations.
    SystemChrome.setPreferredOrientations([]);
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.fine(state);

    final c = controller;
    final s = cameraInitState;
    if (state == AppLifecycleState.inactive) {
      log.info("Inactive");
      controller?.dispose();
      if (mounted) {
        setState(() {
          controller = null;
        });
      }
    } else if (state == AppLifecycleState.resumed && c == null && s is InitSuccessful) {
      log.info("Resumed");
      CameraManager.getInstance().sendCmd(OpenCmd());
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCamera = controller?.getController();
    final initState = cameraInitState;
    Widget preview;
    if (currentCamera == null || initState == null || initState is InitFailed) {
      if (initState is InitFailed && !errorDialogOpened) {
        errorDialogOpened = true;

        Future.delayed(Duration.zero, () {
           showInfoDialog(context, initState.error.message)
            .then((_) {
              if (context.mounted) {
                Navigator.pop(context, null);
              }
            });
        });
      }
      preview = simulateCameraPreview(context);
    } else {
      preview = cameraPreview(context, currentCamera);
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.strings.generic_take_photo)),
      body: Column(
        children: [
          preview,
          controlRow(context, currentCamera),
        ]
      )
    );
  }

  Widget cameraPreview(BuildContext context, CameraController currentCamera) {
    final size = currentCamera.value.previewSize;
    if (size == null) {
      return simulateCameraPreview(context);
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

          final img = SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: FittedBox(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.contain,
              child: croppedImg,
            ),
          );

          return Stack(
            children: [
              emptyCameraPreviewArea(context, constraints.maxWidth, constraints.maxHeight),
              img,
            ],
          );
        }
      ),
    );
  }

  Widget simulateCameraPreview(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return emptyCameraPreviewArea(context, constraints.maxWidth, constraints.maxHeight);
        }
      ),
    );
  }

  Widget emptyCameraPreviewArea(BuildContext context, double maxWidth, double maxHeight) {
    final cropSize = Size(maxWidth, maxHeight);
    return Container(
      width: maxWidth,
      height: maxHeight * cropFactorToAspectRatioAtLeast43(cropSize),
      color: Colors.black,
    );
  }

  Widget controlRow(BuildContext context, CameraController? currentCamera) {
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

  Widget takePhotoButton(BuildContext context, CameraController? currentCamera) {
    final void Function()? onPressed;
    if (photoTakingInProgress) {
      onPressed = null;
    } else {
      onPressed = () async {
        if (currentCamera == null) {
          return;
        }
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
