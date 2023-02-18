//
//  LikesVC.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class LikesVC: UIViewController {
    @IBOutlet weak var likesTableView: UITableView!
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.likesTableView.register(UINib(nibName:LikesCell.cell, bundle: nil),forCellReuseIdentifier: LikesCell.cell)
        // Do any additional setup after loading the view.
    }

    @IBAction func BackBtnClicked(_ sender: Any) {
       goToPreviousController()
    }

}
extension LikesVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:LikesCell.cell)  as!  LikesCell
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.lblName.text = self.arrUserName[indexPath.row]
     
        return cell
    }
    
    
    
    
}
