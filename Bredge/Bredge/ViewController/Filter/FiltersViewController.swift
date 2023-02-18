//
//  FiltersViewController.swift
//  Bredge
//
//  Created by suryaween on 18/09/22.
//

import UIKit

class FiltersViewController: UIViewController {

    @IBOutlet var ratingButton: [UIButton]!
   
    @IBOutlet var popularityButtons: [UIButton]!
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var adventureCollectionView: UICollectionView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    let typeImage = ["popular","casino","bar","music","new"]
    let foodImage = ["seafood","steak","mexican","asian"]
    let adventureText = ["Art","Attractions","Culture","Beliefs","Career","Game","Food","Bar","Hobbies","Music","Social","Sports","Tech"]
    
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 12.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "8925F0") as Any,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    var attributedString = NSMutableAttributedString(string:"")
    @IBOutlet weak var clearAllBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitleStr = NSMutableAttributedString(string:"Clear All", attributes:attrs)
        attributedString.append(buttonTitleStr)
        clearAllBtn.setAttributedTitle(attributedString, for: .normal)
        
        self.typeCollectionView.register(UINib(nibName: FilterCell.cell, bundle: nil), forCellWithReuseIdentifier: FilterCell.cell)
        self.foodCollectionView.register(UINib(nibName: FilterCell.cell, bundle: nil), forCellWithReuseIdentifier: FilterCell.cell)
        self.adventureCollectionView.register(UINib(nibName: AdventureCell.cell, bundle: nil), forCellWithReuseIdentifier: AdventureCell.cell)
        
        
    }
    @IBAction func gotoBackButtonClicked(_ sender: UIButton) {
        goToPreviousController()
    }
    
    @IBAction func selectionButtonClicked(_ sender: UIButton) {
        
        for button in ratingButton
        {
           if button.tag == sender.tag
            {
               button.setImage(UIImage(named: "selected"), for: .normal)
           }
            else
            {
                button.setImage(UIImage.init(named: "unselected"), for: .normal)
            }
        }
    }
    
    @IBAction func popularityBtnClicked(_ sender: UIButton) {
        
        for button in popularityButtons
        {
           if button.tag == sender.tag
            {
               button.backgroundColor = UIColor(named: "A740E4")
               button.setTitleColor(.white, for: .normal)
           }
            else
            {
                button.backgroundColor = .clear
                button.setTitleColor(UIColor(named: "9833EA"), for: .normal)
            }
        }
        
        
    }
    override func viewDidLayoutSubviews() {
       
        adventureCollectionView.reloadData()
        
    }


}
extension FiltersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.typeCollectionView {
            return typeImage.count
        }
        else if collectionView == self.adventureCollectionView    {
            return adventureText.count
        }
        else
        {
            return foodImage.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        if collectionView == self.typeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.cell, for: indexPath) as! FilterCell
            cell.filterimageView.image = UIImage(named: typeImage[indexPath.row])
            cell.namelabel.text = typeImage[indexPath.row].capitalized
            return cell
        } else if collectionView == self.foodCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.cell, for: indexPath) as! FilterCell
            cell.filterimageView.image = UIImage(named: foodImage[indexPath.row])
            cell.namelabel.text = foodImage[indexPath.row].capitalized
        
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdventureCell.cell, for: indexPath) as! AdventureCell
            cell.nameLabel.text = adventureText[indexPath.row].capitalized
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.adventureCollectionView
        {
            return CGSize(width:100, height: 50)
        }
        else
        {
            return CGSize(width:60, height: 100)
        }
    }

}
