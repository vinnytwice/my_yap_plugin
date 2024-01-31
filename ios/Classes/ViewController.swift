//
//  ViewController.swift
//  UiKitFlutter
//
//  Created by vincenzo calia on 16/10/23.
//

import UIKit
import Flutter

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    public var buttonTitleA: String?
    public var buttonTitleB: String?
    var buttonA = UIButton(type:UIButton.ButtonType.custom) as UIButton
    var buttonB = UIButton(type:UIButton.ButtonType.custom) as UIButton
    var nativeViewerPlatformCahannel: FlutterMethodChannel?

    override func viewDidLoad() {
        super.viewDidLoad()

        let sampleTextField =  UITextField(frame: CGRect(x: self.view.frame.width / 2 - 150, y: 100, width: 300, height: 40))
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        self.view.addSubview(sampleTextField)


        buttonA.addTarget(self, action: #selector(changeButtonBTitle), for: .touchUpInside)
        buttonA.setTitle(buttonTitleA ?? "VC BUTTON A", for: UIControl.State.normal)
        buttonA.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 210.0, width: 160.0, height: 40.0)
        buttonA.backgroundColor = UIColor.gray// .systemGray5
        buttonA.setTitleColor(UIColor.blue, for: .normal)
        buttonA.layer.cornerRadius = 8;
        buttonA.isUserInteractionEnabled = true

        self.view.addSubview(buttonA)
    

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonBPressed))

        // tapGestureRecognizer.isEnabled = true
        // tapGestureRecognizer.cancelsTouchesInView = false
        // tapGestureRecognizer.delegate = self

         
         
         self.view.addGestureRecognizer(tapGestureRecognizer);
        // buttonB.addGestureRecognizer(tapGestureRecognizer);


        //  buttonB.addTarget(self, action: #selector(buttonBPressed), for: .touchUpInside)
        buttonB.setTitle(buttonTitleB ?? "VC BUTTON B", for: UIControl.State.normal)

        buttonB.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 260.0, width: 160.0, height: 40.0)
        buttonB.backgroundColor = UIColor.gray//.systemGray5
        buttonB.setTitleColor(UIColor.blue, for: .normal)
        buttonB.layer.cornerRadius = 8;
        buttonB.isUserInteractionEnabled = true
        self.view.addSubview(buttonB);

         
         
// THE ISSUE:
// called here invokeMethod works so we are sure that the desired beahviour is correct..calling it from button doesn't.
// Native gesture detection is not recognized when native ViewController is shown in Flutter, so no interaction with native buttons is possible.

// WHAT I TRIED:
// Wrapping the UiKitView with a GestureDetector, so we made sure that gestures are passed down to it.
// As a test I swapped the UiKitView wit an ElevatedButton and tested that both onTap from GestureDetector 
// and onPressed from the ElevatedButton callbacks where in fact working as expected.
// I added UIGestureRecognizerDelegate and setup methods to make sure that gestures were detected by the native ViewController, but to no avail.
// 
// OUTCOME: No interaction with the native ViewController has been achieved, making the whole hosting native views in flutter a waste of time.
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //     return true
    // }
    // func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    // return true
    // }
    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        return true
    }



     @objc func changeButtonBTitle() {
        buttonB.setTitle("change back", for: UIControl.State.normal)
        buttonB.setTitleColor(UIColor.blue, for: .normal)

     }

    @objc func buttonBPressed(sender: UITapGestureRecognizer) {
        buttonB.setTitle("VC BUTTON B2", for: UIControl.State.normal)
        buttonB.setTitleColor(UIColor.blue, for: .normal)

        //         let params = [
        //     "screen": "viewController2",
        //     "param 1": "vc2 button A",
        //     "param 2": "vc2 button B"
        //  ] as [String: AnyObject]

//       navChannel!.invokeMethod("navigateToScreen", arguments: params);

    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeButtonBTitle();
        // became first responder
        print("TextField did begin editing method called")

    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }

}

