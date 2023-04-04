//
//  ConnectSocialVC.swift
//  Bredge
//
//  Created by Magenta on 10/09/22.
//

import UIKit

class ConnectSocialVC: UIViewController {
    static let nibName = "ConnectSocialVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

    }

    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        let vc: FollowPeopleVC = FollowPeopleVC(nibName:FollowPeopleVC.nibName, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
