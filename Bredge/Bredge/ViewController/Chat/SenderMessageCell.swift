//
//  SenderMessageCell.swift
//  Bredge
//
//  Created by suryaween on 19/10/22.
//

import UIKit

class SenderMessageCell: UITableViewCell {
    static let cell = "SenderMessageCell"
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
