//
//  StoryCollectionViewCell.swift
//  Bredge
//
//  Created by Magenta on 12/09/22.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
static let cell = "StoryCollectionViewCell"
    @IBOutlet weak var imgStory:UIImageView!
    @IBOutlet weak var view1:UIView!
    @IBOutlet weak var lblCreate:UILabel!
    @IBOutlet weak var btnAdd:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
