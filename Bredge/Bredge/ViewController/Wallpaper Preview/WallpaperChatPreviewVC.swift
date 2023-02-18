//
//  WallpaperChatPreviewVC.swift
//  Bredge
//
//  Created by Magenta on 20/10/22.
//

import UIKit

class WallpaperChatPreviewVC: UIViewController {

    @IBOutlet weak var btnWallpaper:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSetWallpaper(_ sender: UIButton) {
       
       
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        goToPreviousController()
    }

}
