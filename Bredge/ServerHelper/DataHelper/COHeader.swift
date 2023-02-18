//
//  BEnum.swift
//  Bredge
//
//  Created by Sharda Prasad on 05/12/22.
//
import UIKit

class COHeader: NSObject {
    
    static let shar = COHeader()
    private override init(){
        super.init()
    }

    class func CommanHeader() -> [String: Any] {
        
        let userID:String = UserDefaults.standard.value(forKey: "TokenID") as? String ?? ""
        let languageID:Int = UserDefaults.standard.value(forKey: "LID") as? Int ?? 1
        let notificationID:String = UserDefaults.standard.value(forKey: "deviceToken") as? String ?? ""

        return ["LoggedInUserId":userID,"DeviceNotificationID":notificationID,"LanguageTypeId":languageID] as [String: Any]
    }
    
    class func userLogin(_ email:String, _ password:String) -> [String: Any] {
        
        let languageID:Int = UserDefaults.standard.value(forKey: "LID") as? Int ?? 1
        let notificationID:String = UserDefaults.standard.value(forKey: "deviceToken") as? String ?? ""
        
        return ["email":email,
                "password":password,
                "device_token":notificationID]
    }
    class func userSignUpBridge(_ email:String, _ password:String) -> [String: Any] {
        
        //let languageID:Int = UserDefaults.standard.value(forKey: "LID") as? Int ?? 1
        let notificationID:String = UserDefaults.standard.value(forKey: "deviceToken") as? String ?? ""
        
        return ["email":email,
                "password":password,
                "device_token":notificationID]
    }
    
    class func userRegister(_ email:String,_ first_name:String,_ last_name:String,_ dob:String,_ contact:String,_ gender:String, _ marital_Status:String, _ height:String, _ height_unit:String, _ bio:String)  -> [String: Any]  {
        
        return [ "email": email,
                 "first_name": first_name,
                 "last_name": last_name,
                 "dob": dob,
                 "contact": contact,
                 "gender": gender,
                 "marital_status": marital_Status,
                 "height": height,
                 "height_unit": height_unit,
                 "bio": bio]
    }
    
    class func verifyOTP(_ email:String, _ otp:String) -> [String: Any] {
       
        return ["email": email,
                "otp": otp]
    }
    
}
