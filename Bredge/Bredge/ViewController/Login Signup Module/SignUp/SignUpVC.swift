//
//  SignUpVC.swift
//  Bredge
//
//  Created by Magenta on 08/09/22.
//

import UIKit

class SignUpVC: UIViewController,UITextFieldDelegate {
    static let nibName = "SignUpVC"
    @IBOutlet weak var view1,view2,view3,view4:UIView!
    @IBOutlet weak var textFieldDate     :UITextField!
    @IBOutlet weak var textFieldGender   :UITextField!
    @IBOutlet weak var textFieldMarital  :UITextField!
    @IBOutlet weak var textViewBio       :UITextView!
    @IBOutlet var datePickerValue        :UIDatePicker!
    @IBOutlet var genderPicker           :UIPickerView!
    @IBOutlet var MaritalPicker          :UIPickerView!
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    var arrGender                        = ["Male","Female","Other"]
    var arrMaritalStatus                 = ["Married","Unmarried","Other"]
    var selectedGenderIndex              = 0
    var selectedMaritalIndex             = 0
    
    var user_Email:String             = ""
    var user_Token:String             = ""
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textViewBio.text = "Describe yourself"
        self.textViewBio.textColor = UIColor.lightGray
        self.genderPicker.delegate = self
        self.MaritalPicker.delegate = self
        if #available(iOS 13.4, *) {
            self.datePickerValue?.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        AppUtility.addButtonForUIPicker(textField: self.textFieldGender, viewController: self, picker: self.genderPicker)
        AppUtility.addButtonForUIPicker(textField: self.textFieldMarital, viewController: self, picker: self.MaritalPicker)
        AppUtility.addButtonForUIDatePicker(textField: self.textFieldDate, viewController: self, picker: self.datePickerValue)
        // Do any additional setup after loading the view.
    }

    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        self.updateUserInfo()
    }
    
    
    override func cancelPicker(sender: UIBarButtonItem) {
            print("Sender Value \(sender.tag)")
             self.view.endEditing(true)
    }

    override func submitPicker(sender: UIBarButtonItem) {
        print("Sender Value \(sender.tag)")
          self.view.endEditing(true)
        if sender.tag == 1 {
            self.textFieldGender.text = self.arrGender[selectedGenderIndex]
        }else if sender.tag == 2 {
            self.textFieldMarital.text = self.arrMaritalStatus[self.selectedMaritalIndex]
        }else{
            self.textFieldDate.text =  AppUtility.getStringFromDate(self.datePickerValue.date, "yyyy-MM-dd")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe yourself"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension SignUpVC: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == self.genderPicker {
        self.selectedGenderIndex = row
    }else if pickerView == self.MaritalPicker {
        self.selectedMaritalIndex = row
    }
    print("Name Value \(row)")
  }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            ///  pickerLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18.7)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView == self.genderPicker {
            pickerLabel!.text = self.arrGender[row]
        }else if pickerView == self.MaritalPicker {
            pickerLabel!.text = self.arrMaritalStatus[row]
        }
        pickerLabel?.textColor = .black
        return pickerLabel!
    }
}


extension SignUpVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == self.genderPicker {
        return self.arrGender.count
    } else {
        return self.arrMaritalStatus.count
    }
   
  }
}

extension SignUpVC {
    
    
    //MARK: Login User
    func updateUserInfo() {
        
        self.view.endEditing(true)
        
      
        
        self.viewModel.execute(with: .UpdateProfile(parameter:[ "email": self.user_Email, "first_name": self.firstNameTF.text ?? "", "last_name": self.lastNameTF.text ?? "", "dob": self.textFieldDate.text ?? "", "contact": self.phoneNumberTF.text ?? "", "gender": self.textFieldGender.text ?? "", "marital_status": self.textFieldMarital.text ?? "", "height": "165", "height_unit": "Inch", "bio": self.textViewBio.text ?? "", "lat":"26.8467° N", "lon":"80.9462° E"] ))
        
       /* let req = COHeader.userRegister(self.user_Email, self.firstNameTF.text ?? "", self.lastNameTF.text ?? "", self.textFieldDate.text ?? "", self.phoneNumberTF.text ?? "", self.textFieldGender.text ?? "", self.textFieldMarital.text ?? "", "165", "CM", self.textViewBio.text ?? "")
        
        TFSDataHelper.shared.postDataWith(request:req , serviceURL: BEnum.shared.S_Type(BEnum.B_Enum.UpdateProfile)) { isSuccess, resultDict in
            
            if (isSuccess == true) {
                
                DispatchQueue.main.async {
                    let response:[String:Any] = resultDict

                    print("Response_Data_ResponseData:\(resultDict):::\(response["success"] as? Bool ?? false)")
                    if (response["success"] as? Bool ?? false) == true {

//                        let dataOn = response["data"] as? [String:Any] ?? [:]
//                        UserDefaults.sessionToken = self.tokenData
//                        UserDefaults.isLoggedIn = true
//                        UserDefaults.standard.synchronize()
                        //self.showHome()
                        
                        let vc: SelectInterestsVC = SelectInterestsVC(nibName:SelectInterestsVC.nibName, bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else {
                        
                        self.present(BEnum.shared.showAlert(message: response["message"] as? String ?? ""), animated: true)
                    }
                }
            }
        }*/
    }
}
extension SignUpVC : LoginSignupViewModelProtocol {
    func updateUser(with status: String, message: String?) {
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
        }
    }
    
    func updateProfileResult(with message:String?, success:Bool){
        DispatchQueue.main.async {
            if success == true{
                let vc: SelectInterestsVC = SelectInterestsVC(nibName:SelectInterestsVC.nibName, bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
            }
        }
    }
    
}
