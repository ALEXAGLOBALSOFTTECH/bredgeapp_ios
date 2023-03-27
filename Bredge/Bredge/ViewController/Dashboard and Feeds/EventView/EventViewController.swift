//
//  EventViewController.swift
//  Bredge
//
//  Created by suryaween on 15/09/22.
//

import UIKit

class EventViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    static let nibName = "EventViewController"
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var entryFeeTextField: UITextField!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet var endTimePicker: UIDatePicker!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var entryTypeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet var timePicker: UIDatePicker!
    
    var photoFromGalery : [[String:UIImage]] = [[:]] {
        didSet{
            self.eventCollectionView.reloadData()
            
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

        self.eventCollectionView.register(UINib(nibName: EventCollectionCell.cell, bundle: nil), forCellWithReuseIdentifier: EventCollectionCell.cell)
        self.descriptionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        AppUtility.addButtonForUIDatePicker(textField: self.dateTextField, viewController: self, picker: self.datePicker)
        AppUtility.addButtonForUIDatePicker(textField: self.startTimeTextField, viewController: self, picker: self.timePicker)
        AppUtility.addButtonForUIDatePicker(textField: self.endTimeTextField, viewController: self, picker: self.endTimePicker)
    }
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createEventButton.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: createEventButton.bounds)
       
    }
    @IBAction func createEventBtnClicked(_ sender: Any) {
        //self.goToPreviousController()
       
        self.viewModel.execute(with: .createEvent(parameter: ["token":UserDefaultHelper.token!, "description":self.descriptionTextView.text ?? "", "event_name":self.eventNameTextField.text ?? "", "event_date":self.dateTextField.text ?? "", "start_time":self.startTimeTextField.text ?? "", "end_time":self.endTimeTextField.text ?? "", "entry_fee":self.entryFeeTextField.text ?? "", "location":self.locationTextField.text ?? "", "event_type":self.eventTypeTextField.text ?? "", "image[]":self.photoFromGalery.removeFirst()]))
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
        return self.photoFromGalery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.cell, for: indexPath) as! EventCollectionCell
        if indexPath.row == 0 {
            cell.coverImageView.image = UIImage(named: "addButton")
            cell.deleteButton.isHidden = true
            cell.deleteButton.isUserInteractionEnabled = false
            cell.mainView.borderWidth = 1
            }else{
                
            cell.drawImage(with: self.photoFromGalery[indexPath.row]["BR_UploadImage_\(indexPath.row)"], for: "Events")
          }
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            imagePicker.startImagePicker(withSourceType: .photoLibrary) { [weak self] image in
                var name = "BR_UploadImage_"
                if let c = self?.photoFromGalery.count {
                    name.append("\(c)")
                }
                let collection = [name:image]
                self?.photoFromGalery.append(collection)
                
            }
        }
    }
    
}

extension EventViewController {
    override func cancelPicker(sender: UIBarButtonItem) {
            print("Sender Value \(sender.tag)")
             self.view.endEditing(true)
    }

    override func submitPicker(sender: UIBarButtonItem) {
        print("Sender Value \(sender.tag)")
          self.view.endEditing(true)
        switch sender.tag {
        case 10:
            self.dateTextField.text =  AppUtility.getStringFromDate(self.datePicker.date, "yyyy-MM-dd")
            break
        case 20:
            self.startTimeTextField.text = AppUtility.getInitialTime(currentTime: self.timePicker.date, interval: 1)
            break
        case 30:
            self.endTimeTextField.text = AppUtility.getInitialTime(currentTime: self.endTimePicker.date, interval: 1)
            break
        default:
            break
        }
       /* if sender.tag == 1 {
            self.textFieldGender.text = self.arrGender[selectedGenderIndex]
        }else if sender.tag == 2 {
            self.textFieldMarital.text = self.arrMaritalStatus[self.selectedMaritalIndex]
        }else{
            self.textFieldDate.text =  AppUtility.getStringFromDate(self.datePickerValue.date, "yyyy-MM-dd")
        }*/
    }
}

extension EventViewController : DashboardAndFeedsViewModelProtocol {
   
    
    
}

extension EventViewController : EventCollectionCellProtocol{
    func deleteImage(cell: EventCollectionCell) {
        if let indexPath = self.eventCollectionView.indexPath(for: cell){
            self.photoFromGalery.remove(at: indexPath.row)
        }
    }
}
