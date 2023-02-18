//
//  CommentsCell.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class CommentsCell: UITableViewCell {
  static let cell = "CommentsCell"
    
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
