//
//  WallpaperCell.swift
//  Bredge
//
//  Created by Magenta on 13/10/22.
//

import UIKit

class WallpaperCell: UICollectionViewCell {

    static let cell = "WallpaperCell"
     
    // MARK: - Outlet
    @IBOutlet weak var bgImageView:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
