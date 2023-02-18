//
//  SetNewPasswordVC.swift
//  Bredge
//
//  Created by Magenta on 11/09/22.
//

import UIKit

class SetNewPasswordVC: UIViewController,UITextFieldDelegate {
    static let nibName = "SetNewPasswordVC"
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    var token : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtnClicked(_ sender: Any) {
        self.viewModel.execute(with: .SetNew_Password(parameter: ["password":"\(self.newPasswordTF.text ?? "")", "confirm_password":"\(self.confirmPasswordTF.text ?? "")", "token":token]))
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SetNewPasswordVC : LoginSignupViewModelProtocol {
    func updateSetNewpasswordResult(with message:String?, success:Bool){
        DispatchQueue.main.async {
            if success == true{
                self.navigationController?.viewControllers.forEach{vc in
                    if vc.isKind(of: SignUpVC.self) {
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}
