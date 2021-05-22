//
//  NomadViewModel.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation
import Alamofire

protocol DriverViewModelDelegate {
    func showCritical()
    func showMedium()
    func showNormal()
    func showError()
}
class DriverViewModel: NSObject{
    var delegate: DriverViewModelDelegate?
    let headers: HTTPHeaders = [
      "Content-Type": "application/json; utf-8"
    ]
    public func sendCurrentLocation(with location: DriverLocationRequest){
        let param: [String: Any] = [
            "longitude": location.longitude,
            "latitude": location.latitude
        ]
        AF.request("https://safe-nomad.herokuapp.com/driver", method: .post,parameters: param, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 500).responseJSON { AFdata in
            do {
                guard let data = AFdata.value as? [String: Any] else{
                    self.delegate!.showError()
                    return
                }
                debugPrint(data as Any)
                guard let status = data["status"] as? Int else{
                    self.delegate!.showError()
                    return
                }
                self.handleResponse(with: DriverLocationResponse(status: status))
            }
        }
    }
    private func handleResponse(with response: DriverLocationResponse){
        switch response.status{
        case 0:
            self.delegate!.showNormal()
            break
        case 1:
            self.delegate!.showMedium()
            break
        default:
            self.delegate!.showCritical()
            break
        }
    }
    
}
