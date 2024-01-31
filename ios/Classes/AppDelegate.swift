import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
    // define method channels
    // var methodChannel: FlutterMethodChannel?
    // var nativeViewerPlatformCahannel: FlutterMethodChannel?
    var navChannel : FlutterMethodChannel?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //   GeneratedPluginRegistrant.register(with: self);
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
