//
//  BRSplashVC.swift
//  Bredge
//
//  Created by Magenta on 06/09/22.
//

import UIKit

class BRSplashVC: UIViewController {
    static let nibName = "BRSplashVC"
    @IBOutlet weak var splashImageView:UIImageView!
    
     let img1 = UIImage.init(named: "1")
     let img2 = UIImage.init(named: "2")
     let img3 = UIImage.init(named: "3")
     let img4 = UIImage.init(named: "4")
     let img5 = UIImage.init(named: "5")
     let img6 = UIImage.init(named: "6")
     let img7 = UIImage.init(named: "7")
     let img8 = UIImage.init(named: "8")
    let appDelegate = UIApplication.shared.delegate as? SceneDelegate
   
    var timerTest : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        let array = [img1,img2,img3,img4,img5,img6,img7,img8]
        self.startTimer()
        self.repeatAnimateImagesChanges(images: array as NSArray, imageView: splashImageView)
    }

    func startTimer () {
      guard timerTest == nil else { return }

      timerTest =  Timer.scheduledTimer(
          timeInterval: TimeInterval(3),
          target      : self,
          selector    : #selector(self.timerActionTest),
          userInfo    : nil,
          repeats     : true)
    }
    
    @objc func timerActionTest()  {
      
        let onboarding  = false // = UserDefaults.standard.bool(forKey: "OnBordingCompleted")
        
        DispatchQueue.main.async {
            
            if onboarding == false
            {
                
                self.callOnboardViewController()
                
            }else
            {
                self.setRootNavigationViewController()
            }
        }
        self.timerTest?.invalidate()
    }
    func setRootNavigationViewController()
    {
        let storyboard = UIStoryboard.init(name:"Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewController.nibName) as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func callOnboardViewController()
    {
        let vc = OnBoardController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: {
            UserDefaults.standard.set(true, forKey: "OnBordingCompleted")
            self.setRootNavigationViewController()
        }
        )
        
    }
    
    
    func repeatAnimateImagesChanges(images:NSArray, imageView:UIImageView) {
        if(images.count == 0) {
            return
        }
        var newImage = images.firstObject as! UIImage
        
        if(imageView.image != nil) {
            for i in 0..<images.count {
                newImage = images.object(at: i) as! UIImage
                if(splashImageView.image?.isEqual(newImage))! {
                    newImage = i == images.count - 1 ? images.firstObject as! UIImage : images.object(at: i + 1) as! UIImage
                }
            }
        }
        splashImageView.imageWithFade = newImage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.repeatAnimateImagesChanges(images: images, imageView: imageView)
        }
    }
}

extension UIImageView{
    var imageWithFade:UIImage?{
        get{
            return self.image
        }
        set{
            UIView.transition(with: self,
                              duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.image = newValue
            }, completion: nil)
        }
    }
}
