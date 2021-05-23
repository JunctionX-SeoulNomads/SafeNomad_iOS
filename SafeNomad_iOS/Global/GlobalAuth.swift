//
//  GlobalAuth.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation
import UIKit

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
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
