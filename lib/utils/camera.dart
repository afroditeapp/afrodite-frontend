



import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:pihka_frontend/localizations.dart';
import 'package:pihka_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';

var log = Logger("CameraManager");


sealed class CameraInitError {
  String get message {
    return switch (this) {
      NoCamera() => R.strings.camera_screen_no_front_camera_error,
      NoCameraPermissionTryAgainOrCheckSettings() =>
        R.strings.camera_screen_camera_permission_error_try_again_or_check_settings,
      NoCameraPermissionCheckSettings() =>
        R.strings.camera_screen_camera_permission_error_check_settings,
      NoCameraPermissionCameraAccessRestricted() =>
        // TODO(prod): Figure out good error text
        "Error",
      InitFailedWithErrorCode(:final code) =>
        "${R.strings.camera_screen_camera_initialization_error_with_error_code} $code",
      InitFailed() =>
        R.strings.camera_screen_camera_initialization_error,
    };
  }
}
class NoCamera extends CameraInitError {}
class NoCameraPermissionTryAgainOrCheckSettings extends CameraInitError {}
class NoCameraPermissionCheckSettings extends CameraInitError {}
class NoCameraPermissionCameraAccessRestricted extends CameraInitError {}
class InitFailedWithErrorCode extends CameraInitError {
  final int code;
  InitFailedWithErrorCode(this.code);
}
class InitFailed extends CameraInitError {}

enum ScheduledAction {
  openCameraAgain,
  /// Clear CameraManagerState
  closeComplately,
}

sealed class CameraManagerState {}
class Closed extends CameraManagerState {
  final CameraInitError? error;
  Closed(this.error);
}
class DisposeOngoing extends CameraManagerState {}
class Open extends CameraManagerState {
  final CameraControllerWrapper controller;
  Open(this.controller);
}

sealed class CameraManagerCmd {}
/// Close camera if open. Before sending this command, make sure
/// that CameraPreview does not try to use the camera anymore.
class CloseCmd extends CameraManagerCmd {}
/// Open camera if closed. Schedule to open camera again if camera
/// disposing is ongoing.
class OpenCmd extends CameraManagerCmd {}
class EventDisposeStart extends CameraManagerCmd {}
class EventDisposeComplete extends CameraManagerCmd {}


class CameraManager extends AppSingleton {
  CameraManager._private();
  static final _instance = CameraManager._private();
  factory CameraManager.getInstance() {
    return _instance;
  }

  int deadlockDebugValue = 0;
  ScheduledAction? action;
  bool managerInitCompleted = false;
  List<CameraDescription> availableCamerasList = [];

  final BehaviorSubject<CameraManagerState> _state =
    BehaviorSubject.seeded(Closed(null));

  final PublishSubject<CameraManagerCmd> _cmds =
    PublishSubject();

  CameraManagerState get _currentState => _state.value;

  @override
  Future<void> init() async {
    if (managerInitCompleted) {
      return;
    }
    managerInitCompleted = true;

    await _initAvailableCameras();

    _cmds.stream
      .asyncMap((event) async => await _runCmd(event))
      .listen((event) {});

    _state.stream
      .listen((event) {
        log.info("CameraManagerState: $event");
      });
  }

  Future<void> _runCmd(CameraManagerCmd cmd) async {
    log.info("start CameraManagerCmd: $cmd");
    switch (cmd) {
      case OpenCmd():
        await _openCameraCmd();
      case CloseCmd():
        await _closeCmd();
      case EventDisposeStart():
        await _disposeStarted();
      case EventDisposeComplete():
        await _disposeCompleted();
    }
    log.info("end CameraManagerCmd: $cmd");
  }

  Future<void> _initAvailableCameras() async {
    availableCamerasList = await availableCameras();
    log.fine(availableCamerasList);
    availableCamerasList = availableCamerasList
      .where((element) => element.lensDirection == CameraLensDirection.front)
      .toList();
  }

  Future<void> _openCameraCmd() async {
    switch (_currentState) {
      case DisposeOngoing(): {
        log.info("Open camera again after camera disposing is done");
        action = ScheduledAction.openCameraAgain;
        return;
      }
      case Open(): {
        log.info("Camera already open");
        return;
      }
      case Closed(): {}
    }

    final firstCamera = availableCamerasList.firstOrNull;
    if (firstCamera == null) {
      _state.add(Closed(NoCamera()));
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
      deadlockDebugValue = 1;
      await controller.initialize();

      final timeout = await Future.any<bool>([
        Future<bool>.delayed(const Duration(seconds: 4), () => true),
        setControllerSettingsAfterInit(controller).then((value) => false),
      ]);

      if (timeout) {
        log.error("Camera init timeout, deadlock debug value $deadlockDebugValue");
        error = InitFailedWithErrorCode(deadlockDebugValue);
      }
    } on CameraException catch (e) {
      log.error(e);
      error = switch (e.code) {
        "CameraAccessDenied" => NoCameraPermissionTryAgainOrCheckSettings(),
        "CameraAccessDeniedWithoutPrompt" => NoCameraPermissionCheckSettings(),
        "CameraAccessRestricted" => NoCameraPermissionCameraAccessRestricted(),
        _ => InitFailed(),
      };
    }

    if (error == null) {
      _state.add(Open(CameraControllerWrapper(controller)));
    } else {
      log.info("Camera init failed: $error");
      await controller.dispose();
      _state.add(Closed(error));
    }
  }

  Future<void> setControllerSettingsAfterInit(CameraController controller) async {
    deadlockDebugValue = 2;
    await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    deadlockDebugValue = 3;
    await controller.setFocusMode(FocusMode.auto);
    deadlockDebugValue = 4;
    // On Android emulator (Pixel 2 API 31) this has deadlocked
    // after going in and out from camera screen several times.
    await controller.setFlashMode(FlashMode.off);
    deadlockDebugValue = 5;
  }

  Future<void> _closeCmd() async {
    switch (_currentState) {
      case Open(:final controller): {
        if (controller.isDisposed()) {
          action = null;
          _state.add(Closed(null));
        } else {
          action = ScheduledAction.closeComplately;
          controller.dispose();
        }
      }
      case DisposeOngoing(): {
        action = ScheduledAction.closeComplately;
      }
      case Closed(): {
        action = null;
        _state.add(Closed(null));
      }
    }
  }

  Future<void> _disposeStarted() async {
    if (_currentState is Open) {
      _state.add(DisposeOngoing());
    }
  }

  Future<void> _disposeCompleted() async {
    final a = action;
    action = null;
    switch (a) {
      case ScheduledAction.openCameraAgain: {
        if (_state.value case Closed(:final error)) {
            _state.add(Closed(error));
        } else {
          _state.add(Closed(null));
        }
        await _openCameraCmd();
      }
      case ScheduledAction.closeComplately: {
        _state.add(Closed(null));
      }
      case null: {
        if (_state.value case Closed(:final error)) {
            _state.add(Closed(error));
        } else {
          _state.add(Closed(null));
        }
      }
    }
  }

  void sendCmd(CameraManagerCmd cmd) {
    _cmds.add(cmd);
  }

  Stream<CameraManagerState> opeNewControllerAndThenEvents() async* {
    log.info("openNewAndThenEvents");

    sendCmd(CloseCmd());
    await _state.firstWhere((element) => element is Closed);
    sendCmd(OpenCmd());
    await _state.firstWhere((element) => element is Open);

    yield* _state;
  }
}

class CameraControllerWrapper {
  final CameraController _controller;
  bool _disposeCalled = false;

  CameraControllerWrapper(this._controller);

  /// Returns true if dispose was started.
  void dispose() {
    if (_disposeCalled) {
      return;
    }
    _disposeCalled = true;
    CameraManager.getInstance().sendCmd(EventDisposeStart());
    _controller.dispose()
      .then((value) async {
        // await Future<void>.delayed(const Duration(seconds: 1), null);
        CameraManager.getInstance().sendCmd(EventDisposeComplete());
      });
  }

  bool isDisposed() {
    return _disposeCalled;
  }

  CameraController? getController() {
    if (_disposeCalled) {
      return null;
    }
    return _controller;
  }
}


/*

// On Android emulator (Pixel 2 API 31) this has deadlocked
// after going in and out from camera screen.
await controller.setFlashMode(FlashMode.off);

Added timeout to prevent deadlock.

Logs:

[CameraManager] start CameraManagerCmd: Instance of 'EventDisposeComplete'
[CameraManager] CameraManagerState: Instance of 'Closed'
[CameraManager] end CameraManagerCmd: Instance of 'EventDisposeComplete'
[CameraManager] openNewAndThenEvents
[CameraManager] start CameraManagerCmd: Instance of 'CloseCmd'
[CameraManager] CameraManagerState: Instance of 'Closed'
[CameraManager] end CameraManagerCmd: Instance of 'CloseCmd'
[CameraManager] start CameraManagerCmd: Instance of 'OpenCmd'
I/Camera  ( 9979): close
I/Camera  ( 9979): startPreview
I/Camera  ( 9979): unlockAutoFocus
I/Camera  ( 9979): [unlockAutoFocus] captureSession null, returning
I/Camera  ( 9979): refreshPreviewCaptureSession
I/Camera  ( 9979): refreshPreviewCaptureSession: captureSession not yet initialized, skipping preview capture session refresh.
I/Camera  ( 9979): CameraCaptureSession onConfigured
I/Camera  ( 9979): Updating builder settings
D/Camera  ( 9979): Updating builder with feature: ExposureLockFeature
D/Camera  ( 9979): Updating builder with feature: ExposurePointFeature
D/Camera  ( 9979): Updating builder with feature: ZoomLevelFeature
D/Camera  ( 9979): Updating builder with feature: AutoFocusFeature
D/Camera  ( 9979): Updating builder with feature: NoiseReductionFeature
I/Camera  ( 9979): updateNoiseReduction | currentSetting: fast
D/Camera  ( 9979): Updating builder with feature: FocusPointFeature
D/Camera  ( 9979): Updating builder with feature: ResolutionFeature
D/Camera  ( 9979): Updating builder with feature: SensorOrientationFeature
D/Camera  ( 9979): Updating builder with feature: FlashFeature
D/Camera  ( 9979): Updating builder with feature: ExposureOffsetFeature
D/Camera  ( 9979): Updating builder with feature: FpsRangeFeature
I/Camera  ( 9979): refreshPreviewCaptureSession

*/
