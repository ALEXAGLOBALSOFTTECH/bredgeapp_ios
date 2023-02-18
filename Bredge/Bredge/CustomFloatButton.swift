//
//  CustomFloatButton.swift
//  Bredge
//
//  Created by suryaween on 14/09/22.
//

import Foundation
import UIKit
//@IBDesignable
class CustomFloatButton: UIButton {
    
//     @IBInspectable
//     var titleText: String? {
//          didSet {
//              self.setTitle(titleText, for: .normal)
//              self.setTitleColor(UIColor.black, for: .normal)
//         }
//     }

     override init(frame: CGRect){
         super.init(frame: frame)
     }

     required init?(aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
     override func layoutSubviews() {
         super.layoutSubviews()
         setup()
     }

     func setup() {
         self.clipsToBounds = true
         self.setImage(UIImage(named: "floatButton"), for: .normal)
         //self.addTarget(self, action: #selector(didTapGlobalButton), for: .touchUpInside)
     }
//     @objc func didTapGlobalButton() {
//        // self.next.goToPreviousController()
//    }
}
