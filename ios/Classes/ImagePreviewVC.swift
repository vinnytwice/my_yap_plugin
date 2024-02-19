// //
// //  ImagePreviewVC.swift
// //  my_yap_plugin
// //
// //  Created by Vincenzo Calia on 31/01/24.
// //

// import UIKit

// //import kotlin_mpp

// import MaterialComponents.MaterialSnackbar

// import MBProgressHUD

// class ImagePreviewVC: BaseVC {
    
//     var previewImage: UIImage? = nil
//     var fullImage: UIImage? = nil
//     var selectedShapeType: Int = -1
//     var selectedVehicleType: Int = -1
    
//     private let secondsOfDelay: Double = 1
    
//     private lazy var plateReconPresenter: PlateRecognizerPresenter?
//         = PlateRecognizerPresenter(apiService: self.appDelegate().apiService)
    
//     private var hud: MBProgressHUD? = nil
    
//     @IBOutlet weak var previewImageView: UIImageView!
    
//     override func viewDidLoad() {
//         super.viewDidLoad()
        
//         // Do any additional setup after loading the view.
//         if previewImage != nil {
//             previewImageView.image = previewImage
//         }
//     }
    
//     deinit {
//         plateReconPresenter?.onDestroy()
//         plateReconPresenter = nil
//     }
    
    
//     @IBAction func cancelAction(_ sender: Any) {
//         self.dismiss(animated: true, completion: nil)
//     }
    
//     @IBAction func usePhotoAction(_ sender: Any) {
//         LogManager.tinyLog("usePhotoAction")
        
//         let base64PlateImage = previewImage?.jpegData(compressionQuality: 1)?.base64EncodedString()
// //        LogManager.tinyLog("Plate Image")
// //        LogManager.tinyLog("\(base64PlateImage ?? "Empty!! 💥")")
        
//         let vehicleType = getVehicleCategory(selectorIndex: selectedVehicleType)
//         let plateShape = getPlateShape(selectorIndex: selectedShapeType)
// //        LogManager.tinyLog("Vehicle category: \(vehicleType)")
// //        LogManager.tinyLog("Plate shape: \(plateShape)")
//         let reconModel = RecognitionImageRequestModel(
//             ts: 0,
//             aging: 0,
//             millis: 0,
//             vehicleCategory: vehicleType,
//             image: base64PlateImage,
//             plateLocation: RecognitionImageRequestModel.PlateLocation.both,
//             shape: plateShape,
//             timeElapsed: 0)
        
//         self.plateReconPresenter?.plateRecognize(
//             initialViewStateHandler: weakify { strongSelf, viewState in
//                 strongSelf.configureForViewState(viewState)
//             },
//             completion:  weakify { strongSelf, viewState in
//                 strongSelf.configureForViewState(viewState)
//             },
//             appSettings: appDelegate().appSettings,
//             plateReconRequestModel: reconModel
//         )
//     }
    
//     private func configureForViewState(
//         _ viewState: PlateRecognizerPresenter.PlateReconRequestViewState
//     ) {
//         var errorMessage: String = ""
        
//         if (viewState.indicatorAnimating) {
//             hud = MBProgressHUD.showHudWithDimBackground(
//                 addedTo: self.view,
//                 animated: true,
//                 withText: "Riconoscimento in corso..."
//             )
//         } else {
//             hud?.hide(animated: true, afterDelay: secondsOfDelay)
//         }
        
//         if viewState.apiErrorMessage?.isEmpty == false {
//             errorMessage = viewState.apiErrorMessage.orEmpty
            
//             MMBSnackbarManager.showErrorSnackbar(errorMessage)
//         } else if viewState.unexpectedError != nil {
//             errorMessage = viewState.unexpectedError.orEmpty
//             MMBSnackbarManager.showErrorSnackbar(errorMessage)
//         }
        
//         if !viewState.requestSucceeded {
//             if (errorMessage.isEmpty == false) {
//                 print(errorMessage)
//                 print("Plate NOT Recognized! 😈")
//             } else {
//                 print("Forging request 🤟")
//             }
//         } else {
//             let okayMessage = "Plate recognized!!! 🥳"
            
//             if let plate = viewState.plate {
//                 print("\(okayMessage), PLATE: \(plate) @\(Date())")
                
//                 hud?.label.text = "\(plate)"
//                 hud?.mode = .customView
//                 let checkImage = UIImage(named: "check")?.withRenderingMode(.alwaysTemplate)
//                 let imageView = UIImageView(image: checkImage)
//                 imageView.tintColor = UIColor(named: "Green")
//                 hud?.customView = imageView
//                 //hud?.isSquare = true
//                 hud?.minSize = CGSize(width: 100, height: 100)
                
                
//                 let imageDimensions = SettingsManager().remoteImageDimensions(
//                     appSettings: appDelegate().appSettings
//                 )
//                 LogManager.tinyLog(
//                     "Image dimensions: \(imageDimensions.first ?? 0) x \(imageDimensions.second ?? 0)"
//                 )
//                 let resizedImage = fullImage?.resizeImage(
//                     newSize: CGSize(
//                         width: imageDimensions.first?.doubleValue ?? 640,
//                         height: imageDimensions.second?.doubleValue ?? 480
//                     ),
//                     scale: 1.0
//                 )
//                 let compressionValue: CGFloat = CGFloat(
//                     appDelegate().appSettings.getJpegCompressionFactor()
//                     ) / 10
//                 let base64Image = resizedImage?
//                     .jpegData(compressionQuality: compressionValue)?
//                     .base64EncodedString()
                
//                 let userInfo: [PlateReadyUserInfoKey:Any] = [
//                     .fullImage: base64Image ?? "",
//                     //.croppedImage: previewImage!,
//                     .shapeType: selectedShapeType,
//                     .vehicleType: selectedVehicleType,
//                     .plate: viewState.plate ?? ""
//                 ]
                
//                 NotificationCenter
//                     .default
//                     .post(
//                         name: .plateReady,
//                         object: nil,
//                         userInfo: userInfo
//                 )
                
//                 let deadlineTime = DispatchTime.now() + .seconds(Int(secondsOfDelay))
//                 DispatchQueue.main.asyncAfter(
//                     deadline: deadlineTime,
//                     execute: weakify { strongSelf in
//                         print("@\(Date())")
//                         UIApplication.getKeyWindow()?.rootViewController?.dismiss(
//                             animated: true,
//                             completion: nil
//                         )
//                 })
//             }
//         }
//     }
// }
