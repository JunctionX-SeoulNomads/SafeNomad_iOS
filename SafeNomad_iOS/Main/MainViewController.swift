//
//  MainViewController.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel = MainViewModel()
    lazy var driverButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("driver", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    lazy var nomadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("nomad", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    @objc func buttonPressed(_ sender:UIButton){
        switch sender.titleLabel!.text{
        case "driver":
            //save user as driver
            self.viewModel.saveUserType(with: .Driver)
            break
        case "nomad":
            self.viewModel.saveUserType(with: .Nomad)
            //save user as nomad
            break
        case .none:
            break
        case .some(_):
            break
        }
    }
    override func loadView() {
        super.loadView()
        self.addViews()
        self.setViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewModel.delegate = self
    }
    private func addViews(){
        self.view.addSubview(driverButton)
        self.view.addSubview(nomadButton)
    }
    private func setViews(){
        driverButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        driverButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        driverButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10).isActive = true
        driverButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10).isActive = true
        nomadButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        nomadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nomadButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        nomadButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
}
extension MainViewController: MainViewModelDelegate{
    func moveAsNomad() {
        let vc = NomadViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveAsDriver() {
        let vc = DriverViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
