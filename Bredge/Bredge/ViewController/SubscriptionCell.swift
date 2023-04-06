//
//  SubscriptionCell.swift
//  Bredge
//
//  Created by Mac on 05/04/23.
//

import UIKit

class SubscriptionCell: UICollectionViewCell {
    static let  cell = "SubscriptionCell"
    @IBOutlet weak var subscriptionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        subscriptionBtn.layer.cornerRadius = 15
        subscriptionBtn.layer.masksToBounds = true
    }
}

