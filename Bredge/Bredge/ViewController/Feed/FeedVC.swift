//
//  DashboardVC.swift
//  Bredge
//
//  Created by Magenta on 12/09/22.
//

import UIKit

class FeedVC: UIViewController {
static let nibName = "FeedVC"
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnCreatePost:UIButton!
    @IBOutlet weak var btnConnect:UIButton!
    @IBOutlet weak var burgerStack:UIButton!
    var arrStoryImage = ["Mask Group 15","s_1","s_2","s_3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: StoryCollectionViewCell.cell, bundle: nil), forCellWithReuseIdentifier: StoryCollectionViewCell.cell)
        
        self.tableView.register(UINib(nibName:FeedTableViewCell.cell, bundle: nil),forCellReuseIdentifier: FeedTableViewCell.cell)
        self.collectionView.reloadData()
       // burgerStack.addTarget(self, action: #selector(SSASideMenu.presentLeftMenuViewController), for: .touchUpInside)
        
       // let nib = UINib(nibName: "FeedHeaderView", bundle: nil)
//                tableView.register(nib, forHeaderFooterViewReuseIdentifier: "FeedHeaderView")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLayoutSubviews() {
        self.btnCreatePost.applyGradient(colours: [UIColor.init(hexString: "#8925F0"), UIColor.init(hexString: "#F98AC7"), UIColor.init(hexString: "#F98AC7")], locations: [0.0, 0.5, 1.0])
        
        self.btnConnect.applyGradient(colours: [UIColor.init(hexString: "#FFBD31"), UIColor.init(hexString: "#FF6969"),UIColor.init(hexString: "#FF46C8")], locations: [0.0, 0.0, 0.0])
       
        
    }
    
    @IBAction func btnProfile(_ sender: Any) {
        self.pushToNextController(controllerName: FollowerProfileVC.loadController())
    }
    @IBAction func btnNotification(_ sender: Any) {
        self.pushToNextController(controllerName: NotificationVC.loadController())
    }
    
    @IBAction func btnConnections(_ sender: Any) {
         self.pushToNextController(controllerName: ConnectionVC.loadController())
        
    }
    @IBAction func btnCreatePost(_ sender: Any) {
         self.pushToNextController(controllerName: CreatePostVC.loadController())
        
    }
    @IBAction func menuButton(_ sender: Any) {
        UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: DashboardController())
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.goToPreviousController()
    }
    @IBAction func menuBtnClicked(_ sender: Any) {
        
        sideMenuViewController?._presentLeftMenuViewController()
        self.navigationController?.isNavigationBarHidden = true
        
    }
   
}
extension FeedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrStoryImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.cell, for: indexPath) as! StoryCollectionViewCell
        if indexPath.item != 0 {
            cell.view1.isHidden = true
            cell.btnAdd.isHidden = true
        }
        cell.imgStory.image = UIImage(named:self.arrStoryImage[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:100, height: 135)
    }
    
}

extension FeedVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:FeedTableViewCell.cell)  as!  FeedTableViewCell
        cell.btnFeedProfile.addTarget(self, action: #selector(tapOnImageProfile), for: .touchUpInside)
        cell.btnLike.addTarget(self, action: #selector(tapOnLike), for: .touchUpInside)
        cell.btnComment.addTarget(self, action: #selector(tapOnComment), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.pushToNextController(controllerName: FeedViewVC.loadController())
    }
    
    @objc func tapOnLike(){
        self.pushToNextController(controllerName: LikesVC.loadController())
    }
    
    @objc func tapOnComment(){
        self.pushToNextController(controllerName: CommentSecond.loadController())
    }
    
    @objc func tapOnImageProfile(){
        self.pushToNextController(controllerName: FollowerProfileVC.loadController())
        
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//           let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeedHeaderView")  as! FeedHeaderView
//
//           return view
//       }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 300.0
//    }
}
