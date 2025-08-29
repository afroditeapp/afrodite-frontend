import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
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

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "delay_app_suspend_task",
                                       binaryMessenger: controller.binaryMessenger)

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

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    delayAppSuspend?.dispose()
    if (allowDelayAppSuspend) {
      delayAppSuspend = DelayAppSuspendTask(application)
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
