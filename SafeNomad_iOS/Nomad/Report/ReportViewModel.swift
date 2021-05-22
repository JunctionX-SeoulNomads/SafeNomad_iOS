//
//  ReportViewModel.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/23/21.
//

import Foundation
import Alamofire
protocol ReportViewModelDelegate {
    func success()
}
class ReportViewModel: NSObject{
    var delegate: ReportViewModelDelegate?
    let headers: HTTPHeaders = [
      "Content-Type": "application/json; utf-8"
    ]
    public func submitReport(with report: ReportRequest){
        let param: [String: Any] = [
            "userId": report.userId,
            "message": report.message,
            "longitude": report.longitude,
            "latitude": report.latitude
        ]
        AF.request("https://safe-nomad.herokuapp.com/complain", method: .post,parameters: param, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200 ..< 500).responseJSON { AFdata in
            do {
                let data = AFdata.value as? [String: Any]
                debugPrint(data as Any)
                self.delegate!.success()
            }
        }
        
    }
}
