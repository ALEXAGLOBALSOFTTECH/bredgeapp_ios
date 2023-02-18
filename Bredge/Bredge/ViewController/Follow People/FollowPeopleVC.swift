//
//  FollowPeopleVC.swift
//  Bredge
//
//  Created by Magenta on 10/09/22.
//

import UIKit

class FollowPeopleVC: UIViewController,UITextFieldDelegate {
    static let nibName = "FollowPeopleVC"
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var userListTableView: UITableView!
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]() //
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    var attributedString = NSMutableAttributedString(string:"")
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "9833EA") as Any,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userListTableView.register(UINib(nibName:FollowPeopleListCell.cell, bundle: nil),forCellReuseIdentifier: FollowPeopleListCell.cell)
        let buttonTitleStr = NSMutableAttributedString(string:"Skip", attributes:attrs)
        attributedString.append(buttonTitleStr)
        skipButton.setAttributedTitle(attributedString, for: .normal)
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
       goToPreviousController()
    }
    @IBAction func nextBtnClicked(_ sender: Any) {

        self.pushToNextController(controllerName: Successful_InviteVC.loadController())
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension FollowPeopleVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:FollowPeopleListCell.cell)  as!  FollowPeopleListCell
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.userNameLable.text = self.arrUserName[indexPath.row]
        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
            cell.viewFollow.backgroundColor = UIColor.init(hexString: "#A740E4")
            cell.lblFollow.textColor = UIColor.white
            cell.lblFollow.text = "Unfollow"
        }
        else {
            cell.viewFollow.backgroundColor = UIColor.white
            cell.lblFollow.textColor = UIColor.init(hexString: "#9833EA")
            cell.lblFollow.text = "Follow"
        }
        
        cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strData = arrUserImage[indexPath.item]
         
         if arrSelectedIndex.contains(indexPath) {
             arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
             arrSelectedData = arrSelectedData.filter { $0 != strData}
         }
         else {
             arrSelectedIndex.append(indexPath)
             arrSelectedData.append(strData)
         }


         self.userListTableView.reloadData()
    }
    
    
    
}
