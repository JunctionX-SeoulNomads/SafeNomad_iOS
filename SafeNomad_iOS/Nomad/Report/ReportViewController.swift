//
//  ReportViewController.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/23/21.
//

import UIKit

class ReportViewController: UIViewController {
    var viewModel = ReportViewModel()
    var location = LocationRequest(latitude: 0.0, longitude: 0.0)
    lazy var messageText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Enter your report here"
        text.layer.borderWidth = 0.3
        text.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        text.textColor = .black
        text.font = .systemFont(ofSize: 20)
        return text
    }()
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .black
        button.setTitleShadowColor(.white, for: .normal)
        button.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc func sendButtonPressed(){
        guard let text = self.messageText.text else{
            return
        }
        let requestBody = ReportRequest(userId: "user", message: text, longitude: self.location.longitude, latitude: self.location.latitude)
        self.viewModel.submitReport(with: requestBody)
    }
    override func loadView() {
        super.loadView()
        self.setViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.view.backgroundColor = .white
        self.messageText.delegate = self
        self.title = "Submit the report"
    }
    private func setViews(){
        self.view.addSubview(messageText)
        self.view.addSubview(sendButton)
        messageText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        messageText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        messageText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        messageText.heightAnchor.constraint(equalToConstant: 150).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
    public func setLocation(with location: LocationRequest){
        self.location = location
    }
}
extension ReportViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
extension ReportViewController: ReportViewModelDelegate{
    func success() {
        self.dismiss(animated: true, completion: nil)
    }
}
