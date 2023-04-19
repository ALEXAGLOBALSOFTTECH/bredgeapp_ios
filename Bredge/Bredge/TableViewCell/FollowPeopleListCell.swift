//
//  FollowPeopleListCell.swift
//  Bredge
//
//  Created by Magenta on 10/09/22.
//

import UIKit

class FollowPeopleListCell: UITableViewCell {
static let cell = "FollowPeopleListCell"
    
   
    @IBOutlet weak var followerCountLable: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var lblFollow: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.userProfile.layer.cornerRadius = 22
        self.userProfile.clipsToBounds = true
        
    }
    
    func drawCell(with userData:UserList?){
        if let i = userData?.image, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(i)") {
            self.setImage(with: url, imageView: self.userProfile, button: nil)
        
        }
        self.followerCountLable.text = "\(userData?.followerCount ?? 0) Followers"
        self.userNameLable.text = "\(userData?.first_name ?? "") \(userData?.last_name ?? "")"
        if let following = userData?.following {
            if following == 0 {
                self.viewFollow.backgroundColor = UIColor.white
                self.lblFollow.textColor = UIColor.init(hexString: "#9833EA")
                self.lblFollow.text = "Follow"
            }else{
                self.viewFollow.backgroundColor = UIColor.init(hexString: "#A740E4")
                self.lblFollow.textColor = UIColor.white
                self.lblFollow.text = "Unfollow"
            }
        }
        
    }
    
}
