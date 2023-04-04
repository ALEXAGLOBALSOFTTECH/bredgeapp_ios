//
//  PhotoAndVideoCell.swift
//  Bredge
//
//  Created by Magenta on 16/09/22.
//

import UIKit

class PhotoAndVideoCell: UICollectionViewCell {
static let cell = "PhotoAndVideoCell"
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var view1:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func drawCell(with data:DataObject?){
        if let imgs = data?.images{
            let arr = imgs.components(separatedBy: ",")
            if let f = arr.first,
               let url = URL(string: "http://bregeapptest.in/public/posts/\(f)") {
                self.setImage(with: url, imageView: self.imgView, button:nil )
            }
            
        }
    }

}
