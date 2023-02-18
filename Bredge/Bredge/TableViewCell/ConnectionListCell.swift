//
//  ConnectionListCell.swift
//  Bredge
//
//  Created by Magenta on 18/09/22.
//

import UIKit

class ConnectionListCell: UITableViewCell {
static let cell   = "ConnectionListCell"
    
  
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var lblFollow: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
           super.layoutSubviews()
        self.contentView.layoutSubviews()
        //self.viewFollow.backgroundColor = UIColor.clear
        self.viewFollow.layer.sublayers?.filter{ $0 is CAGradientLayer }.forEach{ $0.removeFromSuperlayer() }

      self.viewFollow.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth:viewFollow.bounds)
       }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
    }
}
