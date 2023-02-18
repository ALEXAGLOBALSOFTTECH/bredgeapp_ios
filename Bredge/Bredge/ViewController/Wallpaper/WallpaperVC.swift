//
//  WallpaperVC.swift
//  Bredge
//
//  Created by Magenta on 13/10/22.
//

import UIKit

class WallpaperVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var bgImage: UIView!
    
    // MARK: - Properties
    var arrColorImage = [ "colors","lightTheme","darkTheme","W_gallery"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.collectionView.register(UINib(nibName: WallpaperCell.cell, bundle: nil), forCellWithReuseIdentifier: WallpaperCell.cell)
        // Do any additional setup after loading the view.
    }

    // MARK: - Life Cycle
    
    @IBAction func btntapOnBack(_ sender:UIButton){
        self.goToPreviousController()
    }

}

extension WallpaperVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return self.arrColorImage.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WallpaperCell.cell, for: indexPath) as! WallpaperCell
            cell.bgImageView.image = UIImage(named:self.arrColorImage[indexPath.item])
            return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
          let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
          let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
          return CGSize(width: size, height: size)
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pushToNextController(controllerName: WallpaperChatPreviewVC.loadController())
    }
}

