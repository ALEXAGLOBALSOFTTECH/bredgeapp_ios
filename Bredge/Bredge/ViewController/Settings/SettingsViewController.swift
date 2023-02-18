//
//  SettingsViewController.swift
//  Bredge
//
//  Created by suryaween on 20/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
    static let nibName = "SettingsViewController"
    @IBOutlet weak var menuListTableView: UITableView!
    var menuListOptions = ["Gems","Edit Profile","Subscription","Payment & Billing","Notification","Statistics & Reports","Daily Trivia","Support"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuListTableView.register(UINib(nibName:LikesCell.cell, bundle: nil),forCellReuseIdentifier: LikesCell.cell)
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.applyGradientColors(colors: [ColorConstants.ApplicationGradientColor.firstGradient.cgColor , ColorConstants.ApplicationGradientColor.secondGradient.cgColor], isFromTopToBottom: true, frameWidth: self.view.bounds)
    }
    @IBAction func cancelBtnClicked(_ sender: Any) {
        sideMenuViewController?._presentLeftMenuViewController()
        //self.goToPreviousController()
    }
    
    @IBAction func logout_BtnClicked(_ sender: Any) {
       // sideMenuViewController?._presentLeftMenuViewController()
        
        self.showSplash()
    }

    func showSplash() {
       // UserDefaults.isLoggedIn = false
       // UserDefaults.standard.synchronize()
        
        let viewController = BRSplashVC()
        let navigationBar = UINavigationController(rootViewController: viewController)
        navigationBar.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationBar
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuListOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:LikesCell.cell)  as!  LikesCell
        cell.backgroundColor = .clear
        cell.userProfile.image = UIImage(named: self.menuListOptions[indexPath.row])
        cell.lblName.text = self.menuListOptions[indexPath.row]
        cell.lblName.textColor = .white
        cell.widthConstraint.constant = 32
        cell.heightConstraint.constant = 32
        cell.userProfile.cornerRadius = 32/2
     
        return cell
    }
    
    
    
    
}
