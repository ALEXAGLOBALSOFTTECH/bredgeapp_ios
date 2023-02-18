//
//  SpinController.swift
//  Bredge
//
//  Created by suryaween on 14/09/22.
//

import UIKit

class SpinController: UIViewController {

    @IBOutlet weak var spinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        spinButton.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: spinButton.bounds)
        spinButton.roundCorners(corners: [.topLeft,.topRight], radius: 24)
    }

    @IBAction func backbuttonClicked(_ sender: Any) {
        self.goToPreviousController()
    }
    
}
