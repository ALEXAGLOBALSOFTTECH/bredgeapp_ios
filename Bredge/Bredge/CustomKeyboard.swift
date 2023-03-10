//
//  File.swift
//  Bredge
//
//  Created by suryaween on 10/09/22.
//

import Foundation
import UIKit


class DigitButton: UIButton {
    var digit: Int = 0
}



class NumericKeyboard: UIView {
    weak var target: (UIKeyInput & UITextInput)?
    var useDecimalSeparator: Bool
   
    var numericButtons: [DigitButton] = (0...9).map {
        let button = DigitButton(type: .system)
        button.digit = $0
        button.setTitle("\($0)", for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 20.0)   //    .preferredFont(forTextStyle: .l)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapDigitButton(_:)), for: .touchUpInside)
        return button
    }

    var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⌫", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = "Delete"
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var decimalButton: UIButton = {
        let button = UIButton(type: .system)
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        button.setTitle(decimalSeparator, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.accessibilityLabel = decimalSeparator
        button.addTarget(self, action: #selector(didTapDecimalButton(_:)), for: .touchUpInside)
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.accessibilityTraits = [.keyboardKey]
        button.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        return button
    }()

    init(target: UIKeyInput & UITextInput, useDecimalSeparator: Bool = false) {
        self.target = target
        self.useDecimalSeparator = useDecimalSeparator
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

// MARK: - Actions

extension NumericKeyboard {
    @objc func didTapDigitButton(_ sender: DigitButton) {
        insertText("\(sender.digit)")
        //self.removeFromSuperview()
       
    }

    @objc func didTapDecimalButton(_ sender: DigitButton) {
        insertText(Locale.current.decimalSeparator ?? ".")
    }

    @objc func didTapDeleteButton(_ sender: DigitButton) {
        target?.deleteBackward()
    }
    @objc func didTapCancelButton(_ sender: DigitButton) {

        self.removeFromSuperview()
    }
    
    
}

// MARK: - Private initial configuration methods

private extension NumericKeyboard {
    func configure() {
     autoresizingMask = [.flexibleWidth, .flexibleHeight]
       // autoresizingMask = [.flexibleWidth, .flexibleHeight,.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleBottomMargin]
        self.setGradientBackground(firstColor: ColorConstants.OnboardingColor.onBoardingGradientColorTop ,  secondColor: ColorConstants.OnboardingColor.onBoardingGradientColorBottom)
        addButtons()
    }
    
    func addButtons() {
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.setGradientBackground(firstColor: ColorConstants.OnboardingColor.onBoardingGradientColorTop ,  secondColor: ColorConstants.OnboardingColor.onBoardingGradientColorBottom)
        addSubview(stackView)

        for row in 0 ..< 3 {
            let subStackView = createStackView(axis: .horizontal)
            stackView.addArrangedSubview(subStackView)

            for column in 0 ..< 3 {
                subStackView.addArrangedSubview(numericButtons[row * 3 + column + 1])
            }
        }

        let subStackView = createStackView(axis: .horizontal)
        stackView.addArrangedSubview(subStackView)

        if useDecimalSeparator {
            subStackView.addArrangedSubview(decimalButton)
        } else {
            let blank = UIView()
            blank.layer.borderWidth = 0.0
            blank.layer.borderColor = UIColor.darkGray.cgColor
           // subStackView.addArrangedSubview(blank)
        }

        subStackView.addArrangedSubview(numericButtons[0])
        subStackView.addArrangedSubview(deleteButton)
        subStackView.addArrangedSubview(cancelButton)
    }

    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        //stackView.setGradientBackground()
        return stackView
    }

    func insertText(_ string: String) {
        guard let range = target?.selectedRange else { return }

        if let textField = target as? UITextField, textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) == false {
            return
        }

        if let textView = target as? UITextView, textView.delegate?.textView?(textView, shouldChangeTextIn: range, replacementText: string) == false {
            return
        }

        target?.insertText(string)
    }
}

// MARK: - UITextInput extension

extension UITextInput {
    var selectedRange: NSRange? {
        guard let textRange = selectedTextRange else { return nil }

        let location = offset(from: beginningOfDocument, to: textRange.start)
        let length = offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}
