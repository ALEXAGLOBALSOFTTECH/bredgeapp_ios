//
//  ConnectionVC.swift
//  Bredge
//
//  Created by Magenta on 18/09/22.
//

import UIKit

class ConnectionVC: UIViewController {
    @IBOutlet weak var requestedBtn: UIButton!
    @IBOutlet weak var allRequestBtn: UIButton!
    @IBOutlet weak var allConnectionBtn: UIButton!
    @IBOutlet weak var connectionBackground: UIView!
    @IBOutlet weak var requestedView: UIView!
    @IBOutlet weak var allRequestView: UIView!
    @IBOutlet weak var allConnectionView: UIView!
    @IBOutlet weak var userListTableView: UITableView!
    var isMyEventactive:Bool = false
    var arrUserImage = ["u_1","u_2","u_3","u_4","u_5","u_6","u_7","u_8","u_9"]
    var arrUserName = ["Mike Gosling","Tahira Laetitia","Benjamin Hyacinthe","Elpidius Chaska","Heidrich Keanna","Marwin Callista","Tiwonge Nacho","Meryem Alaya","Bibek Eleri"]
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]()
    @IBOutlet weak var searchTextField: AppTextField! {
        didSet {
            searchTextField.setIcon(UIImage.init(named: "search")!)        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userListTableView.register(UINib(nibName:ConnectionListCell.cell, bundle: nil),forCellReuseIdentifier: ConnectionListCell.cell)
        // Do any additional setup after loading the view.
        allConnectionView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        requestedView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allRequestView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allConnectionView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: allConnectionView.bounds)
        requestedView.backgroundColor = .clear
        
        allConnectionBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        requestedBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
    }

    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
  func reloadTableView()
    {
        userListTableView.reloadData()
        self.userListTableView.layoutIfNeeded()
        self.userListTableView.beginUpdates()
        self.userListTableView.endUpdates()
    }
}

extension ConnectionVC{
    @IBAction func allConnectionClicked(_ sender: Any) {
        allConnectionView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        requestedView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allRequestView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allConnectionView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: allConnectionView.bounds)
        requestedView.backgroundColor = .clear
        
        allConnectionBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        requestedBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
        isMyEventactive = false
        reloadTableView()
    }
    

    @IBAction func allRequestedClicked(_ sender: Any) {
        allConnectionView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        requestedView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allRequestView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allRequestView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: allConnectionView.bounds)
        allConnectionView.backgroundColor = .clear

        allRequestBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        allRequestBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
        isMyEventactive = true
        reloadTableView()
    }
    @IBAction func RequestedClicked(_ sender: Any) {
        allConnectionView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        requestedView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        allRequestView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        requestedView.applyGradientColors(colors: [ColorConstants.EventViewColor.eventGradientColorFirst.cgColor , ColorConstants.EventViewColor.eventGradientColorSecond.cgColor], isFromTopToBottom: true, frameWidth: requestedView.bounds)
        requestedView.backgroundColor = .clear

        requestedBtn.setTitleColor(ColorConstants.EventViewColor.eventGradientColorFirst, for: .normal)
        requestedBtn.setTitleColor(UIColor(named: "BBBBBB"), for: .normal)
        isMyEventactive = true
        userListTableView.reloadData()
        reloadTableView()
    }
}
extension ConnectionVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrUserImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:ConnectionListCell.cell)  as!  ConnectionListCell
        cell.userProfile.image = UIImage(named: self.arrUserImage[indexPath.row])
        cell.userNameLable.text = self.arrUserName[indexPath.row]
        
        cell.lblFollow.textColor = UIColor.white
        

        if arrSelectedIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
           
            cell.lblFollow.text = "Unfollow"
        }
        else {
          
           
            cell.lblFollow.text = "Follow"
        }
        
       // cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strData = arrUserImage[indexPath.item]
         
         if arrSelectedIndex.contains(indexPath) {
             arrSelectedIndex = arrSelectedIndex.filter { $0 != indexPath}
             arrSelectedData = arrSelectedData.filter { $0 != strData}
         }
         else {
             arrSelectedIndex.append(indexPath)
             arrSelectedData.append(strData)
         }

          reloadTableView()


    }
    
    
    
}
