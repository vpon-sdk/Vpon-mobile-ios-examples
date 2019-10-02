import UIKit
import Flutter
import Firebase
import VpadnSDKAdKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
      
      let config = VpadnAdConfiguration.sharedInstance()
      config.logLevel = .debug
      config.initializeSdk()
      
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
