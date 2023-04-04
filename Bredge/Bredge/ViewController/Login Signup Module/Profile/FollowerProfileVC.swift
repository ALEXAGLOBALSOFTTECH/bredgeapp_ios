//
//  FollowerProfileVC.swift
//  Bredge
//
//  Created by Magenta on 13/09/22.
//

import UIKit

class FollowerProfileVC: UIViewController {
static let nibName = "FollowerProfileVC"
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var bioLablel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var postLable: UILabel!
    @IBOutlet weak var followingLable: UILabel!
    @IBOutlet weak var followerLbale: UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var followStack: UIStackView!
    @IBOutlet weak var videoVollectionView:UICollectionView!
    @IBOutlet weak var bgImage: UIView!
    var arrStoryImage = [ "s_1","s_1","s_2","s_3","s_1"]
    @IBOutlet weak var messageStack: UIStackView!
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    var userId: String = ""
    
    var userPosts : [DataObject]? {
        didSet{
            self.videoVollectionView.reloadData()
        }
    }
    
    var arrPhotoAndVideo = [ "s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: ProfileArchiveCell.cell, bundle: nil), forCellWithReuseIdentifier: ProfileArchiveCell.cell)
        self.videoVollectionView.register(UINib(nibName: PhotoAndVideoCell.cell, bundle: nil), forCellWithReuseIdentifier: PhotoAndVideoCell.cell)
        self.collectionView.reloadData()
        self.videoVollectionView.reloadData()
        self.bgImage.cornerRadius(usingCorners:[ .bottomLeft,.bottomRight], cornerRadit: CGSize(width:25, height: 25))
        // Do any additional setup after loading the view.
        
        self.viewModel.execute(with: .userProfile(parameter: ["token":userId]))
    }
    @IBAction func btnFollow(_ sender: UIButton) {
      
        if self.messageStack.isHidden == true {
            self.followStack.isHidden = true
            self.messageStack.isHidden = false
        }else
        {
            self.followStack.isHidden = true
            self.messageStack.isHidden = false
        }
        
    }
    
    @IBAction func btnFollowing(_ sender: UIButton) {
        if self.messageStack.isHidden == true {
            self.followStack.isHidden = false
            self.messageStack.isHidden = true
        }else
        {
            self.followStack.isHidden = false
            self.messageStack.isHidden = true
        }
    }
    @IBAction func btnMessage(_ sender: UIButton) {
   
        self.pushToNextController(controllerName: MessageListVC.loadController())
        
        
    }
    @IBAction func gotoBackClick(_ sender: Any) {
        self.goToPreviousController()
    }
   

}
extension FollowerProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.arrStoryImage.count
        }else
        {
            return self.userPosts?.count ?? 0
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileArchiveCell.cell, for: indexPath) as! ProfileArchiveCell
            cell.imgStory.image = UIImage(named:self.arrStoryImage[indexPath.item])
            return cell
        }else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAndVideoCell.cell, for: indexPath) as! PhotoAndVideoCell
          
            //cell.imgView.image = UIImage(named:self.arrPhotoAndVideo[indexPath.item])
            cell.drawCell(with: self.userPosts?[indexPath.row])
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
        return CGSize(width:100, height: 135)
        }else
        {
            return CGSize(width:115, height: 115)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = FeedViewVC.loadController()
        vc.postData = self.userPosts?[indexPath.row]
        self.pushToNextController(controllerName: vc)
    }
    
}

extension FollowerProfileVC: LoginSignupViewModelProtocol {
    func updateUserProfileWithPostsDetail(detail : Profile?){
        DispatchQueue.main.async {
            self.followerLbale.text = "\(detail?.followerCount ?? 0)"
            self.followingLable.text = "\(detail?.followeringCount ?? 0)"
            self.postLable.text = "\(detail?.postCount ?? 0)"
            self.userPosts = detail?.posts?.dataObject
        }
    }
    func updateUserProfileWithUserDetail(detail : Profile?){
        self.viewModel.execute(with: .userProfileDetail(parameter: ["token":UserDefaultHelper.token ?? ""]))
         DispatchQueue.main.async {
             self.nameLable.text = "\(detail?.first_name ?? "")  \(detail?.last_name ?? "")"
             self.bioLablel.text = detail?.bio
             
         }
    }
}





