//
//  BaseVC.swift
//  my_yap_plugin
//
//  Created by Vincenzo Calia on 31/01/24.
//


import UIKit
import AVKit

import MaterialComponents.MaterialSnackbar
import MaterialComponents.MDCPalettes

import FirebaseCrashlytics

import SwiftRichString

import PanModal

import PhotosUI
import YPImagePicker

import MBProgressHUD

//import kotlin_mpp


enum PlateReadyUserInfoKey {
    case fullImage
    case croppedImage
    case shapeType
    case vehicleType
    case plate
}

enum AppointmentUpdatedInfoKey {
    case updatedAppointment
    case deletedAppointmentId
}

enum RemoteAppointmentInfoKey {
    case updatedAppointment
}

enum FolderCreatedUserInfoKey {
    case folderId
    case appointmentId
}

enum WorkOrderUserInfoKey {
    case folderId
    case workOrder
}

class BaseVC: UIViewController {
    internal let planningSelectedDateKey: String = "planningSelectedDateKey"
    
    var readyPlate: String?
    
//    var softwareTires: [KotlinInt] {
//        if let userModel = appDelegate().userModel {
//            if let company = userModel.company {
//                if let softwareTiers = company.softwareTiers {
//                    return softwareTiers
//                }
//            }
//        }
//        return []
//    }
    
//    var hasSignFeature: Bool {
//        return softwareTires.contains(
//            KotlinInt(value: SoftwareTiers.firma.value)
//        )
//    }
//    
//    var hasMotContext: Bool {
//        return softwareTires.contains(
//            KotlinInt(value: SoftwareTiers.revisioni.value)
//        )
//    }
//    
//    var isPortrait: Bool {
//        return MMBDeviceManager.isPortrait()
//    }
    
//    var isPhone: Bool {
//        return MMBDeviceManager.isPhone()
//    }
//    
//    private var todayFoo: String {
//        return "mmb\(Date().stringYYYYMMDDWithoutSlash())"
//    }
    private var fooTextFieldValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        LogManager.log(self)
//        styleMe()
        registerForLifecycleNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        LogManager.log(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        LogManager.log(self)
//        Crashlytics.crashlytics().setCustomValue(
//            "\(self) \(MMBMemoryManager.formattedMemoryFootprint())",
//            forKey: "viewDidDisappear"
//        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        LogManager.log(self)
//        Crashlytics.crashlytics().setCustomValue(
//            "\(self) \(MMBMemoryManager.formattedMemoryFootprint())",
//            forKey: "viewWillAppear"
//        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        LogManager.log(self)
        unregisterLifecycleNotifications()
    }
    
    deinit {
//        LogManager.log(self)
        //https://app.slack.com/client/T09229ZC6/C3SGXARS6/thread/C3SGXARS6-1601328523.030900
        //https://youtrack.jetbrains.com/issue/KT-42275
        DispatchQueue.main.async {
//            GarbageCollector().collect()
        }
    }
    
    // MARK: - Deinit presenters
    // Deinit left behind presenters
    private func deinitPresenters() {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
//            if let presenter = child.value as? BasePresenter {
//                LogManager.tinyLog("👉 Presenter: \(child.label ?? "")")
//                presenter.onDestroy()
//            }
        }
    }
    
    // MARK: - View hierarchy
    internal func addViewBelowCurrentActiveHud(_ viewToInsert: UIView) {
        if let hud = MBProgressHUD.forView(view) {
            view.insertSubview(viewToInsert, belowSubview: hud)
        } else {
            view.addSubview(viewToInsert)
        }
    }
    
    // MARK: - Api
//    internal func errorFromApiRequest(_ viewState: BasePresenter.BaseRequestViewState) -> Bool {
//        return viewState.apiErrorMessage != nil || viewState.unexpectedError != nil
//    }
    
    // MARK: - Lifecycle notifications
    private func registerForLifecycleNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self, selector:
                #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(appBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    private func unregisterLifecycleNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(
            self,
            name:UIApplication.willResignActiveNotification,
            object: nil
        )
        notificationCenter.removeObserver(
            self,
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    @objc internal func appMovedToBackground() {
        
    }
    
    @objc internal func appBecomeActive() {
        
    }
    
    // MARK: - Back Actions
//    fileprivate func showHomeViewController(_ tabController: MMBBottomTabBarController) {
//        let homeItem = tabController.bottomBar.items[1]
//        tabController.bottomBar.selectedItem = homeItem
//        tabController.selectedIndex = 1
//    }
//    
//    @objc func backAction() {
//        if let tabController = tabBarController as? MMBBottomTabBarController {
//            showHomeViewController(tabController)
//        }
//    }
//    
//    @objc func backToHomeAction() {
//        if let tabController
//            = navigationController?.viewControllers.first as? MMBBottomTabBarController {
//            navigationController?.popToRootViewController(animated: true)
//            showHomeViewController(tabController)
//        } else if (appDelegate().flutterHome()) {
//            navigationController?.popToRootViewController(animated: true)
//        }
//    }
    
    // MMBBaseViewControllerImagesDelegate
    // for multiple selection: https://github.com/Yummypets/YPImagePicker
    // WARNING: TODO: https://github.com/Yummypets/YPImagePicker/issues/540 !!!
    internal let config: YPImagePickerConfiguration = {
        var config = YPImagePickerConfiguration()
        
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = false
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.hidesStatusBar = true
        config.hidesBottomBar = true
        
        config.library.isSquareByDefault = false
        config.library.mediaType = YPlibraryMediaType.photo
        config.library.skipSelectionsGallery = true
        
        config.gallery.hidesRemoveButton = true
        
        config.screens = [.library]
        config.library.maxNumberOfItems = 5
        
        config.colors.tintColor = .white
//        config.colors.multipleItemsSelectedCircleColor =
//            MyYapConfiguration.shared.colors.multipleItemsSelectedCircleColor
        
        // get capture icon from system icon
        if #available(iOS 13.0, *) {
            // https://github.com/Yummypets/YPImagePicker/issues/402
//            if let image = UIImage(
//                systemName: "largecircle.fill.circle"
//                )?.imageWithSize(
//                    size: CGSize(width: 168, height: 168)
//                )?.withTintColor(.white) {
//                config.icons.capturePhotoImage = image
//            }
        } else {
            // Fallback on earlier versions
//            if let image = UIImage(
//                named: "iconCapture"
//                )?.imageWithSize(
//                    size: CGSize(width: 168, height: 168)
//                )?.sd_tintedImage(with: .white) {
//                config.icons.capturePhotoImage = image
//            }
        }
                
        
        return config
    }()
    
    @available(iOS 14, *)
    func getPHPickerDelegate() -> PHPickerViewControllerDelegate? {
        fatalError("getPHPickerDelegate() -> Must be implemented by lower classes!!!")
    }
    
    func handleSinglePhoto(_ photo: YPMediaPhoto) {
        fatalError("handleSinglePhoto() -> Must be implemented by lower classes!!!")
    }
    
    func performSaveImages(removeFirstItem: Bool = false) {
        fatalError("performSaveImages() -> Must be implemented by lower classes!!!")
    }
    
    func cleanUpImagesToSaveArray() {
        fatalError("cleanUpImagesToSaveArray() -> Must be implemented by lower classes!!!")
    }
    
//    func appendImageToSaveArray(image: ImageToCreateModel) {
//        fatalError("appendImageToSaveArray() -> Must be implemented by lower classes!!!")
//    }
}

// MARK: back button
extension BaseVC {
    @objc func backPressed(isSaved: Bool) {
//        showUnsavedDataAlert(
//            isSaved: isSaved,
//            okHandler: weakify {
//                strongSelf in
//                strongSelf.navigationController?.popViewController(animated: true)
//            }
//        )
    }
    
    internal func showUnsavedDataAlert(
        isSaved: Bool,
        message: String? = nil,
        okHandler: @escaping () -> Void
    ) {
        if !isSaved {
//            AlertControllerManager.showOkCancelDialog(
//                self,
//                title: "Attenzione",
//                message: message != nil ? message : "Ci sono modifiche non salvate.\nUscire ugualmente?",
//                okHander: okHandler
//            )
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Vehicle Utility Functions
// This must be ported to multiplatform lib
//internal func formatVehicleDataText(
//    _ vehicle: VehicleModel? = nil,
//    _ withVin: Bool = true,
//    _ owner: RecordModel? = nil
//) -> String {
//    var vehicleDataText = ""
//    if let vehicle = vehicle {
//        if let plate = vehicle.plate {
//            vehicleDataText += plate
//        }
//        let brand = vehicle.brand
//        let model = vehicle.model
//        var separator = ""
//        if brand.orEmpty != "" && model.orEmpty != "" {
//            separator = " "
//        }
//        vehicleDataText += "\n\(brand ?? "")\(separator)\(model ?? "")"
//        if withVin, let vin = vehicle.vin {
//            vehicleDataText += "\n\(vin)"
//        }
//    }
//    if let ownerName = owner?.name {
//        vehicleDataText += "\n\(ownerName)"
//    }
//    return vehicleDataText
//}

// MARK: Folder presenter
extension BaseVC {
//    internal func goToSignTab(
//        _ folder: FolderModel?
//    ) {
//        if (appDelegate().flutterSignatures()) {
//            if (folder != nil) {
//                detachViewControllerFromFlutterEngine(FlutterEntryPointsEnum.FOLDER_SIGNATURES_SCREEN, appDelegate: appDelegate())
//                let vc = FlutterFolderSignaturesViewController(folder: folder)
//                navigateByPushing(viewController: vc)
//            } else {
//                let vc = FlutterSignaturesViewController()
//                navigateByPushing(viewController: vc)
//            }
//            
//        } else {
//            let vc = MMBSignSectionViewController(folder: folder)
//            navigateByPushing(viewController: vc)
//        }
//    }
    
//    internal func goToFolder(
//        _ folder: FolderModel?,
//        appointment: AppointmentModel?,
//        allTags: [TagModel]
//    ) {
//        guard let userModel = appDelegate().userModel, YapPermissionManager()
//                .showFolder(userModel: userModel, context: self) else { return }
//        
//        if let vc = viewController(
//            viewControllerId: "FolderDataViewController",
//            fromStoryboard: "Folder"
//        ) as? MMBFolderDataViewController {
//            if let folder = folder {
//                vc.folder = folder
//            }
//            vc.allTags = allTags
//            vc.appointment = appointment
//            navigateByPushing(viewController: vc, removingMe: true)
//        }
//    }
    
//    internal func newFolderModel(
//        currentPlate: String?,
//        appointmentId: KotlinLong?,
//        folderId: KotlinLong?
//    ) -> NewFolderModel {
//        var imageToCreateModel: ImageToCreateModel? = nil
//        
//        var imageBase64: String? = nil
//        var vehicleategory = NewFolderModel.VehicleCategory.autoveicolo
//        
//        if let plate = currentPlate {
//            let pair = DbUtil().getPlateImage(plate: plate)
//            imageBase64 = pair.first as String?
//            // DEBUG IMAGE ;) - remove
//            if imageBase64 == nil {
//                //    imageBase64 = getDebugImage()
//            } else {
//                imageToCreateModel = ImageToCreateModel(
//                    content: imageBase64,
//                    filename: "\(currentPlate ?? "XX007XX")_\(Date().unixTimestamp).jpg"
//                )
//            }
//            
//            if let category = pair.second {
//                // This enum management is crazy, must be reviewed ;)
//                vehicleategory = getVehicleCategory(enumOrdinal: category.intValue)
//            }
//        }
//        
//        return NewFolderModel(
//            plate: currentPlate,
//            appointmentId: appointmentId,
//            folderId: folderId,
//            vehicleCategory: vehicleategory,
//            imageToCreate: imageToCreateModel
//        )
//    }
}

// MARK - tester mode
extension BaseVC {
//    func showEnableTesterModeAlert(
//        enableTestEndpoint: Bool = false,
//        user: UserModelWrapper? = nil
//    ) {
//        let alert = AlertControllerManager
//            .createDialog(
//                byController: self,
//                title: "Abilita test mode",
//                message: "Inserisci il codice per l'abilitazione\n\n- endpoint attuale -\n \(appDelegate().apiService.endpointUrl)",
//                placeholderMessage: "Inserisci il codice",
//                //iconImage: UIImage(named: "vpn_key"),
//                isSecure: true,
//                okActionText: "Ok",
//                cancelActionText: "Chiudi",
//                dialogStyle: .alert,
//                okHandler: weakify {
//                    (strongSelf, action) in
//                    LogManager.tinyLog("textField FINAL = "
//                                       + "\(String(describing: strongSelf.fooTextFieldValue))")
//                    if strongSelf.fooTextFieldValue == strongSelf.todayFoo {
//                        user?.testerCounter = 0
//                        strongSelf.appDelegate().appSettings.setYouAreTester(testing: true)
//                        if enableTestEndpoint {
//                            strongSelf.appDelegate().appSettings.setTesterBranchEndpoint(
//                                url: AppSettings.companion.DEFAULT_TESTER_MODE_URL
//                            )
//                            strongSelf.appDelegate().appSettings.setUseApiStagingEndpoint(useStaging: true)
//                            self.setApiEndpointAlert(defaultUrl: true)
//                        }
//                        MMBSnackbarManager.showSnackbar(
//                            "Ora sei un tester",
//                            textColor: MyYapConfiguration.shared.colors.snackbarInfoTextColor,
//                            backgroundColor: MyYapConfiguration.shared.colors.snackbarInfoTintColor
//                        )
//                    }
//                },
//                textDidChanged: weakify {
//                    (strongSelf, textField) in
//                    strongSelf.fooTextFieldValue = textField.text
//                }
//            )
//        alert.show()
//    }
//    
//    func showDisableTesterModeAlert() -> Void {
//        let ac = UIAlertController(
//            title: "Tester mode",
//            message: "Vuoi disattivare la modalità tester?",
//            preferredStyle: .alert)
//        
//        let submitAction = UIAlertAction(
//            title: "Si",
//            style: .default
//        ) { [unowned ac] _ in
//            self.appDelegate().appSettings.setYouAreTester(testing: false)
//            self.resetAllTesterSettings()
//            self.showRestartRequiredAlert()
//        }
//        let cancelAction = UIAlertAction(
//            title: "No",
//            style: .cancel
//        ) { [unowned ac] _ in
//            self.setApiEndpointAlert(defaultUrl: false)
//        }
//        
//        ac.addAction(submitAction)
//        ac.addAction(cancelAction)
//        
//        self.present(ac, animated: true)
//    }
//    
//    func resetAllTesterSettings() {
//        self.appDelegate().appSettings.setUseApiStagingEndpoint(
//            useStaging: false
//        )
//        self.appDelegate().appSettings.setTesterBranchEndpoint(url: "")
//    }
//    
//    func setApiEndpointAlert(defaultUrl: Bool) -> Void {
//        var message: String = ""
//        if (defaultUrl) {
//            message = "\n- endpoint di default -\n\n\(AppSettings.companion.DEFAULT_TESTER_MODE_URL)\n"
//        } else {
//            message = "\n- endpoint attuale -\n \(self.appDelegate().apiService.endpointUrl)\n"
//        }
//        let ac = UIAlertController(
//            title: "Vuoi cambiare endpoint?",
//            message: message,
//            preferredStyle: .alert)
//        ac.addTextField { (textField) in
//            var urlString = self.appDelegate().appSettings.getTesterBranchEndpoint()
//            textField.text = urlString
//        }
//        
//        let submitAction = UIAlertAction(
//            title: "Salva",
//            style: .default
//        ) { [unowned ac] _ in
//            if let textField = ac.textFields?[0] {
//                let urlString = textField.text
//                self.appDelegate().appSettings.setTesterBranchEndpoint(
//                    url: urlString ?? ""
//                )
//                self.showRestartRequiredAlert()
//            }
//        }
//        let cancelAction = UIAlertAction(
//            title: "Annulla",
//            style: .cancel
//        ) { [unowned ac] _ in
//            ac.dismiss(animated: true, completion: nil)
//        }
//        
//        ac.addAction(submitAction)
//        ac.addAction(cancelAction)
//        
//        self.present(ac, animated: true)
//    }
//    
//    func showRestartRequiredAlert() {
//        let ac = UIAlertController(
//            title: "Attenzione",
//            message: "Riavviare l'app per rendere effettiva la modifica!",
//            preferredStyle: .alert)
//        
//        let submitAction = UIAlertAction(
//            title: "Ok",
//            style: .default
//        ) { [unowned ac] _ in
//            ac.dismiss(animated: true, completion: nil)
//        }
//        
//        ac.addAction(submitAction)
//            
//        self.present(ac, animated: true)
//    }
}

// MARK: - YAP Filtering
extension BaseVC {
//    internal func findHitInStrings(filterStrings: [Substring], searchStrings: [String]) -> Bool {
//        let nsStrings: [NSString] = searchStrings.map { s in
//            s as NSString
//        }
//        return findHitInStrings(filterStrings: filterStrings, searchStrings: nsStrings)
//    }
    
//    internal func findHitInStrings(filterStrings: [Substring], searchStrings: [NSString]) -> Bool {
//        LogManager.tinyLog("searchStrings: \(String(describing: searchStrings))")
//        var foundHit = false
//        filterStrings.forEach { (s) in
//            if searchStrings.contains(NSString(string: String(s))) {
//                foundHit = true
//            }
//        }
//        return foundHit
//    }
    
//    internal func splitAndNormalize(filterString: String) -> [Substring] {
//        LogManager.tinyLog("filterString: \(String(describing: filterString))")
//        let normalizedString = StringNormalizer().normalizeString(
//            value: filterString,
//            stripSpaces: false,
//            splitWords: true
//        )?.uppercased()
//        let splitNormalized = normalizedString?.split(separator: " ") ?? []
//        LogManager.tinyLog("normalized search string: \(String(describing: normalizedString))")
//        return splitNormalized
//    }
}

// MARK: - PanModal https://github.com/slackhq/PanModal/issues/74
extension BaseVC {
    override func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        if let presentableController = viewControllerToPresent as? PanModalPresentable,
           let controller = presentableController as? UIViewController {
            controller.modalPresentationStyle = .custom
            controller.modalPresentationCapturesStatusBarAppearance = true
            controller.transitioningDelegate = PanModalPresentationDelegate.default
            super.present(controller, animated: flag, completion: completion)
            return
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}

// MARK: - phone numbers
extension BaseVC {
//    internal func showCallNumbersActionSheet(
//        contactName: String?,
//        numbers: [String],
//        favouriteMobile: String?
//    ) {
//        if numbers.count == 1 {
//            UriManager.callNumber(numbers.first!)
//        } else {
//            let alert = UIAlertController(
//                title: "\(contactName ?? "Seleziona il numero")",
//                message: nil,
//                preferredStyle: isPhone ? .actionSheet : .alert
//            )
//            
//            let closeAction = UIAlertAction(
//                title: "Chiudi",
//                style: .cancel
//            )
//            
//            var sortedNumbers = numbers
//            if let preferredNumber = favouriteMobile {
//                sortedNumbers = numbers.sorted {
//                    (n1, n2) -> Bool in
//                    n1 == preferredNumber && n2 != preferredNumber
//                }
//                
//                if !sortedNumbers.contains(preferredNumber) {
//                    sortedNumbers.insert(preferredNumber, at: 0)
//                }
//            }
//            
//            for number in sortedNumbers {
//                let callAction = UIAlertAction(
//                    title: number,
//                    style: .default,
//                    handler: weakify {
//                        strongSelf, action in
//                        UriManager.callNumber(number)
//                    }
//                )
//                
//                if number == favouriteMobile {
//                    callAction.setValue(UIImage(named: "star"), forKey: "image")
//                }
//                
//                alert.addAction(callAction)
//            }
//            
//            alert.addAction(closeAction)
//            
//            // In iPad we set .alert instead of .actionSheet
//            //if UIDevice.current.userInterfaceIdiom == .pad {
//            //    alert.popoverPresentationController?.sourceView = self.view
//            //}
//            
//            present(alert, animated: true, completion: nil)
//        }
//    }
}

// MARK: - table view
extension BaseVC {
    internal func setTableHeaderTopPadding(_ tableView: UITableView) {
        // https://developer.apple.com/forums/thread/683980
        if #available(iOS 15.0, *) {
            if tableView.responds(to: Selector(("sectionHeaderTopPadding"))) {
                tableView.sectionHeaderTopPadding = 0.0
            }
        }
    }
}

// MARK: - Safe Area
extension BaseVC {
//    internal func safeAreaLeadingSpace() -> CGFloat {
//        UIApplication.getKeyWindow()?.safeAreaInsets.left ?? 0
//    }
//    
//    internal func safeAreaTrailingSpace() -> CGFloat {
//        UIApplication.getKeyWindow()?.safeAreaInsets.right ?? 0
//    }
}

