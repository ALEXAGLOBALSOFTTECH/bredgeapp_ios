//
//  FeedViewVC.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class FeedViewVC: UIViewController {
    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    var postData : DataObject?
    @IBOutlet weak var descriptionLable: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionLable.text = postData?.description
        self.locationLabel.text = postData?.location
        self.userNameLable.text = "\(postData?.first_name ?? "")  \(postData?.last_name ?? "")"
        self.commentLabel.text =  "\(postData?.comments ?? 0)"
        self.likesLabel.text = "\(postData?.likes ?? 0)"
        
        if let i = postData?.profile_img, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(i)") {
            
            self.getProfileData(from: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async() {
                        let image = UIImage(named:"profileImg")
                        self.profileImageButton.setImage(image, for: .normal)
                    }
                    return
                }
                DispatchQueue.main.async() {
                    self.profileImageButton.setImage(UIImage(data: data), for: .normal)
                  }
            }
        }
        
        if let imgs = postData?.images{
            let arr = imgs.components(separatedBy: ",")
            if let f = arr.first,
               let url = URL(string: "http://bregeapptest.in/public/posts/\(f)") {
                self.getProfileData(from: url) { data, response, error in
                    guard let data = data, error == nil else {
                        DispatchQueue.main.async() {
                            let image = UIImage(named:"profileImg")
                            self.feedImageView.image = image
                        }
                        return
                    }
                    DispatchQueue.main.async() {
                        self.feedImageView.image = UIImage(data: data)
                    }
                }
            }
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    func getProfileData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    
    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        let vc = LikesVC.loadController()
        vc.postData = self.postData
        self.pushToNextController(controllerName: vc)
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        let vc = CommentsVC.loadController()
        vc.postData = self.postData
        self.pushToNextController(controllerName: vc)
    }
    
    @IBAction func btnForward(_ sender: UIButton) {
        self.goToPreviousController()
    }



}
