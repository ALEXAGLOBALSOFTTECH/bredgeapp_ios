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
    
    @IBOutlet weak var likeUnlikeButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    
    lazy var viewModel : DashboardAndFeedsViewModel = {
        let v = DashboardAndFeedsViewModel()
        v.delegate = self
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionLable.text = postData?.description
        self.locationLabel.text = postData?.location
        self.userNameLable.text = "\(postData?.first_name ?? "")  \(postData?.last_name ?? "")"
        self.commentLabel.text =  "\(postData?.comments ?? 0)"
        self.likesLabel.text = "\(postData?.likes ?? 0)"
        self.profileImageButton.layer.cornerRadius = 0.5 * self.profileImageButton.bounds.size.width
        self.profileImageButton.clipsToBounds = true
        
        // Set like Unlike status
        let img = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        self.likeUnlikeButton.setImage(img, for: .normal)
        if let liked = self.postData?.liked{
            if liked == 0 {
                self.likeUnlikeButton.tintColor = .white
                self.likeUnlikeButton.isSelected = false
            }else{
                self.likeUnlikeButton.tintColor = .purple
                self.likeUnlikeButton.isSelected = true
            }
        }
        
        if let i = postData?.profile_img, let url = URL(string: "http://bregeapptest.in/public/profile_image/\(i)") {
            
            self.getProfileData(from: url) { data, response, error in
                guard let d = data, error == nil else {
                    DispatchQueue.main.async() {
                        let image = UIImage(named:"profileImg")
                        self.profileImageButton.setImage(image, for: .normal)
                       
                    }
                    return
                }
                DispatchQueue.main.async() {
                    self.profileImageButton.setImage(UIImage(data: d), for: .normal)
                  }
            }
        }else{
            DispatchQueue.main.async() {
                let image = UIImage(named:"profileImg")
                self.profileImageButton.setImage(image, for: .normal)
               
            }
        }
        
        if let imgs = postData?.images{
            let arr = imgs.components(separatedBy: ",")
            if let f = arr.first,
               let url = URL(string: "http://bregeapptest.in/public/posts/\(f)") {
                self.getProfileData(from: url) { data, response, error in
                    guard let d = data, error == nil else {
                        DispatchQueue.main.async() {
                            let image = UIImage(named:"profileImg")
                            self.feedImageView.image = image
                        }
                        return
                    }
                    DispatchQueue.main.async() {
                        self.feedImageView.image = UIImage(data: d)
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
        
        self.viewModel.execute(with: .likeUnlikePost(parameter: ["token":UserDefaultHelper.token ?? "", "post_id":"\(self.postData?.id ?? 0)"]))
        
    }
    
    @IBAction func profileButtonClick(_ sender: Any) {
        let profilevc = FollowerProfileVC.loadController()
        profilevc.userId = "\(self.postData?.user_token ?? "")"
        self.pushToNextController(controllerName: profilevc)
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

extension FeedViewVC: DashboardAndFeedsViewModelProtocol {
    
    func postLikeUnlikeResponse(with events:CommonModel?){
        DispatchQueue.main.async {
            if self.likeUnlikeButton.isSelected {
                self.likeUnlikeButton.isSelected = false
                self.likeUnlikeButton.tintColor = .white
                if let c = self.postData?.likes{
                    if c > 0 {
                        self.postData?.likes = c - 1
                        self.postData?.liked = 0
                        self.likesLabel.text = "\(self.postData?.likes ?? 0)"
                    }
                }
            }else{
                self.likeUnlikeButton.tintColor = .purple
                self.likeUnlikeButton.isSelected = true
                if let c = self.postData?.likes{
                    self.postData?.likes = c + 1
                    self.postData?.liked = 1
                    self.likesLabel.text = "\(self.postData?.likes ?? 0)"
                }
            }
        }
    }
}
