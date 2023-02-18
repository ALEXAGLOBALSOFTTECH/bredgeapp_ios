//
//  NotificationVC.swift
//  Bredge
//
//  Created by Magenta on 17/10/22.
//

import UIKit

class NotificationVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var firstView:UIView!
    @IBOutlet weak var tblNotification:UITableView!
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblNotification.register(UINib(nibName:NotificationCell.cell, bundle: nil),forCellReuseIdentifier: NotificationCell.cell)
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        
        self.mainView.applyGradientColors(colors: [ ColorConstants.ApplicationGradientColor.firstGradient.cgColor,ColorConstants.CreatePostGradientColor.secondGradient.cgColor], isFromTopToBottom: true, frameWidth: mainView.bounds)
    /// blur effect 
        let backView = UIView(frame: firstView.bounds)
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        firstView.addSubview(backView)
        firstView.sendSubviewToBack(backView)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = firstView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backView.addSubview(blurEffectView)
        
        let backView2 = UIView(frame: searchView.bounds)
        backView2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        let blurEffect2 = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView2 = UIVisualEffectView(effect: blurEffect2)
        blurEffectView2.frame = searchView.bounds
        blurEffectView2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backView2.addSubview(blurEffectView2)
        searchView.addSubview(backView2)
        searchView.sendSubviewToBack(backView2)
        
        
    
    }
    @IBAction func btnBack(_ sender:UIButton) {
       self.goToPreviousController()
   }
    
    @IBAction func btnMenu(_ sender:UIButton){
        let vc: BottomSheet = BottomSheet(nibName: "BottomSheet", bundle:nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated:false, completion: nil)
    }

}

extension NotificationVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:NotificationCell.cell) as? NotificationCell else {
            fatalError("cell error")
        }
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.lblName.text = self.arrUserName[indexPath.row]
        cell.btnMenu.addTarget(self, action: #selector(btnMenuCell(_:)), for: .touchUpInside)
       
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUserName.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushToNextController(controllerName: CommentSecond.loadController())
    }
   
    @objc func btnMenuCell(_ sender:UIButton)
    {
        let vc: BottomSheet = BottomSheet(nibName: "BottomSheet", bundle:nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated:false, completion: nil)
    }
    
}
