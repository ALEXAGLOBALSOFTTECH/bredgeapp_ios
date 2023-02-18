//
//  ForgotPasswordVC.swift
//  Bredge
//
//  Created by Magenta on 11/09/22.
//

import UIKit

class ForgotPasswordVC: UIViewController,UITextFieldDelegate {
    static let nibName = "ForgotPasswordVC"
    @IBOutlet weak var emailIDTF: UITextField!
    
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
        
        self.viewModel.execute(with: .Forget_Password(parameter: ["email":self.emailIDTF.text ?? ""]))
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ForgotPasswordVC: LoginSignupViewModelProtocol {
    func updateForgetPasswordResult(with message:String?, success:Bool, token:String?){
        DispatchQueue.main.async {
            let vc: OTPViewController = OTPViewController(nibName:OTPViewController.nibName, bundle: nil)
             vc.user_email = self.emailIDTF.text ?? ""
            vc.tokenData =  token ?? ""
            vc.purpose = .forgetPassword
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
