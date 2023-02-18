//
//  EventViewController.swift
//  Bredge
//
//  Created by suryaween on 15/09/22.
//

import UIKit

class EventViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    static let nibName = "EventViewController"
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createEventButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.eventCollectionView.register(UINib(nibName: EventCollectionCell.cell, bundle: nil), forCellWithReuseIdentifier: EventCollectionCell.cell)
        self.descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createEventButton.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: createEventButton.bounds)
       
    }
    @IBAction func createEventBtnClicked(_ sender: Any) {
        self.goToPreviousController()
    }
    @IBAction func backbuttonClicked(_ sender: Any) {
        self.goToPreviousController()
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
}
extension EventViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cell, for: indexPath) as! EventCollectionCell
        if indexPath.item != 0 {
            cell.coverImageView.image = UIImage(named: "defaultCoverImage")
            cell.deleteButton.isHidden = false
            cell.deleteButton.isUserInteractionEnabled = true
            cell.mainView.borderWidth = 0
        }
        else
        {
            cell.coverImageView.image = UIImage(named: "addButton")
            cell.deleteButton.isHidden = true
            cell.deleteButton.isUserInteractionEnabled = false
            cell.mainView.borderWidth = 1
        }
      
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:100, height: 100)
    }
    
}
