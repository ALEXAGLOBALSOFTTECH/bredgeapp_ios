//
//  BottomSheetCell.swift
//  Bredge
//
//  Created by Magenta on 19/10/22.
//

import UIKit

class BottomSheetCell: UITableViewCell {
static let cell = "BottomSheetCell"
    @IBOutlet weak var lblTitle:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
