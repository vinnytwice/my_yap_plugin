//
//  TableVC.swift
//  Runner
//
//  Created by Vincenzo Calia on 30/01/24.
//

import Foundation
import UIKit

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    private let myArray: NSArray = ["First","Second","Third"]
    private var myTableView: UITableView!
    let buttonA = UIButton(type:UIButton.ButtonType.custom) as UIButton

    override func viewDidLoad() {
        super.viewDidLoad()
        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0//UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight - 300))

        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        
        buttonA.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        buttonA.setTitle("Button", for: UIControl.State.normal)
        buttonA.frame = CGRect(x: displayWidth / 2  - 80, y: myTableView.frame.height + barHeight, width: 160.0, height: 40.0)
        buttonA.backgroundColor = UIColor.systemGray5
        buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
        buttonA.layer.cornerRadius = 8;
        self.view.addSubview(buttonA)
    }
    @objc func onTap() {
        buttonA.setTitle("Button tapped", for: UIControl.State.normal)
        buttonA.setTitleColor(UIColor.black, for: .normal)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.textLabel!.textColor = UIColor.blue
        return cell
    }
}
