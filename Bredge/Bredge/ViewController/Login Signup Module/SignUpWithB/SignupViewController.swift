//
//  SignupViewController.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 16/01/23.
//

import UIKit

class SignupViewController: UIViewController ,UITextFieldDelegate {
    
    static let nibName = "SignupViewController"
        @IBOutlet weak var emailIDTF: UITextField!
        @IBOutlet weak var passwordTF: UITextField!
        @IBOutlet weak var confirmPasswordTF: UITextField!
        
        lazy var viewModel : UserLoginSignupViewModel = {
            let v = UserLoginSignupViewModel()
            v.delegate = self
            return v
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }

        @IBAction func BackBtnClicked(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @IBAction func nextBtnClicked(_ sender: Any) {
            
            if (self.emailIDTF.text?.count ?? 0) == 0 {
                self.present(BEnum.shared.showAlert(message: "Please enter email id"), animated: true)
            }else if (!BEnum.shared.isValidEmail(testStr: self.emailIDTF.text ?? "")) {
                self.present(BEnum.shared.showAlert(message: "Please enter valid email id"), animated: true)
            }else if (self.emailIDTF.text?.count ?? 0) == 0 {
                self.present(BEnum.shared.showAlert(message: "Please enter password"), animated: true)
            }else if (self.confirmPasswordTF.text?.count ?? 0) == 0 {
                self.present(BEnum.shared.showAlert(message: "Please enter confirm password"), animated: true)
            }else if (self.passwordTF.text != self.confirmPasswordTF.text) {
                self.present(BEnum.shared.showAlert(message: "Your password and confirm password is not match."), animated: true)
            }else {
                self.signUp_User()
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

    extension SignupViewController {
        
        
        //MARK: Login User
        func signUp_User() {
            
            self.view.endEditing(true)
            let notificationID:String = UserDefaults.standard.value(forKey: "deviceToken") as? String ?? ""
            
            self.viewModel.execute(with: .SignUp(parameter: ["email":self.emailIDTF.text ?? "", "password":self.passwordTF.text ?? "", "device_token":notificationID]))
         
            /*let signup = COHeader.userSignUpBridge(self.emailIDTF.text ?? "", self.passwordTF.text ?? "")
            
            print("signupsignupsignupsignupsignupsignup::",signup)
            
            TFSDataHelper.shared.postDataWith(request:signup, serviceURL: BEnum.shared.S_Type(BEnum.B_Enum.SignUp)) { isSuccess, resultDict in
                
                if (isSuccess == true) {
                    
                    DispatchQueue.main.async {
                        let response:[String:Any] = resultDict

                        print("Response_Data_ResponseData:\(resultDict.keys):::\(String(describing: response["data"]))")
                        if (response["success"] as? Bool ?? false) == true {
                            
                            let dataOn = response["data"] as? [String:Any] ?? [:]
                            //UserDefaults.sessionToken = dataOn["token"] as? String ?? ""
                            print("=========:::::",(response["data"] as? [String:Any] ?? [:]))
                            
                            let vc: OTPViewController = OTPViewController(nibName:OTPViewController.nibName, bundle: nil)
                            vc.tokenData =  "\(dataOn["token"] as? Int ?? 0)"
                            vc.user_email = self.emailIDTF.text ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                           // self.showHome()
                        }else {
                            
                            self.present(BEnum.shared.showAlert(message: response["message"] as? String ?? ""), animated: true)
                        }
                    }
                }
            }*/
        }
        
        func showHome() {
            
            let window = (UIApplication.shared.delegate as! AppDelegate).window
            window?.rootViewController = DashboardController.loadController()
            window?.makeKeyAndVisible()
        }
    }

extension SignupViewController: LoginSignupViewModelProtocol {
    func signupResult(with message: String?, success: Bool) {
        DispatchQueue.main.async {
            switch success {
            case true :
                let vc: OTPViewController = OTPViewController(nibName:OTPViewController.nibName, bundle: nil)
                vc.tokenData =  UserDefaultHelper.token ?? ""
                vc.user_email = self.emailIDTF.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case false:
                self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
                break
            }
        }
    }
    
    func updateUser(with status: String, message: String?) {
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
        }
    }
    
    
}
