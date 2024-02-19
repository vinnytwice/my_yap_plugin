// //
// //  CameraPreviewVC.swift
// //  my_yap_plugin
// //
// //  Created by Vincenzo Calia on 31/01/24.
// //


// import UIKit
// import AVKit

// class CameraPreviewVC: BaseVC, AVCapturePhotoCaptureDelegate {
    
//     private var session: AVCaptureSession? = nil
//     private var backCameraDevice: AVCaptureDevice? = nil
//     private var stillCameraOutput: AVCapturePhotoOutput? = nil
    
//     private var cropRect = CGRect.zero
//     private var viewPortRect = CGRect.zero
    
//     private var croppedImage: UIImage? = nil
//     private var fullImage: UIImage? = nil
    
//     private var isTorchOn: Bool = false
//     private var videoZoomFactor: CGFloat = 1
    
//     private var videoPreviewLayerOrientation: AVCaptureVideoOrientation = .portrait
    
//     private let previewLayerName = "camera_preview_layer"
    
//     @IBOutlet weak var viewfinderShapeType: UISegmentedControl!
//     @IBOutlet weak var vehicleType: UISegmentedControl!
//     @IBOutlet weak var viewFinderShapeLabel: UILabel!
//     @IBOutlet weak var flashBottomButton: UIButton!
    
//     @IBOutlet weak var overlayMaskView: UIView!
//     @IBOutlet weak var previewView: UIView!
//     @IBOutlet weak var rightNavigationItemLogo: UIBarButtonItem!
    
//     @IBOutlet weak var typeVehicleWithShapeLayoutConstraint: NSLayoutConstraint!
//     @IBOutlet weak var typeVehicleWithoutShapeLayoutConstraint: NSLayoutConstraint!
//     @IBOutlet weak var stillImagePreviewView: UIImageView!
    
//     /**
//      AUTOVEICOLO(1),
     
//      MOTOCICLO(2),
     
//      CICLOMOTORE(4),
     
//      MOTOVEICOLO(6);
//      */
    
//     // MARK: - Lifecycle
    
//     override func viewDidLoad() {
//         super.viewDidLoad()
        
//         // Do any additional setup after loading the view.
        
//         // OKAY: - Setup Capture Device
//         setupCaptureDevice()
        
//         setLogoRightButtonItem(#selector(goToHomeAction))
        
//         // Still image perview
//         stillImagePreviewView.isHidden = true
//         //stillImagePreviewView.backgroundColor = UIColor.orange
        
//         // Flash Button
//         flashBottomButton.imageView?.contentMode = .scaleAspectFit
//         flashBottomButton.setImage(UIImage(named: "flash_on"), for: .normal)
        
//         // Segmented Control
//         viewfinderShapeType.addTarget(
//             self,
//             action: #selector(segmentedControlValueChanged),
//             for: .valueChanged
//         )
        
//         // Pinch to zoom
//         let pinchRecon = UIPinchGestureRecognizer(target: self,
//                                                   action: #selector(handlePinchToZoomRecognizer))
//         overlayMaskView.addGestureRecognizer(pinchRecon)
        
//         // Segmented Control Styles for iOS 13
//         if #available(iOS 13, *) {
//             let whiteAttr: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white ]
//             let blackAttr: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.black ]
            
//             viewfinderShapeType.setTitleTextAttributes(whiteAttr, for: .normal)
//             viewfinderShapeType.setTitleTextAttributes(blackAttr, for: .selected)
            
//             vehicleType.setTitleTextAttributes(whiteAttr, for: .normal)
//             vehicleType.setTitleTextAttributes(blackAttr, for: .selected)
//         }
//     }
    
//     override func viewWillDisappear(_ animated: Bool) {
//         stopCapturing()
//         super.viewWillDisappear(animated)
        
//     }
    
//     override func viewDidAppear(_ animated: Bool) {
//         super.viewDidAppear(animated)
//         // https://stackoverflow.com/questions/11522672/getting-the-correct-bounds-of-uiviewcontrollers-view
//         checkCameraPermission( weakify {
//             strongSelf in
//             strongSelf.initCapturing()
//         })
//     }
    
//     override func viewWillTransition(to size: CGSize,
//                                      with coordinator: UIViewControllerTransitionCoordinator) {
//         super.viewWillTransition(to: size, with: coordinator)
        
//         let rect = CGRect(x: self.previewView.bounds.origin.x,
//                           y: self.previewView.bounds.origin.y,
//                           width: size.width,
//                           height: size.height)
        
//         LogManager.tinyLog("New Size: \(rect)")
        
//         resetCapturing(rect: rect)
        
//         print("Orientation: \(UIDevice.current.orientation)")
//     }
    
//     // MARK: - Actions
//     @objc func goToHomeAction() {
//         if let pc = presentingViewController as? UINavigationController  {
//             dismiss(
//                 animated: true,
//                 completion: weakify {
//                     strongSelf in
//                     pc.popToRootViewController(animated: true)
//                 }
//             )
//         }
//         else {
//             dismiss(animated: true)
//         }
//     }
    
//     @IBAction func closeAction(_ sender: Any) {
//         dismiss(animated: true, completion: nil)
//     }
    
//     @IBAction func takePhotoAction(_ sender: Any) {
//         // Set photo settings
//         let photoSettings : AVCapturePhotoSettings!
//         photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
//         photoSettings.isAutoStillImageStabilizationEnabled = false // this shift still image!!! O_O
//         photoSettings.flashMode = .off
//         photoSettings.isHighResolutionPhotoEnabled = false
        
//         // https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/avcam_building_a_camera_app#//apple_ref/doc/uid/DTS40010112-Swift_AVCam_CameraViewController_swift-DontLinkElementID_15
//         // https://stackoverflow.com/questions/46892846/swift-avfoundation-capture-image-orientation
//         if let photoOutputConnection = stillCameraOutput?.connection(with: .video) {
//             photoOutputConnection.videoOrientation = videoPreviewLayerOrientation
//             //photoOutputConnection.videoScaleAndCropFactor = videoZoomFactor
//         }
        
//         // Take Photo --> delegate.photoOutput()
// #if targetEnvironment(simulator)
//         // Only for simulation puropose
//         MMBSnackbarManager
//             .showErrorSnackbar("No capture device! Going ahead to simulate the flow")
//         if let vc = viewController(
//             viewControllerId: "MMBImagePreviewViewController",
//             fromStoryboard: "CameraPreview"
//         ) as? MMBImagePreviewViewController {
//             navigateByPresenting(viewController: vc, .fullScreen)
//         }
// #else
//         stillCameraOutput?.capturePhoto(with: photoSettings, delegate: self)
// #endif
//     }
    
//     @IBAction func toggleFlashAction(_ sender: Any) {
//         setTorch(on: !isTorchOn)
//     }
    
//     @IBAction func vehicleTypeAction(_ sender: Any) {
//         let sc = sender as! UISegmentedControl
        
//         if sc.selectedSegmentIndex != 0 { // Se non sono un autoveicolo, forzo targa quadrata
//             viewfinderShapeType.selectedSegmentIndex = 1
//             // E nascondo il selettore di forma
//             UIView.animate(
//                 withDuration: 0.4,
//                 animations: weakify {
//                     strongSelf in
//                     strongSelf.viewfinderShapeType.alpha = 0
//                     strongSelf.viewFinderShapeLabel.alpha = 0
//                 },
//                 completion: weakify {
//                     (strongSelf, finished) in
//                     if finished {
//                         // Capitolo 7 - Animating Constraints
//                         strongSelf.typeVehicleWithShapeLayoutConstraint.isActive = false
//                         strongSelf.typeVehicleWithoutShapeLayoutConstraint.isActive = true
//                         UIView.animate(
//                             withDuration: 0.8,
//                             delay: 0,
//                             usingSpringWithDamping: 0.4,
//                             initialSpringVelocity: 18,
//                             options: .curveEaseIn,
//                             animations: {
//                                 strongSelf.view.layoutIfNeeded()
//                             },
//                             completion: nil
//                         )
//                     }
//                 }
//             )
//             segmentedControlValueChanged()
//         } else {
//             viewfinderShapeType.selectedSegmentIndex = 0
//             segmentedControlValueChanged()
//             typeVehicleWithShapeLayoutConstraint.isActive = true
//             typeVehicleWithoutShapeLayoutConstraint.isActive = false
//             UIView.animate(
//                 withDuration: 0.8,
//                 delay: 0,
//                 usingSpringWithDamping: 0.4,
//                 initialSpringVelocity: 18,
//                 options: .curveEaseIn,
//                 animations: weakify {
//                     strongSelf in
//                     strongSelf.view.layoutIfNeeded()
//                 }, completion: weakify {
//                     (strongSelf, finished) in
//                     if finished {
//                         UIView.animate(
//                             withDuration: 0.4,
//                             animations: {
//                                 strongSelf.viewfinderShapeType.alpha = 1
//                                 strongSelf.viewFinderShapeLabel.alpha = 1
//                             }
//                         )
//                     }
//                 }
//             )
//         }
//     }
    
//     // MARK: - Pinch to zoom
    
//     @objc fileprivate func handlePinchToZoomRecognizer(pinchRecognizer: UIPinchGestureRecognizer) {
//         let pinchVelocityDividerFactor: CGFloat = 1
        
//         if pinchRecognizer.state == .changed || pinchRecognizer.state == .ended {
//             do {
//                 if backCameraDevice != nil {
//                     try backCameraDevice!.lockForConfiguration()
                    
//                     let desireZoomFactor: CGFloat = backCameraDevice!.videoZoomFactor
//                     + atan2(pinchRecognizer.velocity, pinchVelocityDividerFactor)
                    
//                     // Check if desiredZoomFactor fits required range from 1.0 to activeFormat.videoMaxZoomFactor
//                     var maxZoomFactor = backCameraDevice!.activeFormat.videoMaxZoomFactor
                    
//                     // OKAY: - Set maxZoomFactor according to the user level settings
//                     //if appDelegate().appSettings.getCameraZoomFactor() != 0 {
//                     //    maxZoomFactor /= CGFloat(appDelegate().appSettings.getCameraZoomFactor())
//                     //}
//                     maxZoomFactor /= 60
                    
//                     videoZoomFactor = max(1.0, min(desireZoomFactor, maxZoomFactor))
//                     LogManager.tinyLog("videoZoomFactor: \(videoZoomFactor)")
//                     backCameraDevice!.ramp(toVideoZoomFactor: videoZoomFactor, withRate: 5.0)
//                     backCameraDevice!.unlockForConfiguration()
//                 }
//             } catch {
//                 MMBSnackbarManager.showErrorSnackbarWithRetryAction("Cannot lock device to perform zoom \(error)")
//                 return
//             }
//         }
//     }
    
//     // MARK: - Selected Control
    
//     @objc fileprivate func segmentedControlValueChanged() {
//         if viewfinderShapeType.selectedSegmentIndex == 0 {
//             LogManager.tinyLog("Type Rect [xxx]")
//             if vehicleType.selectedSegmentIndex != 0 {
//                 // Force Car
//                 self.vehicleType.selectedSegmentIndex = 0
//             }
//         } else {
//             LogManager.tinyLog("Type Square [x]")
//         }
//         setupOverlay()
//     }
    
//     // MARK: - Torch
    
//     fileprivate func setTorchMode(_ on: Bool) {
//         isTorchOn = on
//         flashBottomButton.setImage(UIImage(named: on ? "flash_off" : "flash_on"), for: .normal)
//     }
    
//     fileprivate func setTorch(on: Bool) {
//         guard let device = AVCaptureDevice.default(for: .video) else { return }
        
//         if device.hasTorch && device.hasFlash {
//             do {
//                 try device.lockForConfiguration()
//                 device.torchMode = on ? .on : .off
//                 setTorchMode(on)
//             } catch {
//                 MMBSnackbarManager.showErrorSnackbarWithRetryAction("Error while accessing device torch")
//                 return
//             }
//         }
//     }
    
    
//     // MARK: - Capture Device
    
//     fileprivate func videoOrientation() -> AVCaptureVideoOrientation {
//         switch (UIApplication.getInterfaceOrientation()) {
//         case .portraitUpsideDown:
//             videoPreviewLayerOrientation = AVCaptureVideoOrientation.portraitUpsideDown
//         case .landscapeLeft:
//             videoPreviewLayerOrientation = AVCaptureVideoOrientation.landscapeLeft
//         case .landscapeRight:
//             videoPreviewLayerOrientation = AVCaptureVideoOrientation.landscapeRight
//         default:
//             videoPreviewLayerOrientation = AVCaptureVideoOrientation.portrait
//         }
        
//         return videoPreviewLayerOrientation
//     }
    
//     fileprivate func resetCapturing(rect: CGRect) {
//         DispatchQueue.main
//             .async(execute: weakify {
//                 strongSelf in
                
//                 if strongSelf.session != nil {
//                     // Stop preview session
//                     strongSelf.session?.stopRunning()
                    
//                     // Removew previous layer and add the new one
//                     for layer in strongSelf.previewView.layer.sublayers ?? [] {
//                         if layer.name == strongSelf.previewLayerName {
//                             layer.removeFromSuperlayer()
//                             LogManager.log(strongSelf, "Removing previews preview layer")
//                         }
//                     }
                    
//                     let previewLayer = AVCaptureVideoPreviewLayer(session: strongSelf.session!)
                    
//                     previewLayer.videoGravity = .resizeAspectFill
//                     previewLayer.frame = rect
//                     previewLayer.name = strongSelf.previewLayerName
                    
//                     previewLayer.connection?.videoOrientation = strongSelf.videoOrientation()
                    
//                     strongSelf.previewView.layer.addSublayer(previewLayer)
                    
//                     // Reset Overlay Mask
//                     strongSelf.setupOverlay()
                    
//                     DispatchQueue.main.async {
//                         strongSelf.session?.startRunning()
//                     }
//                 }
//             })
//     }
    
//     fileprivate func stopCapturing() {
// #if targetEnvironment(simulator)
//         MMBSnackbarManager.showErrorSnackbar("stopCapturing: Camera not working on simulator")
// #else
//         DispatchQueue.main
//             .async(execute: weakify {
//                 strongSelf in
//                 strongSelf.session?.stopRunning()
//                 strongSelf.videoZoomFactor = 1
//             })
// #endif
//     }
    
//     fileprivate func initCapturing() {
// #if targetEnvironment(simulator)
//         MMBSnackbarManager.showErrorSnackbar("initCapturing: Camera not working on simulator")
// #else
//         setupCaptureDevice()
//         showPreview()
// #endif
//         setupOverlay()
//     }
    
//     fileprivate func setupOverlay() {
//         viewPortRect = previewView.bounds
//         let path = UIBezierPath(rect: viewPortRect)
        
//         let center = CGPoint(x: viewPortRect.midX, y: viewPortRect.midY)
        
//         let finderZoomFactor = appDelegate().appSettings.getPlateFinderZoomFactor()
//         LogManager.tinyLog("finder zoom factor: \(finderZoomFactor)")
//         var size = CGSize(width: 100, height: 30)
//         if viewfinderShapeType.selectedSegmentIndex != 0 {
//             size = CGSize(width: 80, height: 80)
//         }
//         size = CGSize(
//             width: size.width * CGFloat(finderZoomFactor),
//             height: size.height * CGFloat(finderZoomFactor)
//         )
        
//         let holeRect = CGRect(x: center.x - (size.width / 2),
//                               y: center.y - (size.height / 2),
//                               width: size.width,
//                               height: size.height)
        
//         cropRect = holeRect
//         let holeRectPath = UIBezierPath(rect: holeRect)
//         path.append(holeRectPath)
        
//         let maskLayer = CAShapeLayer() // create a mask layer
//         maskLayer.path = path.cgPath // give the mask layer the path you just draw
//         maskLayer.fillRule = .evenOdd // cut out the intersection part
        
//         if overlayMaskView.layer.mask == nil {
//             overlayMaskView.layer.mask = maskLayer
//         }
        
//         let currentMaskLayer: CAShapeLayer = overlayMaskView.layer.mask as! CAShapeLayer
        
//         let anim = CABasicAnimation()
//         anim.keyPath = "path"
//         anim.fromValue = currentMaskLayer.path
//         anim.toValue = maskLayer.path
//         anim.duration = 1
//         anim.isRemovedOnCompletion = false
//         anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
//         maskLayer.add(anim, forKey: nil)
//         CATransaction.begin()
//         CATransaction.setDisableActions(true)
//         CATransaction.setCompletionBlock(
//             weakify { (strongSelf) in
//                 strongSelf.overlayMaskView.layer.mask = maskLayer
//             }
//         )
//         CATransaction.commit()
//     }
    
//     fileprivate func showPreview() {
//         if session != nil {
//             let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
            
//             // https://stackoverflow.com/questions/5117770/avcapturevideopreviewlayer-doesnt-fill-up-whole-iphone-4s-screen
//             previewLayer.videoGravity = .resizeAspectFill
//             previewLayer.frame = previewView.bounds
//             previewLayer.name = previewLayerName
            
//             previewLayer.connection?.videoOrientation = videoOrientation()
            
//             previewView.layer .addSublayer(previewLayer)
            
//             DispatchQueue.main.async(execute: weakify{ strongSelf in
//                 strongSelf.session?.startRunning()
//             })
//         }
//     }
    
//     fileprivate func setupCaptureDevice() {
//         session = AVCaptureSession()
//         session?.sessionPreset = .photo
        
//         // https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/choosing_a_capture_device
//         // These devices are suitable for general-purpose use.
//         let captureDeviceDiscoverySession
//         = AVCaptureDevice.DiscoverySession
//             .init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
//                   mediaType: .video,
//                   position: .back)
        
//         let devices = captureDeviceDiscoverySession.devices
//         guard !devices.isEmpty else {
//             MMBSnackbarManager.showErrorSnackbarWithRetryAction("Missing capture devices.")
//             return
//         }
//         backCameraDevice = devices.first
        
//         do {
//             let backCameraInput = try AVCaptureDeviceInput(device: backCameraDevice!)
//             if session?.canAddInput(backCameraInput) == true {
//                 session?.addInput(backCameraInput)
//             }
//         } catch {
//             MMBSnackbarManager.showErrorSnackbarWithRetryAction("Error getting device input: \(String(describing: backCameraDevice))")
//             return
//         }
        
//         stillCameraOutput = AVCapturePhotoOutput()
//         if session?.canAddOutput(stillCameraOutput!) == true {
//             session?.addOutput(stillCameraOutput!)
//         }
        
//     }
    
//     // MARK: - Save to camera roll delegate
    
//     @objc func image(_ image: UIImage,
//                      didFinishSavingWithError error: Error?,
//                      contextInfo: UnsafeRawPointer) {
//         if let error = error {
//             // we got back an error!
//             LogManager.tinyLog("Error saving photo to camera roll: \(error)")
//         } else {
//             LogManager.tinyLog("Image saved to camera roll")
//         }
//     }
    
    
//     // MARK: - Capture Photo Delegate
    
//     func photoOutput(_ output: AVCapturePhotoOutput,
//                      didFinishProcessingPhoto photo:AVCapturePhoto,
//                      error: Error?) {
//         LogManager.tinyLog("Foto Taken (videoZoomFactor: \(videoZoomFactor))")
        
//         guard error == nil else {
//             LogManager.tinyLog("Error in capturing process: \(String(describing: error))")
//             return
//         }
        
//         let data = photo.fileDataRepresentation()
        
//         guard data != nil else {
//             LogManager.tinyLog("Image data is nil!")
//             return
//         }
        
        
//         fullImage = UIImage(data: data!)
        
//         guard fullImage != nil else {
//             print("fullImage is nil!")
//             return
//         }
        
//         LogManager.tinyLog("Saving resized image...")
        
//         var cgImage = fullImage!.cgImage
        
//         guard cgImage != nil else {
//             LogManager.tinyLog("The cgImage is nil!")
//             return
//         }
        
        
//         // not equivalent to self.size (which depends on the imageOrientation)!
//         let srcSize = CGSize(width: cgImage!.width, height: cgImage!.height)
//         LogManager.tinyLog("srcSize: \(srcSize)")
        
//         // adjust boundingSize to make it independant on imageOrientation too for further computations
//         let orientation = fullImage?.imageOrientation
//         LogManager.tinyLog("orientation: \(String(describing: orientation))")
        
//         var boundingSize: CGSize = self.viewPortRect.size
        
//         switch (orientation) {
//         case .left, .right, .leftMirrored, .rightMirrored:
//             // Switch dimensions!
//             boundingSize = CGSize(width: boundingSize.height, height: boundingSize.width);
//             break;
//         default:
//             // NOP
//             break;
//         }
        
//         // Compute the target CGRect in order to keep aspect-ratio
//         var dstSize: CGSize = CGSize.zero
        
//         var dstScale: CGFloat = 3 //min(floor(srcSize.width / boundingSize.width), floor(srcSize.height  / boundingSize.height))
//         LogManager.tinyLog("dstScale: \(dstScale)")
//         LogManager.tinyLog("boundingSize: \(boundingSize)")
//         var dstWidth: CGFloat = boundingSize.width * dstScale
//         var dstHeight: CGFloat = boundingSize.height * dstScale
//         LogManager.tinyLog("dstWidth, dstHeight: \(dstWidth), \(dstHeight) for scale: \(dstScale)")
//         var dimOkay = false
//         repeat {
//             if dstWidth > dstHeight {
//                 if dstWidth < 2000 {
//                     dimOkay = true
//                 }
//             } else {
//                 if dstHeight < 2000 {
//                     dimOkay = true
//                 }
//             }
//             if !dimOkay {
//                 dstScale -= 1
//                 if dstScale > 0 {
//                     dstWidth = boundingSize.width * dstScale
//                     dstHeight = boundingSize.height * dstScale
//                     LogManager.tinyLog("dstWidth, dstHeight: \(dstWidth), \(dstHeight) for scale: \(dstScale)")
//                 }
//             }
//         } while !dimOkay && dstScale != 0
        
//         var wRatio: CGFloat = 1
//         var hRatio: CGFloat = 1
//         if srcSize.width < dstWidth
//             && srcSize.height < dstHeight {
//             // no resize (we could directly return 'self' here, but we draw the image anyway to take image orientation into account)
//             LogManager.tinyLog("dstSize = srcSize")
//             dstSize = srcSize;
//         } else {
//             wRatio = dstWidth / srcSize.width
//             hRatio = dstHeight / srcSize.height
            
//             if wRatio < hRatio {
//                 dstSize = CGSize(width: dstWidth,
//                                  height: floor(srcSize.height * wRatio))
//             } else {
//                 dstSize = CGSize(width: floor(srcSize.width * hRatio),
//                                  height: dstHeight)
//             }
//         }
//         LogManager.tinyLog("dstSize: \(dstSize)")
        
//         if !srcSize.equalTo(dstSize) {
//             let scaleRatio = dstSize.width / srcSize.width
//             LogManager.tinyLog("scaleRatio: \(scaleRatio)")
            
//             var transform = CGAffineTransform.identity
            
//             LogManager.tinyLog("Different Sizes, let's scale!\n")
//             switch orientation {
//             case .up:
//                 LogManager.tinyLog("up\n")
//                 transform = CGAffineTransform.identity
//             case .upMirrored:
//                 LogManager.tinyLog("upMirrored\n")
//                 transform = CGAffineTransform(translationX: srcSize.width, y:0)
//                 transform = transform.scaledBy(x: -1, y: 1)
//             case .down:
//                 LogManager.tinyLog("down\n")
//                 transform = CGAffineTransform(translationX: srcSize.width, y:srcSize.height)
//                 transform = transform.rotated(by: CGFloat.pi)
//             case .downMirrored:
//                 LogManager.tinyLog("downMirrored\n")
//                 transform = CGAffineTransform(translationX: 0, y:srcSize.height)
//                 transform = transform.scaledBy(x: 1, y: -1)
//             case .leftMirrored:
//                 LogManager.tinyLog("leftMirrored\n")
//                 dstSize = CGSize(width: dstSize.height, height: dstSize.width)
//                 transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
//                 transform = transform.scaledBy(x: -1, y: 1)
//                 transform = transform.rotated(by: 3 * CGFloat.pi / 2)
//             case .left:
//                 LogManager.tinyLog("left\n")
//                 dstSize = CGSize(width: dstSize.height, height: dstSize.width)
//                 transform = CGAffineTransform(translationX: 0, y: srcSize.width)
//                 transform = transform.rotated(by: 3 * CGFloat.pi / 2)
//             case .rightMirrored:
//                 LogManager.tinyLog("rightMirrored\n")
//                 dstSize = CGSize(width: dstSize.height, height: dstSize.width)
//                 transform = CGAffineTransform(scaleX: -1, y: 1)
//                 transform = transform.rotated(by: CGFloat.pi / 2)
//             case .right:
//                 LogManager.tinyLog("right\n")
//                 dstSize = CGSize(width: dstSize.height, height: dstSize.width)
//                 transform = CGAffineTransform(translationX: srcSize.height, y: 0)
//                 transform = transform.rotated(by: CGFloat.pi / 2)
//             default:
//                 MMBSnackbarManager.showErrorSnackbarWithRetryAction("Invalid image orientation")
//                 return
//             }
            
//             // -------------------------------------------------------------------------------- //
//             // The actual resize: draw the image on a new context, applying a transform matrix  //
//             // -------------------------------------------------------------------------------- //
//             UIGraphicsBeginImageContextWithOptions(dstSize, false, fullImage!.scale);
            
//             let context = UIGraphicsGetCurrentContext()
            
//             guard context != nil else {
//                 LogManager.tinyLog("The current context is nil!")
//                 return
//             }
            
//             if orientation == .right
//                 || orientation == .left {
//                 context!.scaleBy(x: -scaleRatio, y: scaleRatio)
//                 context!.translateBy(x: -srcSize.height, y: 0)
//             } else {
//                 context!.scaleBy(x: scaleRatio, y: -scaleRatio)
//                 context!.translateBy(x: 0, y: -srcSize.height)
//             }
            
//             context!.concatenate(transform)
            
//             // we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
//             //context?.draw(cgImage!, in: CGRect(origin: .zero, size: srcSize))
//             context!.draw(cgImage!, in: CGRect(origin: .zero, size: srcSize))
            
//             let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//             UIGraphicsEndImageContext()
//             fullImage = resizedImage
//         } // !srcSize.equalTo(dstSize)
        
//         cgImage = convertCIImageToCGImage(inputImage: CIImage(image: fullImage!)!)
        
//         // Then crop the image!
//         LogManager.tinyLog("Saving cropped image... (" +
//                            " \(cropRect.origin.x), " +
//                            " \(cropRect.origin.y), " +
//                            " \(cropRect.width), " +
//                            " \(cropRect.height))\n" +
//                            "in viewport (" +
//                            " \(viewPortRect.origin.x), " +
//                            " \(viewPortRect.origin.y), " +
//                            " \(viewPortRect.width), " +
//                            " \(viewPortRect.height))\n"
//         )
        
//         let wScale = CGFloat(cgImage!.width) / viewPortRect.width
//         let hScale = CGFloat(cgImage!.height) / viewPortRect.height
        
//         /*
//          var edgeInset = UIEdgeInsets.zero
//          if #available(iOS 11.0, *) {
//          edgeInset = self.view.safeAreaInsets
//          }
//          */
        
//         // I know, this is ugly.
//         // I try to find a custom interpolation function to fit my zoom image behaviour
//         //let magicNumber: CGFloat = 10
//         //let yOffset: CGFloat = 0//magicNumber * videoZoomFactor
//         //let xOffset: CGFloat = 0 --> not necessary without still image stabilization!
//         let scaledRect = CGRect(x: (cropRect.origin.x) * wScale, // + xOffset,
//                                 y: (cropRect.origin.y) * hScale, // + yOffset,
//                                 width: cropRect.width * wScale,
//                                 height: cropRect.height * hScale)
        
//         // OKAY: - draw debug graphics
//         if appDelegate().appSettings.getCameraUseDebugGraphics() {
//             fullImage = drawViewFinder(image: fullImage!,
//                                        cgImage: cgImage!,
//                                        scaledViewPortRect: scaledRect)
//         }
        
//         // OKAY: - set this in settings
//         if appDelegate().appSettings.getCameraSavePlatePhoto() {
//             UIImageWriteToSavedPhotosAlbum(
//                 fullImage!,
//                 self,
//                 #selector(image(_:didFinishSavingWithError:contextInfo:)),
//                 nil)
//         }
        
//         croppedImage = UIImage(cgImage: fullImage!.cgImage!.cropping(to: scaledRect)!)
        
//         /**
//          We scale the cropped image down to a dimension that best fit our plate scanner algo.
//          */
//         let plateZoomFactor = appDelegate().appSettings.getPlateFinderZoomFactor()
//         if plateZoomFactor > 1 {
//             if let image = croppedImage {
//                 let newSize = CGSize(
//                     width: image.size.width / CGFloat(plateZoomFactor),
//                     height: image.size.height / CGFloat(plateZoomFactor)
//                 )
//                 croppedImage = image.resizeImage(
//                     newSize: newSize,
//                     scale: 1
//                 )
//             }
//         }
        
//         // OKAY: - set this in settings
//         if appDelegate().appSettings.getCameraSavePlatePhoto() {
//             UIImageWriteToSavedPhotosAlbum(
//                 croppedImage!,
//                 self,
//                 #selector(image(_:didFinishSavingWithError:contextInfo:)),
//                 nil
//             )
//         }
        
//         //stillImagePreviewView.image = fullImage
//         //stillImagePreviewView.isHidden = false
//         //return
//         if let vc = viewController(
//             viewControllerId: "MMBImagePreviewViewController",
//             fromStoryboard: "CameraPreview"
//         ) as? MMBImagePreviewViewController {
//             vc.previewImage = croppedImage
//             vc.fullImage = fullImage
//             vc.selectedShapeType = viewfinderShapeType.selectedSegmentIndex
//             vc.selectedVehicleType = vehicleType.selectedSegmentIndex
//             navigateByPresenting(viewController: vc, .fullScreen)
//         }
//     }
    
//     // MARK: - CIImage functions
//     func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
//         let context = CIContext(options: nil)
//         return context.createCGImage(inputImage, from: inputImage.extent)
//     }
    
//     // MARK: - Draw view finder
//     func drawViewFinder(image: UIImage, cgImage: CGImage, scaledViewPortRect: CGRect) -> UIImage? {
//         UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
        
//         image.draw(at: CGPoint.zero)
        
//         UIColor.red.setStroke()
        
//         UIRectFrame(scaledViewPortRect)
        
//         let imageWithViewFinder = UIGraphicsGetImageFromCurrentImageContext();
//         UIGraphicsEndImageContext()
        
//         return imageWithViewFinder
//     }
    
// }
