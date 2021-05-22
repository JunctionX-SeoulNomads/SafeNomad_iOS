//
//  NomadViewModel.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation
import Alamofire

protocol NomadViewModelDelegate {
    func showCritical()
    func showMedium()
    func showNormal()
}
class NomadViewModel: NSObject{
    var delegate: NomadViewModelDelegate?
    let headers: HTTPHeaders = [
      "Content-Type": "application/json; utf-8"
    ]
    
    public func sendCurrentLocation(with location: LocationRequest){
        let param: [String: Any] = [
            "longitude": location.longitude,
            "latitude": location.latitude
        ]
        AF.request("https://safe-nomad.herokuapp.com/user", method: .post,parameters: param, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 500).responseJSON { AFdata in
            do {
                let data = AFdata.value as? [String: Any]
                debugPrint(data as Any)
                self.delegate!.showNormal()
            }
        }
    }
    
}
