//
//  MessageListVC.swift
//  Bredge
//
//  Created by Magenta on 17/09/22.
//

import UIKit

class MessageListVC: UIViewController {
static let nibName = "MessageListVC"
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName:MessageListCell.cell, bundle: nil),forCellReuseIdentifier: MessageListCell.cell)
        self.tableView.reloadData()
    }

    @IBAction func backbuttonClicked(_ sender: Any) {
        self.goToPreviousController()
    }

}
extension MessageListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MessageListCell.cell)  as!  MessageListCell
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.userNameLable.text = self.arrUserName[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.pushToNextController(controllerName: ChatVC.loadController())
    }
    
}
