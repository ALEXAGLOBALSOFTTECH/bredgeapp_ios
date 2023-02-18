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

        // Do any additional setup after loading the view.
    }

    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        let vc: FollowPeopleVC = FollowPeopleVC(nibName:FollowPeopleVC.nibName, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
