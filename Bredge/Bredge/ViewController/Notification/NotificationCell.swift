//
//  NotificationCell.swift
//  Bredge
//
//  Created by Magenta on 22/10/22.
//

import UIKit
class NotificationCell: UITableViewCell {
static let cell = "NotificationCell"
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    override func layoutSubviews() {
           super.layoutSubviews()
        self.contentView.layoutSubviews()
        self.bgView.applyGradientColors(colors: [UIColor.init(hexString: "#E9D7F8").cgColor, UIColor.init(hexString: "#D797FC").cgColor], isFromTopToBottom: false, frameWidth: bgView.bounds)
       }
    
}
