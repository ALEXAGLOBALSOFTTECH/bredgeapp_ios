//
//  EventCollectionCell.swift
//  Bredge
//
//  Created by suryaween on 16/09/22.
//

import UIKit
import Photos

protocol EventCollectionCellProtocol : AnyObject {
    func deleteImage(cell:EventCollectionCell)
}

class EventCollectionCell: UICollectionViewCell {
    weak var delegate : EventCollectionCellProtocol?
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    static let cell = "EventCollectionCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func drawImage(with img:UIImage?, for screen: String){
        switch screen{
        case "CreatePost":
            if let i = img {
                self.coverImageView.image = i
            }
            self.mainView.cornerRadius = 10
            self.coverImageView.layer.cornerRadius = 10
            self.mainView.borderWidth = 0
            break
        default:
            if let i = img {
                self.coverImageView.image = i
            }
            self.deleteButton.isHidden = false
            self.deleteButton.isUserInteractionEnabled = true
            self.mainView.borderWidth = 0
            break
        }
        
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        self.delegate?.deleteImage(cell: self)
    }
    
    override func layoutSubviews() {
        self.coverImageView.layer.masksToBounds = true
        self.mainView.cornerRadius = 10
        self.coverImageView.layer.cornerRadius = 10
    }
    
}
