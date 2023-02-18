//
//  ReceiverMessageCell.swift
//  Bredge
//
//  Created by suryaween on 20/10/22.
//

import UIKit

class ReceiverMessageCell: UITableViewCell {
    static let cell = "ReceiverMessageCell"
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
