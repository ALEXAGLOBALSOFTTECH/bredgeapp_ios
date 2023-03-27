//
//  FollowerProfileVC.swift
//  Bredge
//
//  Created by Magenta on 13/09/22.
//

import UIKit

class FollowerProfileVC: UIViewController {
static let nibName = "FollowerProfileVC"
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
    
    var arrPhotoAndVideo = [ "s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3","s_1","s_2","s_3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: ProfileArchiveCell.cell, bundle: nil), forCellWithReuseIdentifier: ProfileArchiveCell.cell)
        self.videoVollectionView.register(UINib(nibName: PhotoAndVideoCell.cell, bundle: nil), forCellWithReuseIdentifier: PhotoAndVideoCell.cell)
        self.collectionView.reloadData()
        self.videoVollectionView.reloadData()
        self.bgImage.cornerRadius(usingCorners:[ .bottomLeft,.bottomRight], cornerRadit: CGSize(width:25, height: 25))
        // Do any additional setup after loading the view.
        
        self.viewModel.execute(with: .userProfile(parameter: ["token":UserDefaultHelper.token ?? ""]))
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
            return self.arrPhotoAndVideo.count
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
          
            cell.imgView.image = UIImage(named:self.arrPhotoAndVideo[indexPath.item])
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
    
}

extension FollowerProfileVC: LoginSignupViewModelProtocol {
    func updateUserProfileWithPostsDetail(detail : Profile?){
        DispatchQueue.main.async {
            
        }
    }
    func updateUserProfileWithUserDetail(detail : Profile?){
        self.viewModel.execute(with: .userProfileDetail(parameter: ["token":UserDefaultHelper.token ?? ""]))
         DispatchQueue.main.async {
            
         }
    }
}





