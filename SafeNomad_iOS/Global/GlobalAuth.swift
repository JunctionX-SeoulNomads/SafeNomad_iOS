//
//  GlobalAuth.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation

class GlobalAuth: NSObject{
    static var shared = GlobalAuth()
    public func setUserType(with type: UserType){
        UserDefaults.standard.setValue("userType", forKey: type.rawValue)
    }
    public func getUserType() -> String{
        guard let userType = UserDefaults.standard.value(forKey: "userType") as? String else {
            return "nomad"
        }
        return userType
    }
}
