//
//  ImagesFromLibrery.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 19/03/23.
//

import Foundation
import Photos
import UIKit


protocol PhotoAlbumProtocol: AnyObject {
    func setPhotoFromLibrery(with list:PHFetchResult<PHAsset>?)
}
class PhotoAlbum {
    weak var delegate : PhotoAlbumProtocol?
   
    func getPhotoList(){
       
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                 self.delegate?.setPhotoFromLibrery(with: PHAsset.fetchAssets(with: .image, options: fetchOptions))
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            case .limited:
                break
            @unknown default:
                break
            }
        }
    }
    
   
  
}

extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
       let options = PHImageRequestOptions()
       options.version = .original
       PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
           guard let image = image else { return }
           switch contentMode {
           case .aspectFill:
               self.contentMode = .scaleAspectFill
           case .aspectFit:
               self.contentMode = .scaleAspectFit
           @unknown default:
               break
           }
           self.image = image
       }
      }
}




