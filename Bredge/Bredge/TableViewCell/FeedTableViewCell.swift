//
//  FeedTableViewCell.swift
//  Bredge
//
//  Created by Magenta on 12/09/22.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var btnFeedProfile: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var postTextLabel: UILabel!
    static let cell = "FeedTableViewCell"
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 14.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "9833EA") as Any]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        postTextLabel.attributedText =  self.contentView.colouringTags(stringValue: postTextLabel.text!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

