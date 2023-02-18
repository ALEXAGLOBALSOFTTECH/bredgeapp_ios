//
//  ChatVC.swift
//  Bredge
//
//  Created by Magenta on 15/10/22.
//

import UIKit

class ChatVC: UIViewController {
    static let cell = "ChatVC"
    @IBOutlet weak var chatTableView: UITableView!
    // MARK: - IBOutlet
    @IBOutlet weak var viewDropDown:UIView!
    @IBOutlet weak var btnTakePhoto:UIView!
   
    let arrMessages = ["Hii","How are you?","I am good what about you?","Whats on bord today? Do we have anything concrete to represent?","Thanks You."]
    let receiverArrMessages = ["Hello","How are you?","I am good what about you?","Whats on board today? Do we have anything concrete to represent?","Thanks You."]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDropDown.layer.cornerRadius = 15
        self.chatTableView.register(UINib(nibName:SenderMessageCell.cell, bundle: nil),forCellReuseIdentifier: SenderMessageCell.cell)
      self.chatTableView.register(UINib(nibName:ReceiverMessageCell.cell, bundle: nil),forCellReuseIdentifier: ReceiverMessageCell.cell)

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        self.btnTakePhoto.applyGradient(colours: [UIColor.init(hexString: "#8925F0"), UIColor.init(hexString: "#F98AC7")], locations: [])
    }

    @IBAction func btnMenuAction(_ sender:UIButton)
    {
        if self.viewDropDown.isHidden == true
        {
            self.viewDropDown.isHidden = false
        }else
        {
            self.viewDropDown.isHidden = true
        }
    }
    @IBAction func btnTakePhoto(_ sender:UIButton)
    {
       // self.pushToNextController(controllerName: NotificationVC.loadController())
    }

    @IBAction func btnWallpaper(_ sender: UIButton) {
        self.pushToNextController(controllerName: WallpaperVC.loadController())
        self.viewDropDown.isHidden = true
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        goToPreviousController()
    }
}

extension ChatVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row % 2 == 0
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:SenderMessageCell.cell)  as?  SenderMessageCell else {
                   fatalError("failed to get reusable cell valueCell")
            }

                  cell.messageTextLabel.text = self.arrMessages[indexPath.row]
            
            return cell
        }
        else
        {
           
                guard let cell = tableView.dequeueReusableCell(withIdentifier:ReceiverMessageCell.cell)  as?  ReceiverMessageCell else {
                       fatalError("failed to get reusable cell valueCell")
                }
                    cell.messageTextLabel.text = self.receiverArrMessages[indexPath.row]
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
