//
//  SubscriptionVC.swift
//  Bredge
//
//  Created by Mac on 05/04/23.
//

import UIKit

class SubscriptionVC: UIViewController {
    static let nibName = "SubscriptionVC"
    @IBOutlet weak var subscriptionPlane: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscriptionPlane.register(UINib(nibName: SubscriptionCell.cell, bundle: nil), forCellWithReuseIdentifier: SubscriptionCell.cell)
        self.subscriptionPlane.reloadData()
//        subscriptionPlane.dataSource = self
//        subscriptionPlane.delegate = self
     

    }

}
extension SubscriptionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 3
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscriptionCell.cell, for: indexPath) as! SubscriptionCell
        return cell
        
    }
}
