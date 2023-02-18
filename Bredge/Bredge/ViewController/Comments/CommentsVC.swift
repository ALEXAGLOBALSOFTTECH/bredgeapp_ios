//
//  CommentsVC.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class CommentsVC: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commentsTableView.register(UINib(nibName:CommentsCell.cell, bundle: nil),forCellReuseIdentifier: CommentsCell.cell)
        // Do any additional setup after loading the view.
    }


    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
    

}
extension CommentsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUserName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CommentsCell.cell)  as!  CommentsCell
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.lblName.text = self.arrUserName[indexPath.row]
     
        return cell
    }
    
    
    
    
}
