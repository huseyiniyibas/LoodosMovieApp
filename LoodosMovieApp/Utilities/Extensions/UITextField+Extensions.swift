//
//  UITextField+Extensions.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import UIKit

extension UITextField {
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }

    @IBInspectable
    public var leftSpace: CGFloat {
        get {
            return 10
        }
        set {
            self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: self.frame.size.height))
            self.leftViewMode = .always
        }
    }

    @IBInspectable
    public var rightSpace: CGFloat {
        get {
            return 10
        }
        set {
            self.rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: self.frame.size.height))
            self.rightViewMode = .always
        }
    }
}
