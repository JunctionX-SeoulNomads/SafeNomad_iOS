//
//  NomadViewModel.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation
import Alamofire

protocol DriverViewModelDelegate {
    func showSuperCritical()
    func showCritical()
    func showMedium()
    func showNormal()
    func showGood()
    func showError()
}
protocol DriverViewModelParkingDelegate{
    func superBadParking()
    func mediumParking()
    func goodParking()
    func showError()
}
class DriverViewModel: NSObject{
    var delegate: DriverViewModelDelegate?
    var delegateParking: DriverViewModelParkingDelegate?
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
    public func endParking(with location: DriverLocationRequest){
        let param: [String: Any] = [
            "longitude": location.longitude,
            "latitude": location.latitude
        ]
        AF.request("https://safe-nomad.herokuapp.com/parking", method: .post,parameters: param, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 500).responseJSON { AFdata in
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
                self.handleParkingResponse(with: DriverLocationResponse(status: status))
            }
        }
    }
    private func handleResponse(with response: DriverLocationResponse){
        switch response.status{
        case 0:
            self.delegate!.showGood()
            break
        case 1:
            self.delegate!.showNormal()
            break
        case 2:
            self.delegate!.showMedium()
            break
        case 3:
            self.delegate!.showCritical()
            break
        case 4:
            self.delegate!.showSuperCritical()
        default:
            self.delegate!.showCritical()
            break
        }
    }
    private func handleParkingResponse(with response: DriverLocationResponse){
        switch response.status{
        case 0:
            self.delegateParking!.goodParking()
            break
        case 1:
            self.delegateParking!.mediumParking()
            break
        case 2:
            self.delegateParking!.superBadParking()
        default:
            self.delegateParking!.superBadParking()
            break
        }
    }
}
