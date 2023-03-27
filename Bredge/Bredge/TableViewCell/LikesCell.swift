//
//  LikesCell.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class LikesCell: UITableViewCell {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    static let cell = "LikesCell"
    
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
    
    func drawLikeCell(with dataObject:DataObject?){
        self.lblName.text = "\(dataObject?.first_name ?? "")  \(dataObject?.last_name ?? "")"
        if let p = dataObject?.image, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(p)") {
            self.setImage(with: url, imageView: self.userProfile, button: nil)
        }
    }
    
    override func layoutSubviews() {
       // self.userProfile.layer.cornerRadius = 10
        self.userProfile.layer.cornerRadius = (self.userProfile.frame.size.height)/2
        self.userProfile.clipsToBounds = true
    }
    
}
