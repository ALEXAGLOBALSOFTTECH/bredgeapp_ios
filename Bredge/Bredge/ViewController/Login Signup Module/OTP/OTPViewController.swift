//
//  OTPViewController.swift
//  Bredge
//
//  Created by suryaween on 10/09/22.
//

import UIKit
import IQKeyboardManagerSwift

class OTPViewController: UIViewController,UITextFieldDelegate {
  
    
    static let nibName = "OTPViewController"
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    
    var tokenData:String = ""
    var user_email:String = ""
    var purpose : BRConstants.purpose = .createProfile

    var myString:NSString = "Enter code sent\n to your email"
    var myMutableString = NSMutableAttributedString()
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        firstTextField.inputView = NumericKeyboard(target: firstTextField, useDecimalSeparator: false)
        secondTextField.inputView = NumericKeyboard(target: secondTextField, useDecimalSeparator: false)
        thirdTextField.inputView = NumericKeyboard(target: thirdTextField, useDecimalSeparator: false)
        fourthTextField.inputView = NumericKeyboard(target: fourthTextField, useDecimalSeparator: false)
        IQKeyboardManager.shared.enableAutoToolbar = false
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        fourthTextField.delegate = self
       
        print("::=====OTP =:", tokenData)

        
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
      
    }
    
    

    @IBAction func resendOtpButtonClick(_ sender: Any) {
        self.viewModel.execute(with: .ResendOTP(parameter: ["email": self.user_email,"token": self.tokenData]))
        self.firstTextField.text = ""
        self.secondTextField.text = ""
        self.thirdTextField.text = ""
        self.fourthTextField.text = ""
    }
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        let otpData = String(format: "%@%@%@%@", self.firstTextField.text ?? "",self.secondTextField.text ?? "",self.thirdTextField.text ?? "",self.fourthTextField.text ?? "")

        if (otpData.count != 4) {
            self.present(BEnum.shared.showAlert(message: "Please enter valid OTP."), animated: true)
        }else {
            self.OTPVerification()
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        textField.resignFirstResponder()
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
    }
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool {
         
        switch (textField){
        
        case firstTextField :
            if string != "" || firstTextField.text!.count > 0
            {
                secondTextField.becomeFirstResponder()
            }
            else
            {
                
            }
            
        case secondTextField :
            if string != "" || secondTextField.text!.count > 0
            {
                thirdTextField.becomeFirstResponder()
            }
        case thirdTextField :
            if string != "" || thirdTextField.text!.count > 0
            {
                fourthTextField.becomeFirstResponder()
            }
        case fourthTextField :
            if string != "" || fourthTextField.text!.count > 0
            {
                fourthTextField.resignFirstResponder()
               
            }
            else
            {
                fourthTextField.becomeFirstResponder()
            }
            
        default:
            print("Clicked Item)")
        
        }
           return true
       }
}

extension OTPViewController {
    
    
    //MARK: Login User
    func OTPVerification() {
        
        self.view.endEditing(true)
        
        let otpData = String(format: "%@%@%@%@", self.firstTextField.text ?? "",self.secondTextField.text ?? "",self.thirdTextField.text ?? "",self.fourthTextField.text ?? "")
        self.viewModel.execute(with: .VerifyOtp(parameter: ["email": self.user_email,"otp": otpData]))
        
      
    }
    
    func showHome() {
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.rootViewController = DashboardController.loadController()
        window?.makeKeyAndVisible()
    }
}

extension OTPViewController : LoginSignupViewModelProtocol {
    
    func otpVerifyResult(with message:String?, success:Bool){
        DispatchQueue.main.async {
            if success == true {
                switch self.purpose {
                case .createProfile:
                    UserDefaultHelper.isLoggedIn = true
                    let vc: SignUpVC = SignUpVC(nibName:SignUpVC.nibName, bundle: nil)
                    vc.user_Email = self.user_email
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case .forgetPassword:
                    let vc: SetNewPasswordVC = SetNewPasswordVC(nibName:SetNewPasswordVC.nibName, bundle: nil)
                    vc.token = self.tokenData
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                }
                
            }else{
                self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
            }
        }
    }
    func updateUser(with status:String,message:String?){
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
        }
    }
    func updateResendOtpResult(with message:String?, success:Bool, token:String){
        self.tokenData = token
    }
}
