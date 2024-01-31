//
//  ScrollVC.swift
//  Runner
//
//  Created by Vincenzo Calia on 30/01/24.
//

import UIKit

class ScrollVC: UIViewController, UIGestureRecognizerDelegate {
    let buttonA = UIButton(type:UIButton.ButtonType.custom) as UIButton
    let buttonB = UIButton(type:UIButton.ButtonType.custom) as UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(redView)
        scrollViewContainer.addArrangedSubview(blueView)
        scrollViewContainer.addArrangedSubview(greenView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        buttonA.addTarget(self, action: #selector(changeButtonBTitle), for: .touchUpInside)
        buttonA.setTitle("Button A", for: UIControl.State.normal)
        buttonA.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 100.0, width: 160.0, height: 40.0)
        buttonA.backgroundColor = UIColor.systemGray5
        buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
        buttonA.layer.cornerRadius = 8;
        
        buttonB.addTarget(self, action: #selector(buttonBPressed), for: .touchUpInside)
        buttonB.setTitle("Button B", for: UIControl.State.normal)
        buttonB.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 200.0, width: 160.0, height: 40.0)
        buttonB.backgroundColor = UIColor.systemGray5
        buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
        buttonB.layer.cornerRadius = 8;
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonBPressed))
        tapGestureRecognizer.delegate =  self    

        redView.addSubview(buttonA)
        redView.addSubview(buttonB)
        
        blueView.addGestureRecognizer(tapGestureRecognizer)
        blueView.isUserInteractionEnabled = true
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let redView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 500).isActive = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = .red
        return view
    }()
    
    

    let blueView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.backgroundColor = .blue
        return view
    }()

    let greenView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1200).isActive = true
        view.backgroundColor = .green
        return view
    }()    
    
    @objc func changeButtonBTitle() {
        buttonB.setTitle("change back", for: UIControl.State.normal)
        buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
     }

    @objc func buttonBPressed(sender: UITapGestureRecognizer) {
        buttonB.setTitle("VC BUTTON B2", for: UIControl.State.normal)
        buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
    }

//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }

//    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
//        return true
//    }

    // func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    //     shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //     return true
    // }


}

