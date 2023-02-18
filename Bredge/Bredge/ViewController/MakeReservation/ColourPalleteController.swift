//
//  ColourPalleteController.swift
//  Bredge
//
//  Created by suryaween on 17/10/22.
//

import UIKit
import Combine
class ColourPalleteController: UIViewController {
    static let nibName = "ColourPalleteController"
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var selectedColorCode: UILabel!
    
    @IBOutlet weak var reselectColorBtn: UIButton!
    @IBOutlet weak var applyThemeButton: UIButton!
    var cancellable: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        invokeColorPickerController()
    
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initializeButtonColor()
      
    }
func invokeColorPickerController()
    {
        let picker = UIColorPickerViewController()
        picker.selectedColor = selectedColorView.backgroundColor!
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    func initializeButtonColor()
    {
        reselectColorBtn.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: reselectColorBtn.bounds)
        applyThemeButton.applyGradientColors(colors: [ColorConstants.OnboardingColor.onBoardingGradientColorTop.cgColor,ColorConstants.OnboardingColor.onBoardingGradientColorBottom.cgColor],isFromTopToBottom: false,frameWidth: applyThemeButton.bounds)
       
        
        
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        goToPreviousController()
    }
    @IBAction func reselectColour(_ sender: Any) {
        invokeColorPickerController()
    }
    @IBAction func applyThemeColor(_ sender: Any) {
    }
    
}
extension ColourPalleteController: UIColorPickerViewControllerDelegate {
    
    //  Called once you have finished picking the color.
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        selectedColorView.backgroundColor = viewController.selectedColor
        
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        selectedColorView.backgroundColor = viewController.selectedColor
//        let colorCode = hexStringFromColor(color: selectedColorView.backgroundColor)
        print(selectedColorView.backgroundColor?.hexCode)
        selectedColorCode.text = "#\(selectedColorView.backgroundColor?.hexCode ?? "")"
        
    }
}
extension UIColor
{
    func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
     }

    func colorWithHexString(hexString: String) -> UIColor {
        var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

        print(colorString)
        let alpha: CGFloat = 1.0
        let red: CGFloat = self.colorComponentFrom(colorString: colorString, start: 0, length: 2)
        let green: CGFloat = self.colorComponentFrom(colorString: colorString, start: 2, length: 2)
        let blue: CGFloat = self.colorComponentFrom(colorString: colorString, start: 4, length: 2)

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

        let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
        let endIndex = colorString.index(startIndex, offsetBy: length)
        let subString = colorString[startIndex..<endIndex]
        let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
        var hexComponent: UInt32 = 0

        guard Scanner(string: String(fullHexString)).scanHexInt32(&hexComponent) else {
            return 0
        }
        let hexFloat: CGFloat = CGFloat(hexComponent)
        let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
        print(floatValue)
        return floatValue
    }
}
extension UIColor {
    var hexCode: String {
        get{
            let colorComponents = self.cgColor.components!
            if colorComponents.count < 4 {
                return String(format: "%02x%02x%02x", Int(colorComponents[0]*255.0), Int(colorComponents[0]*255.0),Int(colorComponents[0]*255.0)).uppercased()
            }
            return String(format: "%02x%02x%02x", Int(colorComponents[0]*255.0), Int(colorComponents[1]*255.0),Int(colorComponents[2]*255.0)).uppercased()
        }
    }
}
