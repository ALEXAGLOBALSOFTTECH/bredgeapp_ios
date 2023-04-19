//
//  SubscriptiondetailVC.swift
//  Bredge
//
//  Created by Mac on 06/04/23.
//

import UIKit

class SubscriptiondetailVC: UIViewController {
    static let nibName = "SubscriptiondetailVC"
    @IBOutlet weak var subsdetailbgImg: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName:detailTableViewCell.cell, bundle: nil),forCellReuseIdentifier: detailTableViewCell.cell)
        subsdetailbgImg.layer.shadowColor = UIColor.purple.cgColor
        subsdetailbgImg.layer.shadowRadius = 10
        subsdetailbgImg.layer.shadowOpacity = 0.2
        subsdetailbgImg.layer.shadowOffset = CGSize(width: 0, height: 20)
        subsdetailbgImg.layer.masksToBounds = false
        
//        tableView.cornerRadius = 6.0
//        tableView.layer.borderColor = red.cgColor
//        tableView.layer.borderWidth = 1.0
    }
}

extension SubscriptiondetailVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:detailTableViewCell.cell)  as!  detailTableViewCell

        return cell
    }
    }
