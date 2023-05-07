import "dart:async";

import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pihka_frontend/logic/account/initial_setup.dart";
import "package:pihka_frontend/logic/app/main_state.dart";
import "package:pihka_frontend/ui/account_banned.dart";
import "package:pihka_frontend/ui/initial_setup.dart";
import "package:pihka_frontend/ui/login.dart";
import "package:pihka_frontend/ui/main/home.dart";
import "package:pihka_frontend/ui/pending_deletion.dart";
import "package:pihka_frontend/ui/utils.dart";


late List<CameraDescription> cameras = [];

Future<void> initAvailableCameras() async {
  cameras = await availableCameras();
  print(cameras);
  cameras = cameras.where((element) => element.lensDirection == CameraLensDirection.front).toList();
}

enum ImageType {
  securitySelfie,
}

class CameraPage extends StatefulWidget {
  CameraPage(this.imageType, {super.key});
  final ImageType imageType;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController? camera;
  var currentCameraIndex = 0;

  late Timer timer;
  var showNoCameraText = false;

  @override
  void initState() {
    super.initState();
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
          print(e);
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
  void dispose() {
    camera?.dispose();
    super.dispose();
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
                    await takePicture(currentCamera);
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

  Future<void> takePicture(CameraController currentCamera) async {
    if (currentCamera.value.isTakingPicture) {
      showSnackBar(context, "Picture taking already in progress");
    } else {
      try {
        var file = await currentCamera.takePicture();
        print(file.mimeType);
        print(file.hashCode);
        print(file.path);
        print(file.runtimeType);
        print(file.name);
        if (widget.imageType == ImageType.securitySelfie) {
          context.read<InitialSetupBloc>().add(SetSecuritySelfie(file));
          Navigator.pop(context);
        } else {
          showSnackBar(context, "Unknown image type");
        }
      } on CameraException catch (e) {
        print(e);
        showSnackBar(context, "Taking picture failed");
      }
    }

  }
}
