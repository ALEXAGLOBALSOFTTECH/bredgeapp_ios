//
//  FeedTableViewCell.swift
//  Bredge
//
//  Created by Magenta on 12/09/22.
//

import UIKit

protocol FeedTableViewCellProtocol : AnyObject {
    func tapOnLike(for object: DataObject?)
    func tapOnComment(for object: DataObject?)
    func tapOnImageProfile(for object: DataObject?)
    
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate : FeedTableViewCellProtocol?
    @IBOutlet weak var moreOptionButton: UIButton!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDescriptionLable: UILabel!
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet var userNameLable: UILabel!
    @IBOutlet weak var btnFeedProfile: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    static let cell = "FeedTableViewCell"
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 14.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "9833EA") as Any]
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postDescriptionLable.attributedText =  self.contentView.colouringTags(stringValue: postDescriptionLable.text!)
        
        self.btnFeedProfile.addTarget(self, action: #selector(tapOnImageProfile), for: .touchUpInside)
        self.btnLike.addTarget(self, action: #selector(tapOnLike), for: .touchUpInside)
        self.btnComment.addTarget(self, action: #selector(tapOnComment), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var dataObject : DataObject?
    
    func populatePostWith(data:DataObject?){
        self.dataObject = data
        self.postDescriptionLable.text = data?.description
        self.locationLable.text = data?.location
        self.userNameLable.text = "\(data?.first_name ?? "")  \(data?.last_name ?? "")"
        self.btnComment.setTitle("\(data?.comments ?? 0)", for: .normal)
        self.btnLike.setTitle("\(data?.likes ?? 0)", for: .normal)
        
        if let i = data?.profile_img, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(i)") {
            self.setImage(with: url, imageView: nil, button: self.btnFeedProfile)
        
        }
        
        if let imgs = data?.images{
            let arr = imgs.components(separatedBy: ",")
            if let f = arr.first,
               let url = URL(string: "http://bregeapptest.in/public/posts/\(f)") {
                self.setImage(with: url, imageView: self.postImage, button:nil )
            }
            
        }
        
    }
   
    
    
    override func layoutSubviews() {
        self.btnFeedProfile.layer.cornerRadius = 22
        self.btnFeedProfile.clipsToBounds = true
    }
    
    @objc func tapOnLike(){
        if let lickCount = self.dataObject?.likes, lickCount > 0 {
            self.delegate?.tapOnLike(for: self.dataObject)
        }
       
    }
    
    @objc func tapOnComment(){
        if let commentCount = self.dataObject?.comments, commentCount > 0 {
            self.delegate?.tapOnComment(for: self.dataObject)
        }
       // self.pushToNextController(controllerName: CommentSecond.loadController())
    }
    
    @objc func tapOnImageProfile(){
        self.delegate?.tapOnImageProfile(for: self.dataObject)
       // self.pushToNextController(controllerName: FollowerProfileVC.loadController())
        
    }
    
}

