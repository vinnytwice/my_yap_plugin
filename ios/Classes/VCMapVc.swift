//
//  VCMapVc.swift
//  my_yap_plugin
//
//  Created by Vincenzo Calia on 31/01/24.
//

import Foundation
import MapKit
import CoreLocation

class VCMapVc: UIViewController, UIGestureRecognizerDelegate {
    
    let mapView = MKMapView()
    var buttonA = UIButton(type:UIButton.ButtonType.custom) as UIButton
    let container = UIView()
    var isClicked: Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupLayout()
        
    }
    
    func setupMap() {
        
//        container.isUserInteractionEnabled = true
        // without a background color container is transparent so not receivig touches
        container.backgroundColor = .white
//        view.addSubview(buttonA)
        container.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 210.0, width: 160.0, height: 40.0)
        
        buttonA.addTarget(self, action: #selector(changeLocation), for: .touchUpInside)
        buttonA.setTitle("click", for: UIControl.State.normal)
//        buttonA.frame = CGRect(x: self.view.frame.width / 2 - 80, y: 210.0, width: 160.0, height: 40.0)
        buttonA.frame = CGRect(x: 0, y: 0, width: 160.0, height: 40.0)
        buttonA.backgroundColor = UIColor.gray// .systemGray5
        buttonA.setTitleColor(UIColor.blue, for: .normal)
        buttonA.layer.cornerRadius = 8;
//        buttonA.isUserInteractionEnabled = true
        container.addSubview(buttonA)
        
        
//        let doubleTapGesture = UITapGestureRecognizer(target: self, action: nil)
//        doubleTapGesture.numberOfTapsRequired = 2
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeLocation))
//        tapGesture.delegate = self
//        tapGesture.require(toFail: doubleTapGesture)
//        buttonA.addGestureRecognizer(tapGesture)

        let latitude: CLLocationDegrees = 51.481663
        let longitude: CLLocationDegrees = -0.1931452
        
        let latDelta: CLLocationDegrees = 0.02
        let lonDelta: CLLocationDegrees = 0.02
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: coordinates, span: span)
        
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "You are here"
        annotation.subtitle = "Your coordinates are \n\(latitude)° N \n\(longitude)° W"
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    func gestureRecognizer( _ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        return true
    }

     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         return false
     }
    @objc func changeLocation() {
        if(!isClicked) {
//            buttonA.addTarget(self, action: #selector(changeLocation), for: .touchUpInside)
            buttonA.setTitle("clicked", for: UIControl.State.normal)
        } else {
//            buttonA.addTarget(self, action: #selector(changeLocation), for: .touchUpInside)
            buttonA.setTitle("click", for: UIControl.State.normal)
        }
        isClicked = !isClicked
    }
    func setupLayout() {
        
        view.addSubview(mapView)
        view.addSubview(container) // clicks flow right throug the button
//        view.addSubview(buttonA) // button works as expected
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
