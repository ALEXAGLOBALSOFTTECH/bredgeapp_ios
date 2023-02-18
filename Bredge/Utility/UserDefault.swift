//
//  BEnum.swift
//  Bredge
//
//  Created by Rajeev Arkvanshi


import Foundation
import UIKit



final class UserDefaultHelper {
    
   
    
    static var token : String? {
        set{
            _set(value: newValue, key: .token)
        } get {
            return _get(valueForKay: .token) as? String
        }
    }
    static var isLoggedIn : Bool {
        set{
            _set(value: newValue, key: .isLoggedIn)
        } get {
            return _get(valueForKay: .isLoggedIn) as? Bool ?? false
        }
    }
   
    private static func _set(value: Any?, key: BRConstants.USerDefaultsKey) {
        UserDefaults().set(value, forKey: key.rawValue)
     }

    private static func _get(valueForKay key: BRConstants.USerDefaultsKey)-> Any? {
        return UserDefaults().value(forKey: key.rawValue)
    }



@discardableResult static func deleteUserInfo() -> Bool{
    BRConstants.USerDefaultsKey.allCases.forEach { UserDefaults().removeObject(forKey: $0.rawValue) }
   return true
 }

}
