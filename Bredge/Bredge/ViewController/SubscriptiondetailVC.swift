//
//  SubscriptiondetailVC.swift
//  Bredge
//
//  Created by Mac on 06/04/23.
//

import UIKit

class SubscriptiondetailVC: UIViewController {

    @IBOutlet weak var subsdetailbgImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        subsdetailbgImg.layer.shadowColor = UIColor.purple.cgColor
        subsdetailbgImg.layer.shadowRadius = 10
        subsdetailbgImg.layer.shadowOpacity = 0.2
        subsdetailbgImg.layer.shadowOffset = CGSize(width: 0, height: 20)
        subsdetailbgImg.layer.masksToBounds = false
    }
}

