//
//  Successful_InviteVC.swift
//  Bredge
//
//  Created by Magenta on 10/09/22.
//

import UIKit

class Successful_InviteVC: UIViewController {
    static let nibName = "Successful_InviteVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            let dashboard = DashboardController.loadController()
            self.navigationController?.pushViewController(dashboard, animated: true)
            
        }

        // Do any additional setup after loading the view.
    }

}
