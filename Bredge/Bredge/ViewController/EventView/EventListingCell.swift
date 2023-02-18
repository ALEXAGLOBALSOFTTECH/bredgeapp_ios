//
//  EventListingCell.swift
//  Bredge
//
//  Created by suryaween on 17/09/22.
//

import UIKit

class EventListingCell: UITableViewCell {
    @IBOutlet weak var datetimeLabel: UILabel!
    static let cell = "EventListingCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
