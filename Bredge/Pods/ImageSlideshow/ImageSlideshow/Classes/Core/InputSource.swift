//
//  InputSource.swift
//  ImageSlideshow
//
//  Created by Petr Zvoníček on 14.01.16.
//
//

import UIKit

/// A protocol that can be adapted by different Input Source providers
@objc public protocol InputSource {
    /**
     Load image from the source to image view.
     - parameter imageView: Image view to load the image into.
     - parameter callback: Callback called after image was set to the image view.
     - parameter image: Image that was set to the image view.
     */
    func load(to imageView: UIImageView, with callback: @escaping (_ image: UIImage?) -> Void)

    /**
     Cancel image load on the image view
     - parameter imageView: Image view that is loading the image
    */
    @objc optional func cancelLoad(on imageView: UIImageView)
}

/// Input Source to load plain UIImage
@objcMembers
open class ImageSource: NSObject, InputSource {
    var image: UIImage

    /// Initializes a new Image Source with UIImage
    /// - parameter image: Image to be loaded
    public init(image: UIImage) {
        self.image = image
    }

    /// Initializes a new Image Source with an image name from the main bundle
    /// - parameter imageString: name of the file in the application's main bundle
    @available(*, deprecated, message: "Use `BundleImageSource` instead")
    public init?(imageString: String) {
        if let image = UIImage(named: imageString) {
            self.image = image
            super.init()
        } else {
            return nil
        }
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
       imageView.image = image
        callback(image)
    }
}

/// Input Source to load an image from the main bundle
@objcMembers
open class BundleImageSource: NSObject, InputSource {
    var imageString: String?
    var imgUrl : URL?
    /// Initializes a new Image Source with an image name from the main bundle
    /// - parameter imageString: name of the file in the application's main bundle
    public init(imageString: String) {
        self.imageString = imageString
        super.init()
    }
    public init(imgUrl:URL){
        self.imgUrl = imgUrl
        super.init()
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        if imageString == nil {
            self.loadFromURL(to: imageView) { i in
                callback(i)
            }
        }else{
            let image = UIImage(named: imageString ?? "defaultCoverImage")
            imageView.image = image
            callback(image)
        }
        
    }
    public func loadFromURL(to imageUrl: UIImageView, with callback: @escaping (UIImage?) -> Void){
        guard let img = imgUrl else {
            let image = UIImage(named:"defaultCoverImage")
            imageUrl.image = image
            callback(image)
            return
        }
        getData(from: img) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async() {
                        let image = UIImage(named:"defaultCoverImage")
                        imageUrl.image = image
                        callback(image)
                    }
                    return
                }
                 // always update the UI from the main thread
                DispatchQueue.main.async() {
                    imageUrl.image = UIImage(data: data)
                    callback(imageUrl.image)
                }
            }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

/// Input Source to load an image from a local file path
@objcMembers
open class FileImageSource: NSObject, InputSource {
    var path: String

    /// Initializes a new Image Source with an image name from the main bundle
    /// - parameter imageString: name of the file in the application's main bundle
    public init(path: String) {
        self.path = path
        super.init()
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        let image = UIImage(contentsOfFile: path)
        imageView.image = image
        callback(image)
    }
    
}
