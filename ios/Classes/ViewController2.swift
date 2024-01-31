
import UIKit
//import Flutter

class ViewController2: UIViewController {
    var buttonTitleA: String?
    var buttonTitleB: String?
    
     override func viewDidLoad() {
         
         super.viewDidLoad()

         let buttonA = UIButton(type:UIButton.ButtonType.custom)
        //  buttonA.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         buttonA.setTitle(buttonTitleA ?? "VC2 BUTTON A", for: UIControl.State.normal)
         buttonA.frame = CGRect(x: 80.0, y: 410.0, width: 160.0, height: 40.0)
         buttonA.backgroundColor = UIColor.gray//systemGray5
         buttonA.setTitleColor(UIColor.blue, for: .normal)
         buttonA.layer.cornerRadius = 8;
         self.view.addSubview(buttonA)
        
        
         let buttonB = UIButton(type:UIButton.ButtonType.custom)
        //  buttonB.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         buttonB.setTitle(buttonTitleB ?? "VC2 BUTTON B", for: UIControl.State.normal)

         buttonB.frame = CGRect(x: 80.0, y: 460.0, width: 160.0, height: 40.0)
         buttonB.backgroundColor = UIColor.gray
         buttonB.setTitleColor(UIColor.blue, for: .normal)
         buttonB.layer.cornerRadius = 8;
         self.view.addSubview(buttonB);

         
         
         
     }

}

