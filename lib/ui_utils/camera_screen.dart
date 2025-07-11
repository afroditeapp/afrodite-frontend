import "dart:async";

import "package:app/config.dart";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:logging/logging.dart";
import "package:app/localizations.dart";
import "package:app/logic/app/navigator_state.dart";
import "package:app/ui_utils/dialog.dart";
import "package:app/ui_utils/snack_bar.dart";
import 'package:utils/utils.dart';
import "package:app/utils/camera.dart";
import "package:app/utils/image.dart";

import 'package:image/image.dart' as img;

var log = Logger("CameraScreen");

sealed class CameraInitState {}
class InitSuccessful extends CameraInitState {}
class InitFailed extends CameraInitState {
  final CameraInitError error;
  InitFailed(this.error);
}

class CameraScreen extends StatefulWidget {
  final CameraControllerWrapper? controller;
  const CameraScreen({this.controller, super.key});

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

  ShutterController shutterController = ShutterController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addObserver(this);

    final c = widget.controller;
    final Stream<CameraManagerState> eventStream;
    if (c != null) {
      eventStream = CameraManager.getInstance().stateEvents();
      cameraInitState = InitSuccessful();
      controller = c;
    } else {
      eventStream = CameraManager.getInstance().openNewControllerAndThenEvents();
    }
    stateListener = eventStream.listen((state) {
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
    stateListener?.cancel();
    stateListener = null;
    controller?.dispose();
    controller = null;
    CameraManager.getInstance().sendCmd(CloseCmd());
    SystemChrome.setPreferredOrientations(DEFAULT_ORIENTATIONS);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
          if (!context.mounted) {
            return;
          }
          showInfoDialog(context, initState.error.message)
            .then((_) {
              if (context.mounted) {
                MyNavigator.pop(context, null);
              }
            });
        });
      }
      log.info("Simulating camera preview");
      preview = simulateCameraPreview(context);
    } else {
      log.info("Camera preview possible");
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
      log.info("Preview size null, simulating camera preview");
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
              AnimatedShutter(controller: shutterController),
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
        Future.delayed(Duration.zero, () {
          if (!context.mounted) {
            return;
          }
          MyNavigator.pop(context, file);
        });
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

  Future<Uint8List?> takePhoto(CameraController currentCamera) async {
    if (!mounted) {
      return null;
    }

    shutterController.startShutter();
    setState(() {
      photoTakingInProgress = true;
    });

    XFile file;
    try {
      file = await currentCamera.takePicture();
    } on CameraException catch (e) {
      log.error("Take picture error");
      log.fine(e);
      if (mounted) {
        showSnackBar(R.strings.camera_screen_take_photo_error);
      }
      return null;
    }

    final processedImgBytes = await processImage(file);
    if (processedImgBytes == null) {
      if (mounted) {
        showSnackBar(R.strings.camera_screen_take_photo_error);
      }
    }
    return processedImgBytes;
  }

  // TODO(web): Support landscape images when cropping image

  Future<Uint8List?> processImage(XFile file) async {
    try {
      final decodedImg = img.decodeJpg(await file.readAsBytes());
      if (decodedImg == null) {
        return null;
      }

      logImageSize(decodedImg, "decodedImg");

      // Maybe orientation should be baked? It should turn the image pixels
      // to portrait.
      final orientationBakedImage = img.bakeOrientation(decodedImg);
      logImageSize(orientationBakedImage, "orientationBakedImage");
      final croppedImage = await cropToAspectRatio43(orientationBakedImage);
      logImageSize(croppedImage, "croppedImage");

      final finalImg = img.copyFlip(croppedImage, direction: img.FlipDirection.horizontal);
      final finalImgBytes = img.encodeJpg(finalImg);
      logFinalImageFileSize(finalImgBytes.length);
      return finalImgBytes;
    } on img.ImageException catch (e) {
      log.error("Image processing error");
      log.fine(e);
      return null;
    }
  }
}

void logFinalImageFileSize(int byteCount) {
  final kb = byteCount / 1024;
  log.fine("Image size: $kb KB");
}

void logImageSize(img.Image imgData, String info) {
  log.fine("$info size: ${imgData.width}x${imgData.height}");
}

Future<img.Image> cropToAspectRatio43(img.Image imgData) async {
  final s = Size(imgData.width.toDouble(), imgData.height.toDouble());
  final factor = cropFactorToAspectRatioAtLeast43(s);
  final img.Image croppedImage;
  if (imgData.width > imgData.height) {
    final newWidth = imgData.width * factor;
    log.fine("newWidth: $newWidth");
    croppedImage = img.copyCrop(imgData, x: 0, y: 0, width: newWidth.toInt(), height: imgData.height);
  } else {
    final newHeight = imgData.height * factor;
    log.fine("newHeight: $newHeight");
    croppedImage = img.copyCrop(imgData, x: 0, y: 0, width: imgData.width, height: newHeight.toInt());
  }

  return croppedImage;
}


class ShutterController {
  void Function()? _startShutterCallback;
  void startShutter() {
    _startShutterCallback?.call();
  }
}

class AnimatedShutter extends StatefulWidget {
  final ShutterController controller;
  const AnimatedShutter({required this.controller, super.key});

  @override
  State<AnimatedShutter> createState() => _AnimatedShutterState();
}

class _AnimatedShutterState extends State<AnimatedShutter>
    with SingleTickerProviderStateMixin {
  Animation<int>? _opacityAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    widget.controller._startShutterCallback = () {
      if (!mounted) {
        return;
      }

      const MIDDLE_VALUE = 50;
      const DURATION = Duration(milliseconds: 200);

      final opacityTween = TweenSequence([
        // Animation using two items:
        // TweenSequenceItem(
        //   tween: IntTween(
        //     begin: 0,
        //     end: MIDDLE_VALUE,
        //   ),
        //   weight: 0.5
        // ),
        // TweenSequenceItem(
        //   tween: IntTween(
        //     begin: MIDDLE_VALUE,
        //     end: 0,
        //   ),
        //   weight: 0.5
        // ),

        // Single item version
        TweenSequenceItem(
          tween: IntTween(
            begin: MIDDLE_VALUE,
            end: 0,
          ),
          weight: 1.0
        ),
      ]);

      _controller.duration = DURATION;
      _opacityAnimation = opacityTween.animate(_controller);
      _controller
          ..reset()
          ..forward();
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = _opacityAnimation;
    if (a == null) {
      return Container();
    }

    final color = Color.fromARGB(a.value, 0, 0, 0);
    return Container(color: color);
  }
}
