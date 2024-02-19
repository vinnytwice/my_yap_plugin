import Flutter
import UIKit

public class MyYapPlugin: NSObject, FlutterPlugin {
  // var viewFactory: DynamicNativeViewFactory?; // not necessary, as we don't need to return the PlatformViewerFactory in the methodHandler!!!
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_yap_plugin_channel", binaryMessenger: registrar.messenger())
    let instance = MyYapPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // custom  
      let viewFactory = DynamicNativeViewFactory(messenger: registrar.messenger())
    registrar.register(
      viewFactory,
          withId: "native_screen",
          // new test 
          gestureRecognizersBlockingPolicy:FlutterPlatformViewGestureRecognizersBlockingPolicyWaitUntilTouchesEnded)


  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
     case "showNativeScreen":
    //  result(viewFactory);
    print("getNativescreen call received")

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

