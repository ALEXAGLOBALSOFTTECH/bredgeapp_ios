//
//  CreatePostVC.swift
//  Bredge
//
//  Created by Magenta on 20/09/22.
//

import UIKit


class CreatePostVC: UIViewController {
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet var postPicker           :UIPickerView!
    @IBOutlet weak var textFieldPost   :UITextField!
    @IBOutlet weak var textViewDesc       :UITextView!
    var arrPostType                        = ["ABC","CDE","EFG"]
    var selectedPostIndex              = 0
    
   
    
    
    var photoFromGalery : [[String:UIImage]] = [] {
        didSet{
            self.eventCollectionView.reloadData()
            self.pageController.numberOfPages = self.photoFromGalery.count
            self.pageController.reloadInputViews()
        }
    }
    private lazy var imagePicker: ImagePickerProtocol = {
          let imagePicker = ImagePicker(parentViewController: self)
          return imagePicker
      }()
    lazy var viewModel : DashboardAndFeedsViewModel = {
        let v = DashboardAndFeedsViewModel()
        v.delegate = self
        return v
    }()
    
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
    
    @IBAction func uploadImageButtonClick(_ sender: Any) {
        imagePicker.startImagePicker(withSourceType: .photoLibrary) { [weak self] image in
            var name = "BR_UploadImage_"
            if let c = self?.photoFromGalery.count {
                name.append("\(c)")
            }
            let collection = [name:image]
            self?.photoFromGalery.append(collection)
            
        }
    }
    
    @IBAction func publishButtonClick(_ sender: Any) {
        self.viewModel.execute(with: .createPost(parameter: ["token":UserDefaultHelper.token!, "description":textViewDesc.text ?? "", "image[]":self.photoFromGalery, "published_as":self.textFieldPost.text ?? "", "post_title":"Test123"]))
    }
    
    @IBAction func btnBack(_ sender:UIButton)
    {
        self.goToPreviousController()
    }

}


extension CreatePostVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoFromGalery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cell, for: indexPath) as! EventCollectionCell
          
        
        
        cell.drawImage(with: self.photoFromGalery[indexPath.row]["BR_UploadImage_\(indexPath.row)"], for:"CreatePost")
        cell.delegate = self
    
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

extension CreatePostVC : EventCollectionCellProtocol{
    func deleteImage(cell: EventCollectionCell) {
        if let indexPath = self.eventCollectionView.indexPath(for: cell){
            self.photoFromGalery.remove(at: indexPath.row)
        }
    }
}

extension CreatePostVC : DashboardAndFeedsViewModelProtocol {
   
    func createPostResponse(with status: CommonModel?){
        if let s = status?.success, s == true{
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}



