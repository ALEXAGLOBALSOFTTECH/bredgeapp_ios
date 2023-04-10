//
//  CommentsVC.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class CommentsVC: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    lazy var viewModel : DashboardAndFeedsViewModel = {
        let v = DashboardAndFeedsViewModel()
        v.delegate = self
        return v
    }()
    var postData : DataObject?
    var commentData : [DataObject]?{
        didSet{
            self.commentsTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentsTableView.register(UINib(nibName:CommentsCell.cell, bundle: nil),forCellReuseIdentifier: CommentsCell.cell)
        // Do any additional setup after loading the view.
        if let t = postData?.user_token, let id = postData?.id {
            self.viewModel.execute(with: .postCommentList(parameter: ["token":t, "post_id":"\(id)", "page":"1"]))
        }
    }
    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
}
extension CommentsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:CommentsCell.cell)  as!  CommentsCell
        cell.drawLikeCell(with: self.commentData?[indexPath.row])
        return cell
    }
}
extension CommentsVC : DashboardAndFeedsViewModelProtocol {
     func postCommentListResponse(with events:CommentList?){
        DispatchQueue.main.async {
            self.commentData = events?.dataObject
        }
    }
}
