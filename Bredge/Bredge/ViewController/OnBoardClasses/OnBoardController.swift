//
//  OnBoardController.swift
//  Bredge
//
//  Created by suryaween on 08/09/22.
//

import UIKit

class OnBoardController: UIViewController {
    static let nibName = "OnBoardController"
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mainview1: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    var slidnumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.frame =  CGRect(x: mainview1.frame.origin.x, y:mainview1.frame.origin.y , width: mainview1.bounds.width, height: mainview1.bounds.height)
        view2.frame =  CGRect(x: mainview1.frame.origin.x, y:mainview1.frame.origin.y+mainview1.bounds.height/2 , width: mainview1.bounds.width, height: mainview1.bounds.height)
        view3.frame =  CGRect(x: mainview1.frame.origin.x, y:mainview1.frame.origin.y+mainview1.bounds.height/2 , width: mainview1.bounds.width, height: mainview1.bounds.height)
        mainview1.addSubview(view1)
        mainview1.addSubview(view2)
        mainview1.addSubview(view3)
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
        nextButton.setImage(UIImage.init(named: "onBordNext"), for: .normal)
       
    }
    override func viewDidLayoutSubviews() {

//        mainview1.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor , UIColor.systemBlue.cgColor,UIColor.systemPink.cgColor], isFromTopToBottom: false, frameWidth: self.mainview1.bounds)
        
        textContainerView.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor , ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor], isFromTopToBottom: true, frameWidth: self.textContainerView.bounds)
        textContainerView.roundCorners(corners: [.topLeft,.topRight], radius: 40)
        
    }
    @IBAction func nextButtonClicked(_ sender: Any) {
        slidnumber = slidnumber + 1
        if slidnumber == 2
        {
            nextButton.setImage(UIImage.init(named: "halfNext"), for: .normal)
            view2.animShow()
            view1.animHide()
        }
        else if slidnumber == 3{
            
          slidnumber = 0
            view3.animShow()
            view2.animHide()
            nextButton.setImage(UIImage.init(named: "completeNext"), for: .normal)
           
        }
        else
        {
            self.dismiss(animated: false)
        }
    }

    @IBAction func skipbtnClicked(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0, delay: 0, options: [.curveLinear],
                           animations: {
                            self.center.y -= self.bounds.height
                            self.layoutIfNeeded()

            },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
                })
        }
}
