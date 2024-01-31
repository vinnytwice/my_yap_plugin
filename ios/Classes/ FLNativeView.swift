
import Flutter
import UIKit


class DynamicNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return DynamicNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class DynamicNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView = UIView();
    

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        if let params = args as? [String:AnyObject] {
            let screen: String = params["screen"] as! String;
            
            if let vc = ViewControllerGetter(rawValue: screen)?.getViewController(with: params) {
                _view = vc;
            }
        }
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}







