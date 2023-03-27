//
//  BRConstants.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 17/01/23.
//

import Foundation
import UIKit

class BRConstants : NSObject {
    static let shared = BRConstants()
    
    static let appDeligate : AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    enum USerDefaultsKey: String, CaseIterable {
        case token = "token"
        case isLoggedIn = "isLoggedIn"
        case OnBordingCompleted = "OnBordingCompleted"
    }
    enum purpose : String{
        case createProfile
        case forgetPassword
    }
}
