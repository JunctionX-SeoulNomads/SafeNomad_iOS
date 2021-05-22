//
//  DriverViewController.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import UIKit
import CoreLocation

class DriverViewController: UIViewController {
    var gameTimer: Timer?
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    var viewModel = DriverViewModel()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewModel.delegate = self
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
        let requestBody = updateLocation()
        self.viewModel.sendCurrentLocation(with: requestBody)
    }
    private func setLocation(){
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
    }
    private func updateLocation() -> DriverLocationRequest{
        if
            locManager.authorizationStatus == .authorizedWhenInUse ||
            locManager.authorizationStatus ==  .authorizedAlways
        {
            currentLocation = locManager.location!
        }
        print(currentLocation.coordinate.longitude)
        print(currentLocation.coordinate.latitude)
        return DriverLocationRequest(latitude: currentLocation.coordinate.longitude, longitude: currentLocation.coordinate.latitude)
    }
}
extension DriverViewController: DriverViewModelDelegate{
    func showError() {
        print("error")
    }
    
    func showCritical() {
        print("critical")
    }
    func showMedium() {
        print("critical")
    }
    func showNormal() {
        print("critical")
    }
}
