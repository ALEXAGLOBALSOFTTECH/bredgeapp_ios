//
//  SelectInterestsVC.swift
//  Bredge
//
//  Created by Magenta on 09/09/22.
//

import UIKit

class SelectInterestsVC: UIViewController {
    static let nibName = "SelectInterestsVC"
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!{
        didSet {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
        }
    }
    @IBOutlet weak var collectionView:UICollectionView!
   // var arrData:[String] = ["Nature","Adventure", "Movies", "Tech", "Mobile", "Filming" ,"Bio", "Stories","Science","Nature","Movies", "Tech", "Mobile","Adventure", "Movies", "Tech", "Mobile", "Filming" ,"Bio", "Stories","Science","Adventure", "Movies", "Tech","Adventure", "Movies", "Tech","Adventure", "Movies", "Tech"]
    var intrests = [InterestList]()
//    var arrData = [String]() // This is your data array
    var arrSelectedData = [Int]() //
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: SelectInterestCell.cell, bundle: nil), forCellWithReuseIdentifier: SelectInterestCell.cell)
        collectionView.allowsMultipleSelection = true
        self.getUserIntrest()
        // Do any additional setup after loading the view.
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        let filtered = intrests.filter{$0.isSelected == true}
        print(filtered)
        var itArr = [String]()
        filtered.forEach{
            if let id = $0.id {
                itArr.append("\(id)")
            }
        }
        let idString = itArr.joined(separator: ",")
        self.viewModel.execute(with: .storeUserIntrest(parameter: ["interest_id":idString, "token":UserDefaultHelper.token ?? ""]))
        
        
    }
}

extension SelectInterestsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.intrests.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectInterestCell.cell, for: indexPath) as! SelectInterestCell
        let intrest = self.intrests[indexPath.item]
        cell.lbltitle.text = self.intrests[indexPath.item].name
        if  intrest.isSelected == true {
            cell.bgView.backgroundColor = UIColor.init(hexString: "#A740E4")
            cell.lbltitle.textColor = UIColor.white
        }else{
            cell.bgView.backgroundColor = UIColor.white
            cell.lbltitle.textColor = UIColor.init(hexString: "#9833EA")
            
        }
        
       
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width:150, height: 44)
             let label = UILabel()
              label.text = self.intrests[indexPath.item].name
              label.textAlignment = .center
              label.font = UIFont(name: "Poppins-SemiBold", size: 12)
              label.sizeToFit()
              return CGSize(width: label.frame.width, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")

        if intrests[indexPath.row].isSelected == true {
            intrests[indexPath.row].isSelected = false
        }else{
            intrests[indexPath.row].isSelected = true
        }
        self.collectionView.reloadData()
    }
}


extension SelectInterestsVC {
    
    
    //MARK: GET ALL INTREST . .. . . . .
    func getUserIntrest() {
        
        self.view.endEditing(true)
        self.viewModel.execute(with: .All_Interest)
        /*TFSDataHelper.shared.getDataWith(serviceURL: BEnum.shared.S_Type(BEnum.B_Enum.All_Interest), completion: { isSuccess, resultDict in
            
            if (isSuccess == true) {
                
                DispatchQueue.main.async {
                    let response:[String:Any] = resultDict

                    print("Response_Data_ResponseData:\(resultDict):::\(response["success"] as? Bool ?? false)")
                    if (response["success"] as? Bool ?? false) == true {
                        
                        
                    }else {
                        
                        self.present(BEnum.shared.showAlert(message: response["message"] as? String ?? ""), animated: true)
                    }
                }
            }
        })*/
    }
}

extension SelectInterestsVC : LoginSignupViewModelProtocol {
    func updateUser(with status: String, message: String?) {
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
        }
    }
    func updateIntrestList(with success:Bool, intrestList:[InterestList]?){
        if let intrests = intrestList {
            self.intrests = intrests
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    func updateStoreUserIntrestResponse(success:Bool,message:String?){
        DispatchQueue.main.async {
            let vc: ConnectSocialVC = ConnectSocialVC(nibName:ConnectSocialVC.nibName, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
