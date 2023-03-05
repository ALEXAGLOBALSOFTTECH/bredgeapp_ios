//
//  RulerView.swift
//  Bredge
//
//  Created by rajeev arkvanshi on 01/03/23.
//

import Foundation

import UIKit

/*class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cmRulerView = RulerView(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        cmRulerView.backgroundColor = .white
        cmRulerView.unit = .centimeter
        view.addSubview(cmRulerView)
        
        let ftRulerView = RulerView(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        ftRulerView.backgroundColor = .white
        ftRulerView.unit = .feet
        view.addSubview(ftRulerView)
    }
}*/

enum RulerUnit {
    case centimeter
    case feet
}

class RulerView: UIView {
    
    let lineColor = UIColor.black
    let lineWidth: CGFloat = 1
    let textFont = UIFont.systemFont(ofSize: 10)
    let textPadding: CGFloat = 5
    
    let cmRulerLength: CGFloat = 200 // in points
    let cmRulerIncrement: CGFloat = 10 // in points
    
    let ftRulerLength: CGFloat = 100 // in points
    let ftRulerIncrement: CGFloat = 12 // in inches
    
    var unit: RulerUnit = .centimeter {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(lineWidth)
        
        let startX = rect.origin.x
        let endX = rect.origin.x + (unit == .centimeter ? cmRulerLength : ftRulerLength)
        let increment = unit == .centimeter ? cmRulerIncrement : ftRulerIncrement
        let longLineInterval = unit == .centimeter ? 5 : 1
        let conversionFactor = unit == .centimeter ? 1 : 30.48 // 1 foot = 30.48 centimeters
        
        for i in stride(from: startX, to: endX, by: increment) {
            let isLongLine = i.truncatingRemainder(dividingBy: increment * CGFloat(longLineInterval)) == 0
            
            context?.move(to: CGPoint(x: i, y: rect.origin.y))
            context?.addLine(to: CGPoint(x: i, y: isLongLine ? rect.origin.y + rect.height / 2 : rect.origin.y + rect.height / 4))
            context?.strokePath()
            
            if isLongLine {
                let value = Int(i / increment)
                let measurement = unit == .centimeter ? "\(value) cm" : "\(Double(value) / conversionFactor) ft"
                let textSize = measurement.size(withAttributes: [NSAttributedString.Key.font: textFont])
                let textX = i - textSize.width / 2
                let textY = rect.origin.y + rect.height / 2 + textPadding
                
                measurement.draw(at: CGPoint(x: textX, y: textY), withAttributes: [NSAttributedString.Key.font: textFont])
            }
        }
    }
}

