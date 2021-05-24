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
    var viewModel = NomadViewModel()
    var previousLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    var isFirst: Bool = true
    lazy var reportButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Report", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(reportButtonPresseed), for: .touchUpInside)
        return button
    }()
    @objc func reportButtonPresseed(){
        let vc = ReportViewController()
        let request = updateLocation()
        vc.setLocation(with: request)
        self.present(vc, animated: true, completion: nil)
    }
    override func loadView() {
        super.loadView()
        setViews()
    }
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
    private func setViews(){
        self.view.addSubview(reportButton)
        reportButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        reportButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        reportButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        reportButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.title = "Hello, nomad!"
    }
    private func setTimer(){
        self.gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(shareLocation), userInfo: nil, repeats: true)
    }
    @objc func shareLocation(){
        let requestBody = updateLocation()
        if self.isFirst{
            self.viewModel.sendCurrentLocation(with: requestBody)
            self.isFirst = false
            self.previousLocation = CLLocation(latitude: requestBody.latitude, longitude: requestBody.longitude)
        }else{
            let newLocation = CLLocation(latitude: requestBody.latitude, longitude: requestBody.longitude)
            let distanceInMeters = self.previousLocation.distance(from: newLocation)
            guard distanceInMeters > 5 else {
                return
            }
            self.viewModel.sendCurrentLocation(with: requestBody)
        }
    }
    private func setLocation(){
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
    }
    private func updateLocation() -> LocationRequest{
        if locManager.authorizationStatus == .authorizedWhenInUse || locManager.authorizationStatus ==  .authorizedAlways{
            currentLocation = locManager.location!
        }
        print(currentLocation.coordinate.longitude)
        print(currentLocation.coordinate.latitude)
        return LocationRequest(latitude: currentLocation.coordinate.longitude, longitude: currentLocation.coordinate.latitude)
    }
}
extension NomadViewController: NomadViewModelDelegate{
    func showCritical() {
        print("critical")
    }
    func showMedium() {
        print("medium")
        
    }
    func showNormal() {
        print("normal")
    }
}
