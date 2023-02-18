//
//  UIView+Common.swift
//  Bredge
//
//  Created by suryaween on 08/09/22.
//

import Foundation
import UIKit
import UIKit.UITextField


// MARK: - Gradient



extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func cornerRadius(usingCorners corners: UIRectCorner, cornerRadit: CGSize)
    {
        let path = UIBezierPath( roundedRect: self.bounds,
                                 byRoundingCorners: corners, cornerRadii: cornerRadit)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
    }

    func setGradientBackground(firstColor:UIColor,secondColor:UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.frame = CGRect(x: 0,y: 0,width: 440,height: 400)
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           layer.mask = mask
       }


    func applyGradientColors(colors: [CGColor],isFromTopToBottom:Bool,frameWidth:CGRect)
        {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = frameWidth
            gradientLayer.colors = colors
            if isFromTopToBottom == true
            {
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            }
            else
            {
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            }
           
            clipsToBounds       = true
            layer.masksToBounds = true
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
}



extension UIColor{
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension UIImageView {
    @IBInspectable
    var changeColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!);
            return color
        }
        set {
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        }
    }
}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        guard let characterSpacing = characterSpacing else {return attributedString}
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
private var maxLengths = NSMapTable<UITextField, NSNumber>(keyOptions: NSPointerFunctions.Options.weakMemory, valueOptions: NSPointerFunctions.Options.strongMemory)

extension UITextField {

    var maxLength: Int? {
        get {
            return maxLengths.object(forKey: self)?.intValue
        }
        set {
            removeTarget(self, action: #selector(limitLength), for: .editingChanged)
            if let newValue = newValue {
                maxLengths.setObject(NSNumber(value: newValue), forKey: self)
                addTarget(self, action: #selector(limitLength), for: .editingChanged)
            } else {
                maxLengths.removeObject(forKey: self)
            }
        }
    }

    @IBInspectable var maxLengthInspectable: Int {
        get {
            return maxLength ?? Int.max
        }
        set {
            maxLength = newValue
        }
    }

    @objc private func limitLength(_ textField: UITextField) {
        guard let maxLength = maxLength, let prospectiveText = textField.text, prospectiveText.count > maxLength else {
            return
        }
        let selection = selectedTextRange
                let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
                text = prospectiveText.substring(to: maxCharIndex)
                selectedTextRange = selection
    }
}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
        
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 7
//        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    
    
    func colouringTags(stringValue:String)-> (NSMutableAttributedString)
    {
        let tweet = stringValue

        let words = tweet.components(separatedBy: " ")

        let attrString = NSMutableAttributedString(string: tweet)

        for word in words {

            if word.hasPrefix("#") {

                // Colour your 'word' here
                let matchRange = (tweet as NSString).range(of: word)

                attrString.addAttribute(
                    .foregroundColor,
                    value: UIColor.init(named: "FB447D") as Any,
                    range: matchRange)
    }
            if word.hasPrefix("@") {

                // Colour your 'word' here
                let matchRange = (tweet as NSString).range(of: word)

                attrString.addAttribute(
                    .foregroundColor,
                    value: UIColor.init(named: "CA0FB3") as Any,
                    range: matchRange)
    }
            
                }
        
        return attrString
    
}
    
}

extension UIViewController{
    func goToPreviousController()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        UINavigationBar.appearance().isHidden = true
    }
    class func loadController() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
    }

    func pushToNextController(controllerName:UIViewController)  {
       
        self.navigationController?.pushViewController(controllerName, animated: true)
}
}
extension UITextView {

    func addDoneButton(title: String, target: Any, selector: Selector) {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String , color:UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        self.attributedText = attribute
    }
}
