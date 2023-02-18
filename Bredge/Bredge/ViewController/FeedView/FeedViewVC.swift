//
//  FeedViewVC.swift
//  Bredge
//
//  Created by Magenta on 19/09/22.
//

import UIKit

class FeedViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnback(_ sender: UIButton) {
        self.goToPreviousController()
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        self.pushToNextController(controllerName: LikesVC.loadController())
    }
    
    @IBAction func btnComment(_ sender: UIButton) {
        self.pushToNextController(controllerName: CommentsVC.loadController())
    }
    
    @IBAction func btnForward(_ sender: UIButton) {
        self.goToPreviousController()
    }



}
