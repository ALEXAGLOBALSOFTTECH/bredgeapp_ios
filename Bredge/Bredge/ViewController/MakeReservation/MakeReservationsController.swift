//
//  MakeReservationsController.swift
//  Bredge
//
//  Created by suryaween on 15/10/22.
//

import UIKit

class MakeReservationsController: UIViewController {

    @IBOutlet weak var makeReservationsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        makeReservationsButton.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: makeReservationsButton.bounds)
        makeReservationsButton.roundCorners(corners: [.topLeft,.topRight], radius: 24)
    }

    @IBAction func makeReservationButtonClicked(_ sender: Any) {
    }
    
    @IBAction func gotoBackButtonClicked(_ sender: UIButton) {
        goToPreviousController()
    }
}
