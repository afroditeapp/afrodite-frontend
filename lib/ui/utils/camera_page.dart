import "dart:async";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:logging/logging.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/account_banned.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/login.dart";
import 'package:pihka_frontend/ui/normal.dart';
import "package:pihka_frontend/ui/pending_deletion.dart";
import "package:pihka_frontend/ui/utils.dart";
import "package:pihka_frontend/ui_utils/snack_bar.dart";
import "package:pihka_frontend/utils.dart";

var log = Logger("CameraPage");

late List<CameraDescription> cameras = [];

Future<void> initAvailableCameras() async {
  cameras = await availableCameras();
  log.fine(cameras);
  cameras = cameras.where((element) => element.lensDirection == CameraLensDirection.front).toList();
}

// TODO: remove?
enum ImageType {
  securitySelfie,
}

class CameraPage extends StatefulWidget {
  CameraPage(this.imageType, {super.key});
  final ImageType imageType;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
  with WidgetsBindingObserver {
  CameraController? camera;
  var currentCameraIndex = 0;

  Timer? timer;
  var showNoCameraText = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    disposeCamera();
    super.dispose();
  }

  void disposeCamera() {
    camera?.dispose().then((value) {
      log.info("Camera disposed");
    });
    camera = null;
    timer?.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.fine(state);

    if (state == AppLifecycleState.inactive) {
      disposeCamera();
    } else if (state == AppLifecycleState.resumed && camera == null) {
      initCamera();
    }
  }

  void initCamera() {
    for (var cameraDescription in cameras.asMap().entries) {
      currentCameraIndex = cameraDescription.key;
      camera = CameraController(cameraDescription.value, ResolutionPreset.max, enableAudio: false); // TODO: limit resolution?
      camera?.initialize().then((_) async {
        await camera?.setFocusMode(FocusMode.auto);

        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          // TODO: handle errors.
          log.error(e);
        }
      });
    }

    // Timer prevents displaying the text for a short time before the preview
    // opens.
    timer = Timer(const Duration(seconds: 1), () {
      var currentCamera = camera;
      if (currentCamera == null || !currentCamera.value.isInitialized) {
        setState(() {
          showNoCameraText = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;
    var currentCamera = camera;
    if (currentCamera == null || !currentCamera.value.isInitialized) {
      if (showNoCameraText) {
        widgets = const [Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No front camera available"),
        )];
      } else {
        widgets = [];
      }
    } else {
      widgets = [
        Expanded(child: CameraPreview(currentCamera)),
        SizedBox(
          height: 100,
          child: Row(
            children: [
              const Text(""),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 150, height: 70, child: ElevatedButton.icon(onPressed: () async {
                    final file = await takePicture(currentCamera);
                    if (file != null) {
                      Future.delayed(Duration.zero, () => Navigator.pop(context, file));
                    }
                  }, icon: const Icon(Icons.camera_alt), label: const Text("Take photo"),)),
                ],
              )),
              const Text(""),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Take image")),
      body: Column(children: widgets)
    );
  }

  Future<XFile?> takePicture(CameraController currentCamera) async {
    if (currentCamera.value.isTakingPicture) {
      showSnackBar("Picture taking already in progress");
    } else {
      try {
        var file = await currentCamera.takePicture();
        log.info(file);
        if (widget.imageType == ImageType.securitySelfie) {
          return file;
        } else {
          showSnackBar("Unknown image type");
        }
      } on CameraException catch (e) {
        log.error(e);
        showSnackBar("Taking picture failed");
      }
    }

    return null;
  }
}
