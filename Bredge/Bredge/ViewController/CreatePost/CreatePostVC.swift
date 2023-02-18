//
//  CreatePostVC.swift
//  Bredge
//
//  Created by Magenta on 20/09/22.
//

import UIKit

class CreatePostVC: UIViewController {
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet var postPicker           :UIPickerView!
    @IBOutlet weak var textFieldPost   :UITextField!
    @IBOutlet weak var textViewDesc       :UITextView!
    var arrPostType                        = ["ABC","CDE","EFG"]
    var selectedPostIndex              = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textViewDesc.text = "Describe about yourself"
        textViewDesc.textColor = UIColor.lightGray
        self.eventCollectionView.register(UINib(nibName: EventCollectionCell.cell, bundle: nil), forCellWithReuseIdentifier: EventCollectionCell.cell)
        AppUtility.addButtonForUIPicker(textField: self.textFieldPost, viewController: self, picker: self.postPicker)
      
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        self.btnUpload.applyGradient(colours: [UIColor.init(hexString: "#8925F0"), UIColor.init(hexString: "#F98AC7")], locations: [])
        self.btnPublish.applyGradient(colours: [UIColor.init(hexString: "#8925F0"), UIColor.init(hexString: "#F98AC7")], locations: [])
        self.bgView.applyGradientColors(colors: [ ColorConstants.CreatePostGradientColor.secondGradient.cgColor,ColorConstants.CreatePostGradientColor.firstGradient.cgColor], isFromTopToBottom: true, frameWidth: bgView.bounds)
        self.bgView.cornerRadius = 15.0
    }
    @IBAction func btnBack(_ sender:UIButton)
    {
        self.goToPreviousController()
    }

}


extension CreatePostVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cell, for: indexPath) as! EventCollectionCell
            cell.coverImageView.image = UIImage(named: "defaultCoverImage")
            cell.deleteButton.isHidden = false
           cell.deleteButton.isUserInteractionEnabled = true
            cell.mainView.borderWidth = 0
    
        
      
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:120, height: 120)
    }
    
}

extension CreatePostVC:UIPickerViewDelegate
{
    override func submitPicker(sender: UIBarButtonItem) {
        print("Sender Value \(sender.tag)")
          self.view.endEditing(true)
            self.textFieldPost.text = self.arrPostType[selectedPostIndex]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
          self.selectedPostIndex = row
      print("Name Value \(row)")
    }
      
      func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
          var pickerLabel: UILabel? = (view as? UILabel)
          if pickerLabel == nil {
              pickerLabel = UILabel()
              ///  pickerLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18.7)
              pickerLabel?.textAlignment = .center
          }
              pickerLabel!.text = self.arrPostType[row]
          
          pickerLabel?.textColor = .black
          return pickerLabel!
      }
}

extension CreatePostVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   
        return self.arrPostType.count
   
  }
}
extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe about yourself"
            textView.textColor = UIColor.lightGray
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
