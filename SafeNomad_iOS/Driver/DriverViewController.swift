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
    lazy var statusCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 75
        view.layer.borderWidth = 0.5
        view.backgroundColor = #colorLiteral(red: 0.333039403, green: 1, blue: 0, alpha: 1)
        return view
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Good"
        return label
    }()
    override func loadView() {
        super.loadView()
        self.setViews()
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
        self.view.addSubview(statusCircle)
        statusCircle.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        statusCircle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        statusCircle.heightAnchor.constraint(equalToConstant: 150).isActive = true
        statusCircle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.view.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: self.statusCircle.bottomAnchor, constant: 20).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: self.statusCircle.centerXAnchor).isActive = true
        statusLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
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
    func showSuperCritical() {
        self.statusCircle.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        self.statusLabel.text = "super critical"
        self.statusCircle.fadeTransition(0.3)
        self.statusLabel.fadeTransition(0.3)
    }
    func showCritical() {
        self.statusCircle.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        self.statusLabel.text = "Critical"
        self.statusCircle.fadeTransition(0.3)
        self.statusLabel.fadeTransition(0.3)
    }
    func showMedium() {
        self.statusCircle.backgroundColor = .orange
        self.statusLabel.text = "Medium"
        self.statusCircle.fadeTransition(0.3)
        self.statusLabel.fadeTransition(0.3)
    }
    func showNormal() {
        self.statusCircle.backgroundColor = .yellow
        self.statusLabel.text = "Normal"
        self.statusCircle.fadeTransition(0.3)
        self.statusLabel.fadeTransition(0.3)
    }
    func showGood() {
        self.statusCircle.backgroundColor = .green
        self.statusLabel.text = "Good"
        self.statusCircle.fadeTransition(0.3)
        self.statusLabel.fadeTransition(0.3)
    }
}
