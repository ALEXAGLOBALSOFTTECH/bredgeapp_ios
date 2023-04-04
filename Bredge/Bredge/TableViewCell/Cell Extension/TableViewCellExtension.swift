//
//  TableViewCellExtension.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 27/03/23.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func setImage(with url:URL, imageView:UIImageView? = nil, button: UIButton? = nil){
        self.getProfileData(from: url) { data, response, error in
            guard let data = data, error == nil else {
            self.setImageOn(imageView: imageView, button: button, with: UIImage(named:"defaultCoverImage"))
            return
            }
            self.setImageOn(imageView: imageView, button: button, with: UIImage(data: data))
        }
    }
    
func setImageOn(imageView:UIImageView?, button:UIButton?, with image:UIImage?){
        DispatchQueue.main.async() {
            if imageView != nil {
                imageView?.image = image
            }else if button != nil {
                button?.setImage(image, for: .normal)
            }
        }
    }
    
    func getProfileData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension UITableViewCell {
    
    func setImage(with url:URL, imageView:UIImageView? = nil, button: UIButton? = nil){
        self.getProfileData(from: url) { data, response, error in
            guard let data = data, error == nil else {
            self.setImageOn(imageView: imageView, button: button, with: UIImage(named:"defaultCoverImage"))
            return
            }
            self.setImageOn(imageView: imageView, button: button, with: UIImage(data: data))
        }
    }
    
func setImageOn(imageView:UIImageView?, button:UIButton?, with image:UIImage?){
        DispatchQueue.main.async() {
            if imageView != nil {
                imageView?.image = image
            }else if button != nil {
                button?.setImage(image, for: .normal)
            }
        }
    }
    
    func getProfileData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
