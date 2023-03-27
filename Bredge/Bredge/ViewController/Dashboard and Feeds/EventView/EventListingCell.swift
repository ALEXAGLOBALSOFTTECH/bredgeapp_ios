//
//  EventListingCell.swift
//  Bredge
//
//  Created by suryaween on 17/09/22.
//

import UIKit

class EventListingCell: UITableViewCell {
    @IBOutlet weak var datetimeLabel: UILabel!
    
    @IBOutlet weak var eventDescriptionLable: UILabel!
    @IBOutlet weak var eventTypeLable: UILabel!
    @IBOutlet weak var eventNameLable: UILabel!
    static let cell = "EventListingCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func drawCellWithEvent(data:DataObject?){
        self.eventNameLable.text = data?.event_name
        self.eventTypeLable.text = data?.event_type
        self.eventDescriptionLable.text = data?.description
        self.datetimeLabel.text = data?.event_date
    }
    
}
