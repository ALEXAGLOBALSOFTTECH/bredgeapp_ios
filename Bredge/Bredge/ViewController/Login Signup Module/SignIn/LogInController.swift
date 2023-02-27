//
//  LogInController.swift
//  Bredge
//
//  Created by Mac on 20/02/23.
//

import UIKit

class LogInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func SignUpBtnClicked(_ sender: Any) {
        
        self.pushToNextController(controllerName: SignUpController.loadController())
        
    }
    
}
