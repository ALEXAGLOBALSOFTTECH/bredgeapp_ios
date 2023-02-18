//
//  EventCollectionCell.swift
//  Bredge
//
//  Created by suryaween on 16/09/22.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    static let cell = "EventCollectionCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
