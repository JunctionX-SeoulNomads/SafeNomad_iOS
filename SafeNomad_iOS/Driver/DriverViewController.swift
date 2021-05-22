//
//  DriverViewController.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import UIKit

class DriverViewController: UIViewController {
    var gameTimer: Timer?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
    }
}
