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
    
    var userList : [UserList]?{
        didSet{
            self.userListTableView.reloadData()
        }
    }
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    var attributedString = NSMutableAttributedString(string:"")
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "9833EA") as Any,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.userListTableView.register(UINib(nibName:FollowPeopleListCell.cell, bundle: nil),forCellReuseIdentifier: FollowPeopleListCell.cell)
        let buttonTitleStr = NSMutableAttributedString(string:"Skip", attributes:attrs)
        attributedString.append(buttonTitleStr)
        skipButton.setAttributedTitle(attributedString, for: .normal)
        self.viewModel.execute(with: .getAllUserList(parameter: ["token":UserDefaultHelper.token ?? "", "page":"1"]))
    }
    
    @IBAction func skipButtonClick(_ sender: Any) {
        self.pushToNextController(controllerName: Successful_InviteVC.loadController())
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
        self.userList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:FollowPeopleListCell.cell)  as!  FollowPeopleListCell
        cell.drawCell(with: self.userList?[indexPath.row])
       
        
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.execute(with: .followUnfollow(parameter: ["token":UserDefaultHelper.token ?? "", "following_user_id":"\(self.userList?[indexPath.row].id ?? 0)"]))
        
        if let following = self.userList?[indexPath.row].following {
            if following == 0 {
                self.userList?[indexPath.row].following = 1
            }else{
                self.userList?[indexPath.row].following = 0
            }
        }

         self.userListTableView.reloadData()
    }
    
    
    
}

extension FollowPeopleVC : LoginSignupViewModelProtocol{
    func updateUserListResponse(detail:[UserList]?){
        DispatchQueue.main.async {
            self.userList = detail
        }
    }
}
