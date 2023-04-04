//
//  SignUpVC.swift
//  Bredge
//
//  Created by Magenta on 08/09/22.
//

import UIKit
import CoreLocation
//import ImagePicker

class SignUpVC: UIViewController,UITextFieldDelegate {
    static let nibName = "SignUpVC"
    var rangeStart = Measurement(value: 1.0, unit: UnitLength.feet)
    var rangeLength = Measurement(value: Double(20), unit: UnitLength.feet)
    var segments = Array<RKSegmentUnit>()
    var moreMarkers = false
    var colorOverridesEnabled = false
    @IBOutlet weak var rulerView: RKMultiUnitRuler!
    var lat : String = ""
    var lon : String = ""
    var address : String = ""
    
    @IBOutlet weak var profilepicImage: UIImageView!
    @IBOutlet weak var view1,view2,view3,view4:UIView!
    @IBOutlet weak var textFieldDate     :UITextField!
    @IBOutlet weak var textFieldGender   :UITextField!
    @IBOutlet weak var textFieldMarital  :UITextField!
    @IBOutlet weak var textViewBio       :UITextView!
    @IBOutlet var datePickerValue        :UIDatePicker!
    @IBOutlet var genderPicker           :UIPickerView!
    @IBOutlet var MaritalPicker          :UIPickerView!
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    var arrGender                        = ["Male","Female","Other"]
    var arrMaritalStatus                 = ["Married","Unmarried","Other"]
    var selectedGenderIndex              = 0
    var selectedMaritalIndex             = 0
    
    var user_Email:String             = ""
    var user_Token:String             = ""
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    private lazy var imagePicker: ImagePickerProtocol = {
          let imagePicker = ImagePicker(parentViewController: self)
          return imagePicker
      }()
    
    //location manager
       lazy var locationManager: CLLocationManager = {
           var _locationManager = CLLocationManager()
           _locationManager.delegate = self
           _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           _locationManager.activityType = . automotiveNavigation
           _locationManager.distanceFilter = 10.0  // Movement threshold for new events
         //  _locationManager.allowsBackgroundLocationUpdates = true // allow in background

           return _locationManager
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilepicImage.layer.cornerRadius = 25
        self.textViewBio.text = "Describe yourself"
        self.textViewBio.textColor = UIColor.lightGray
        self.genderPicker.delegate = self
        self.MaritalPicker.delegate = self
        if #available(iOS 13.4, *) {
            self.datePickerValue?.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        AppUtility.addButtonForUIPicker(textField: self.textFieldGender, viewController: self, picker: self.genderPicker)
        AppUtility.addButtonForUIPicker(textField: self.textFieldMarital, viewController: self, picker: self.MaritalPicker)
        AppUtility.addButtonForUIDatePicker(textField: self.textFieldDate, viewController: self, picker: self.datePickerValue)
        // Do any additional setup after loading the view.
        self.rulerView.direction = .horizontal
        
        segments = self.createSegments()
        rulerView?.tintColor = UIColor(red: 0.15, green: 0.18, blue: 0.48, alpha: 1.0)
         rulerView?.delegate = self
        rulerView?.dataSource = self
        
        let initialValue = (self.rangeForUnit(UnitLength.feet).location + self.rangeForUnit(UnitLength.feet).length) / 2
        rulerView?.measurement = NSMeasurement(
                   doubleValue: Double(initialValue),
                   unit: UnitLength.centimeters)
        
        DispatchQueue.main.async { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }
        
       
    
        
        
    }

    @IBAction func takePicktureButtonClick(_ sender: Any) {
        imagePicker.startImagePicker(withSourceType: .photoLibrary) { [weak self] image in
            self?.profilepicImage.image = image
        }
       
    }
    @IBAction func BackBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtnClicked(_ sender: Any) {
        
        self.updateUserInfo()
    }
    
    
    override func cancelPicker(sender: UIBarButtonItem) {
            print("Sender Value \(sender.tag)")
             self.view.endEditing(true)
    }

    override func submitPicker(sender: UIBarButtonItem) {
        print("Sender Value \(sender.tag)")
          self.view.endEditing(true)
        if sender.tag == 1 {
            self.textFieldGender.text = self.arrGender[selectedGenderIndex]
        }else if sender.tag == 2 {
            self.textFieldMarital.text = self.arrMaritalStatus[self.selectedMaritalIndex]
        }else{
            self.textFieldDate.text =  AppUtility.getStringFromDate(self.datePickerValue.date, "yyyy-MM-dd")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profilepicImage.clipsToBounds = true
        self.profilepicImage.layer.cornerRadius = self.profilepicImage.bounds.height/2
    }
}

extension SignUpVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Describe yourself"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension SignUpVC: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == self.genderPicker {
        self.selectedGenderIndex = row
    }else if pickerView == self.MaritalPicker {
        self.selectedMaritalIndex = row
    }
    print("Name Value \(row)")
  }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            ///  pickerLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18.7)
            pickerLabel?.textAlignment = .center
        }
        
        if pickerView == self.genderPicker {
            pickerLabel!.text = self.arrGender[row]
        }else if pickerView == self.MaritalPicker {
            pickerLabel!.text = self.arrMaritalStatus[row]
        }
        pickerLabel?.textColor = .black
        return pickerLabel!
    }
}


extension SignUpVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == self.genderPicker {
        return self.arrGender.count
    } else {
        return self.arrMaritalStatus.count
    }
   
  }
}

extension SignUpVC : CLLocationManagerDelegate {
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = "\(locValue.latitude)"
        self.lon = "\(locValue.longitude)"
        CLGeocoder().reverseGeocodeLocation(locations[0]) { placemarks, error in
            if let p = placemarks,  p.count > 0 {
               
                    self.displayLocationInfo(placemark: p[0] as CLPlacemark)
                
            }
         }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
        
             self.address = "\(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
        
        
    }
    

    
    //MARK: Login User
    func updateUserInfo() {
        
        self.view.endEditing(true)
        
        
        let collection = ["BR_ProfileImage_":self.profilepicImage.image]
        self.viewModel.execute(with: .uploadprofileimage(parameter: ["token":UserDefaultHelper.token ?? "", "image":[collection]]))
        
        self.viewModel.execute(with: .UpdateProfile(parameter:[ "email": self.user_Email, "first_name": self.firstNameTF.text ?? "", "last_name": self.lastNameTF.text ?? "", "dob": self.textFieldDate.text ?? "", "contact": self.phoneNumberTF.text ?? "", "gender": self.textFieldGender.text ?? "", "marital_status": self.textFieldMarital.text ?? "", "height": "165", "height_unit": "Inch", "bio": self.textViewBio.text ?? "", "lat":self.lat, "lon":self.lon , "remember_token" : UserDefaultHelper.token ?? "" , "address": self.address ]))
        
      
    }
}
extension SignUpVC : LoginSignupViewModelProtocol {
    func updateUser(with status: String, message: String?) {
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
        }
    }
    
    func updateProfileResult(with message:String?, success:Bool){
        DispatchQueue.main.async {
            if success == true{
                let vc: SelectInterestsVC = SelectInterestsVC(nibName:SelectInterestsVC.nibName, bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
            }
        }
    }
    
}

extension SignUpVC : RKMultiUnitRulerDataSource, RKMultiUnitRulerDelegate{
    
    func createSegments() -> Array<RKSegmentUnit> {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .short
        formatter.unitOptions = .providedUnit
        let ftSegment = RKSegmentUnit(name: "Ft.", unit: UnitLength.feet, formatter: formatter)
        
        ftSegment.name = "Ft."
        ftSegment.unit = UnitLength.feet
       
        let ftMarkerTypeMax = RKRangeMarkerType(color: UIColor.blue, size: CGSize(width: 1.0, height: 50.0), scale: 1)
        ftMarkerTypeMax.labelVisible = false
        
       
        ftSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.purple, size: CGSize(width: 1.0, height: 20.0), scale: 0.1),
            RKRangeMarkerType(color: UIColor.darkGray, size: CGSize(width: 2.0, height: 50.0), scale: 0.5)]
        
        let cmsSegment = RKSegmentUnit(name: "cm", unit: UnitLength.centimeters, formatter: formatter)
        let cmsMarkerTypeMax = RKRangeMarkerType(color: UIColor.brown, size: CGSize(width: 1.0, height: 50.0), scale: 25.0)
        
        cmsSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.purple, size: CGSize(width: 1.0, height: 25.0), scale: 5.0)]
        
        
            ftSegment.markerTypes.append(ftMarkerTypeMax)
            cmsSegment.markerTypes.append(cmsMarkerTypeMax)
        
        ftSegment.markerTypes.last?.labelVisible = true
        cmsSegment.markerTypes.last?.labelVisible = true
        return [ftSegment, cmsSegment]
    }
    
    func unitForSegmentAtIndex(index: Int) -> RKSegmentUnit {
        return segments[index]
    }
    var numberOfSegments: Int {
        get {
            return segments.count
        }
        set {
        }
    }
    func rangeForUnit(_ unit: Dimension) -> RKRange<Float> {
        let locationConverted = rangeStart.converted(to: unit as! UnitLength)
        let lengthConverted = rangeLength.converted(to: unit as! UnitLength)
        return RKRange<Float>(location: ceilf(Float(locationConverted.value)),
                              length: ceilf(Float(lengthConverted.value)))
    }
    
    
    func styleForUnit(_ unit: Dimension) -> RKSegmentUnitControlStyle {
        let style: RKSegmentUnitControlStyle = RKSegmentUnitControlStyle()
        style.scrollViewBackgroundColor = UIColor.white // UIColor(red: 0.22, green: 0.74, blue: 0.86, alpha: 1.0)
        let range = self.rangeForUnit(unit)
        if unit == UnitLength.centimeters {
            
            style.textFieldBackgroundColor = UIColor.clear
            // color override location:location+40% red , location+60%:location.100% green
        } else {
            style.textFieldBackgroundColor = UIColor.clear
        }
        if (colorOverridesEnabled) {
            style.colorOverrides = [
                RKRange<Float>(location: range.location, length: 0.1 * (range.length)): UIColor.red,
                RKRange<Float>(location: range.location + 0.4 * (range.length), length: 0.2 * (range.length)): UIColor.green]
        }
        style.textFieldBackgroundColor = UIColor.clear
        style.textFieldTextColor = UIColor.black
        return style
    }
    
    func valueChanged(measurement: NSMeasurement) {
        print("value changed to \(measurement.doubleValue)")
    }
}



