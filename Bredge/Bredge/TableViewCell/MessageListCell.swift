//
//  MessageListCell.swift
//  Bredge
//
//  Created by Magenta on 17/09/22.
//

import UIKit

class MessageListCell: UITableViewCell {
static let cell = "MessageListCell"
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var sortMassageLable: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
