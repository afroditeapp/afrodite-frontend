import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  var delayAppSuspend: DelayAppSuspendTask?
  var allowDelayAppSuspend: Bool = false;

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // https://github.com/MaikuB/flutter_local_notifications/tree/master/flutter_local_notifications#-ios-setup
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let channel = FlutterMethodChannel(
      name: "delay_app_suspend_task",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )

    channel.setMethodCallHandler { (call, result) in
      if call.method == "allow" {
        self.allowDelayAppSuspend = true
        result(nil)
      } else if call.method == "forbid" {
        self.allowDelayAppSuspend = false
        result(nil)
      } else if call.method == "dispose" {
        self.delayAppSuspend?.dispose()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }

  func beginDelayAppSuspendTask() {
    delayAppSuspend?.dispose()
    if (allowDelayAppSuspend) {
      delayAppSuspend = DelayAppSuspendTask(UIApplication.shared)
    }
  }
}

final class DelayAppSuspendTask {
  private let app: UIApplication
  private var task: UIBackgroundTaskIdentifier = .invalid

  init(_ application: UIApplication) {
    app = application
    task = app.beginBackgroundTask() {
      self.dispose()
    }
  }

  func dispose() {
    if task != .invalid {
      app.endBackgroundTask(task)
    }
  }
}
