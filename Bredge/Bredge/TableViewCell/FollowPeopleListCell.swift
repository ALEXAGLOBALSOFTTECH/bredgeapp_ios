//
//  FollowPeopleListCell.swift
//  Bredge
//
//  Created by Magenta on 10/09/22.
//

import UIKit

class FollowPeopleListCell: UITableViewCell {
static let cell = "FollowPeopleListCell"
    
   
    @IBOutlet weak var followerCountLable: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var lblFollow: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
