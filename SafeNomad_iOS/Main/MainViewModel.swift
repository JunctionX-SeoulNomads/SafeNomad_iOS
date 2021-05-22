//
//  MainModelView.swift
//  SafeNomad_iOS
//
//  Created by Yessen Yermukhanbet on 5/22/21.
//

import Foundation
protocol MainViewModelDelegate{
    func moveAsNomad()
    func moveAsDriver()
}
class MainViewModel: NSObject{
    var delegate: MainViewModelDelegate?
    public func saveUserType(with type: UserType){
        GlobalAuth.shared.setUserType(with: type)
        self.makeTransition(for: type)
    }
    public func makeTransition(for user: UserType){
        switch user{
        case .Driver:
            self.delegate!.moveAsDriver()
            break
        case .Nomad:
            self.delegate!.moveAsNomad()
            break
        }
    }
}
