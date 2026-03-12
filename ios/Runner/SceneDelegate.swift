import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  override func sceneDidEnterBackground(_ scene: UIScene) {
    super.sceneDidEnterBackground(scene)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    appDelegate?.beginDelayAppSuspendTask()
  }
}
