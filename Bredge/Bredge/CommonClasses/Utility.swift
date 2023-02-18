//
//  Utility.swift
//  Bredge
//
//  Created by Magenta on 11/09/22.
//

import Foundation
import UIKit

let CurrentTimeZone = TimeZone.current
class AppUtility{
   
    //MARK:- convert date to string method
    class func getStringFromDate( _ date:Date,_ format:String ) -> String{
      let dateFormatter:DateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = CurrentTimeZone
      let localDateString = dateFormatter.string(from: date)
        
      return localDateString
    }
    
    class func addButtonForUIDatePicker(textField:UITextField , viewController:UIViewController , picker:UIDatePicker){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.barTintColor =  UIColor(red: 152/255.0, green: 51/255.0, blue: 234/255.0, alpha: 1.0)
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Submit", style: .plain, target: viewController, action: #selector(viewController.submitPicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: viewController, action: #selector(viewController.cancelPicker(sender:)))
        
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 18.0)!], for: UIControl.State.normal)
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 18.0)!], for: UIControl.State.normal)

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        doneButton.tag = picker.tag
        cancelButton.tag = picker.tag
        picker.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
  }
    //MARK: add submit button at picker method
      class func addButtonForUIPicker(textField:UITextField , viewController:UIViewController , picker:UIPickerView){
      let toolBar = UIToolbar()
      toolBar.barStyle = .default
      toolBar.isTranslucent = false
    toolBar.barTintColor =  UIColor(red: 152/255.0, green: 51/255.0, blue: 234/255.0, alpha: 1.0)
      toolBar.tintColor = UIColor.white
      toolBar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Submit", style: .plain, target: viewController, action: #selector(viewController.submitPicker(sender:)))
      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: viewController, action: #selector(viewController.cancelPicker(sender:)))
      
      doneButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 18.0)!], for: UIControl.State.normal)
      cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 18.0)!], for: UIControl.State.normal)

          
      toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
      toolBar.isUserInteractionEnabled = true
      doneButton.tag = picker.tag
      cancelButton.tag = picker.tag
      picker.translatesAutoresizingMaskIntoConstraints = false
      textField.inputView = picker
      textField.inputAccessoryView = toolBar
    }
}


extension UIViewController{
    @objc func submitPicker(sender:UIBarButtonItem){}

    @objc func cancelPicker(sender:UIBarButtonItem){}
}
extension UIView {
    
    @objc func submitPicker(sender:UIBarButtonItem){

    }

    @objc func cancelPicker(sender:UIBarButtonItem){
      
    }
    
}
