//
//  AboutModal.swift
//  TakafulInsurance
//
//  Created by Apple Intigate on 08/08/19.
//  Copyright © 2019 Intigate Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class AboutModal: NSObject {

    var Description               :String?
    var Title                     :String?
    
    //MARK: init override Function
    override init() {
        
        super.init()
        
        self.Description             = ""
        self.Title                   = ""
    }
    
    class func getAboutData(dictData:NSDictionary) -> AboutModal  {
        
        let modalData = AboutModal()
        modalData.Description = dictData.value(forKey: "Description") as? String ?? ""
        modalData.Title = dictData.value(forKey: "Title") as? String ?? ""
        return modalData
    }
}
