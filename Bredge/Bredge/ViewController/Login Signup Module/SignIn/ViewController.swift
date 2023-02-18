//
//  ViewController.swift
//  Bredge
//
//  Created by suryaween on 06/09/22.
//
import UIKit
//import RKMultiUnitRuler
class ViewController: UIViewController,UITextFieldDelegate,RKMultiUnitRulerDataSource, RKMultiUnitRulerDelegate {
    var rangeStart = Measurement(value: 3.0, unit: UnitLength.feet)
    var rangeLength = Measurement(value: Double(100), unit: UnitLength.feet)
    
    var colorOverridesEnabled = false
    var moreMarkers = false
    var direction: RKLayerDirection = .horizontal
    var segments = Array<RKSegmentUnit>()
    
    
    static let nibName = "ViewController"
    @IBOutlet weak var ruler: RKMultiUnitRuler?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    var attrs : [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 12.0) as Any,
        NSAttributedString.Key.foregroundColor : UIColor.init(named: "8925F0") as Any,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
    ]
    
    
    var attributedString = NSMutableAttributedString(string:"")
    
    lazy var viewModel : UserLoginSignupViewModel = {
        let v = UserLoginSignupViewModel()
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        ruler?.direction = direction
        //        ruler?.tintColor = UIColor(red: 0.15, green: 0.18, blue: 0.48, alpha: 1.0)
        //        segments = self.createSegments()
        //        ruler?.delegate = self
        //        ruler?.dataSource = self
        //
        //        let initialValue = (self.rangeForUnit(UnitLength.feet).location + self.rangeForUnit(UnitLength.feet).length) / 2
        //        ruler?.measurement = NSMeasurement(
        //            doubleValue: Double(initialValue),
        //            unit: UnitLength.centimeters)
        //
        //        let buttonTitleStr = NSMutableAttributedString(string:"Forgot Password?", attributes:attrs)
        //        attributedString.append(buttonTitleStr)
        //        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().isHidden = true
    }
    override func viewDidLayoutSubviews() {
        
        let text = "Don't have an account?"
        let attributedString2 = NSMutableAttributedString(string:text)
        let buttonTitleStr = NSMutableAttributedString(string:" SignUp", attributes:attrs)
        attributedString2.append(buttonTitleStr)
        signupButton.setAttributedTitle(attributedString2, for: .normal)
        UINavigationBar.appearance().isHidden = true
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if (self.emailTextField.text?.count ?? 0) == 0 {
            self.present(BEnum.shared.showAlert(message: "Please enter email id"), animated: true)
        }else if (!BEnum.shared.isValidEmail(testStr: self.emailTextField.text ?? "")) {
            self.present(BEnum.shared.showAlert(message: "Please enter valid email id"), animated: true)
        }else if ((self.passwordTextField.text?.count ?? 0) == 0) {
            self.present(BEnum.shared.showAlert(message: "Please enter password"), animated: true)
        }else {
            
            self.loginUser()
        }
        
        
    }
    @IBAction func forgotBtnClicked(_ sender: Any) {
        //        self.pushToNextController(controllerName: WallpaperVC.loadController())
        let vc: ForgotPasswordVC = ForgotPasswordVC(nibName:ForgotPasswordVC.nibName, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SignUpBtnClicked(_ sender: Any) {
        
        self.pushToNextController(controllerName: SignupViewController.loadController())
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func createSegments() -> Array<RKSegmentUnit> {
        let formatter = MeasurementFormatter()
        formatter.unitStyle = .medium
        formatter.unitOptions = .providedUnit
        let kgSegment = RKSegmentUnit(name: "Ft.", unit: UnitLength.feet, formatter: formatter)
        
        kgSegment.name = "Ft."
        kgSegment.unit = UnitLength.feet
        let kgMarkerTypeMax = RKRangeMarkerType(color: UIColor.blue, size: CGSize(width: 1.0, height: 50.0), scale: 5.0)
        kgMarkerTypeMax.labelVisible = false
        kgSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.purple, size: CGSize(width: 1.0, height: 20.0), scale: 0.5),
            RKRangeMarkerType(color: UIColor.darkGray, size: CGSize(width: 2.0, height: 50.0), scale: 1.0)]
        
        let lbsSegment = RKSegmentUnit(name: "cm", unit: UnitLength.centimeters, formatter: formatter)
        let lbsMarkerTypeMax = RKRangeMarkerType(color: UIColor.brown, size: CGSize(width: 1.0, height: 50.0), scale: 10.0)
        
        lbsSegment.markerTypes = [
            RKRangeMarkerType(color: UIColor.darkGray, size: CGSize(width: 1.0, height: 25.0), scale: 1.0)]
        
        if moreMarkers {
            kgSegment.markerTypes.append(kgMarkerTypeMax)
            lbsSegment.markerTypes.append(lbsMarkerTypeMax)
        }
        kgSegment.markerTypes.last?.labelVisible = true
        lbsSegment.markerTypes.last?.labelVisible = true
        return [kgSegment, lbsSegment]
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
            style.textFieldBackgroundColor = UIColor.red
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



extension ViewController {
    
    
    //MARK: Login User
    func loginUser() {
        
        self.view.endEditing(true)
       
        self.viewModel.execute(with: .LoginUser(parameter: ["email":self.emailTextField.text ?? "", "password":self.passwordTextField.text ?? "", "device_token":""]))
        
        /*TFSDataHelper.shared.postDataWith(request: COHeader.userLogin(self.emailTextField.text ?? "", self.passwordTextField.text ?? ""), serviceURL: BEnum.shared.S_Type(BEnum.B_Enum.LoginUser)) { isSuccess, resultDict in
            
            if (isSuccess == true) {
                
                DispatchQueue.main.async {
                    let response:[String:Any] = resultDict

                    print("Response_Data_ResponseData:\(resultDict):::\(response["success"] as? Bool ?? false)")
                    if (response["success"] as? Bool ?? false) == true {
                        
                        let dataOn = response["data"] as? [String:Any] ?? [:]
                       // UserDefaults.sessionToken = "\(dataOn["token"] as? Int ?? 0)"
                       // UserDefaults.isLoggedIn = true
                       // UserDefaults.standard.synchronize()
                        self.showHome()
                    }else {
                        
                        self.present(BEnum.shared.showAlert(message: response["message"] as? String ?? ""), animated: true)
                    }
                }
            }
        }*/
    }
    
    func showHome() {
        
        let w = self.view.window?.windowScene?.delegate as? SceneDelegate
        
              // let navigation = UINavigationController(rootViewController: viewController)
        w?.window?.rootViewController = DashboardController.loadController() // Your initial view controller.
        w?.window?.makeKeyAndVisible()
    }
}

extension ViewController : LoginSignupViewModelProtocol {
    func updateUser(with status: String, message: String?) {
        DispatchQueue.main.async {
            self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
            
        }
    }
    
    func updateLoginResult(with message:String?, success:Bool){
        DispatchQueue.main.async {
            if success == true{
                self.showHome()
            }else{
                self.present(BEnum.shared.showAlert(message: message ?? ""), animated: true)
                
            }
        }
    }
}
