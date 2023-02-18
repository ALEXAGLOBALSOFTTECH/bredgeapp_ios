//
//  BEnum.swift
//  Bredge
//
//  Created by Sharda Prasad on 05/12/22.
//

import UIKit

class BEnum: NSObject {
    
    static let shared = BEnum()
    private override init(){
        
        super.init()
    }
    
    enum B_Enum {
        case LoginUser,
             SignUp,
             ResendOTP,
             VerifyOtp,
             UpdateProfile,
             All_Interest
    }
    
    
    func S_Type(_ serviceType: B_Enum) -> String {
        
        switch serviceType {
        case .LoginUser:
            return "\(TFSDataHelper.baseUrl)\("login")"
        case .SignUp:
            return "\(TFSDataHelper.baseUrl)\("register")"
        case .ResendOTP:
            return "\(TFSDataHelper.baseUrl_One)\("")"
        case .VerifyOtp:
            return "\(TFSDataHelper.baseUrl_One)\("otpVerify")"
        case .UpdateProfile:
            return "\(TFSDataHelper.baseUrl)\("register2")"
        case .All_Interest:
            return "\(TFSDataHelper.baseUrl)\("all-interest")"
        }
    }
    
    /// Email validation
    ///
    /// - Parameter testStr:
    /// - Returns:Bool
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK: showAlert Function
    func showAlert(message:String) -> UIAlertController {
        
        let actionSheetController: UIAlertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
        }
        actionSheetController.addAction(nextAction)
        return actionSheetController
    }
    
    func showPayAlert(message:String) -> UIAlertController {
        
        let actionSheetController: UIAlertController = UIAlertController(title: message, message: "", preferredStyle: .alert)
        //        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
        //        }
        //        actionSheetController.addAction(nextAction)
        return actionSheetController
    }
    
    func hexToColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
            
        }
        if ((cString.count) != 6) {
            return UIColor.gray
            
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: CGFloat(1.0) )
    }
    
}
