//
//  NomadViewController.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import UIKit
import CoreLocation

class NomadViewController: UIViewController {
    var gameTimer: Timer?
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLocation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.gameTimer?.invalidate()
    }
    private func setTimer(){
        self.gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(shareLocation), userInfo: nil, repeats: true)
    }
    @objc func shareLocation(){
        print("did called")
        updateLocation()
    }
    private func setLocation(){
        locManager.requestWhenInUseAuthorization()
    }
    private func updateLocation(){
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location!
        }
        print(currentLocation.coordinate.longitude)
        print(currentLocation.coordinate.latitude)
    }
}
